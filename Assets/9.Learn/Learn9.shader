Shader "Unlit/Learn9"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        [HDR] _LitColor ("Lit Color", Color) = (1,1,0,1)
        _Process ("Process", Range(0, 1)) = 0
        _LitRange ("Process", Range(0, 0.3)) = 0.1
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
            float4 _MainTex_ST;
            half3 _LitColor;
            half _Process, _LitRange;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 pos : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            half4 frag (v2f i) : SV_Target
            {
                half noise, litNoise, lit;
                half4 col;

                Unity_SimpleNoise_float(i.uv, 100., noise);
                litNoise = step(_Process - _LitRange, noise);
                noise = step(_Process, noise);
                lit = litNoise - noise;
                col= tex2D(_MainTex, i.uv);
                return half4(lerp(col.rgb, _LitColor, lit), col.a * litNoise);
            }
            ENDCG
        }
    }
}
