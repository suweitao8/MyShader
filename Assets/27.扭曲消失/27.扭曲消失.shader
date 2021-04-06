Shader "Unlit/27.扭曲消失"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Center ("Center", Vector) = (0.5, 0.5, 0, 0)
        _Strength ("Strength", float) = 1
        _Process ("Process", Range(0,1)) = 0
    }
    SubShader
    {
        Tags { 
            "RenderType"="Transparent"
            "Queue"="Transparent"
            "IgnoreProjector"="True"
            "ForceNoShadowCasting"="True"
        }
        Blend SrcAlpha OneMinusSrcAlpha
        Zwrite Off


        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "Assets/ShaderGraph.cginc"

            sampler2D _MainTex;
            half4 _MainTex_ST;
            half3 _Center;
            half _Strength, _Process;

            struct appdata
            {
                half4 vertex : POSITION;
                half2 uv : TEXCOORD0;
            };

            struct v2f
            {
                half2 uv : TEXCOORD0;
                half4 pos : SV_POSITION;
                half4 posWS : TEXCOORD1;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.posWS.xy = mul(unity_ObjectToWorld, v.vertex).xy;
                o.posWS.zw = mul(unity_ObjectToWorld, _Center).zw;
                return o;
            }

            half4 frag (v2f i) : SV_Target
            {
                half twirl;
                half2 twirlUV;
                half4 col = tex2D(_MainTex, i.uv);
                Unity_Twirl_half(i.posWS.xy, _Center.xy, _Strength, half2(0,0), twirlUV);
                Unity_SimpleNoise_half(twirlUV, 1.0, twirl);
                twirl = smoothstep(_Process - 0.1, _Process, twirl);
                col.a = col.a * twirl;
                return col;
            }
            ENDCG
        }
    }
}
