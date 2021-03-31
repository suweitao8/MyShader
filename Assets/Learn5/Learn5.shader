Shader "Unlit/Learn5"
{
    Properties
    {
        [HideInInspector] _MainTex ("Texture", 2D) = "white" {}
        _Process ("Process", Range(0,1)) = 0.5
        _OneColor ("One Color", Color) = (0,1,0,1)
        _ZeroColor ("Zero Color", Color) = (1,0,0,1)
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

            sampler2D _MainTex;
            float4 _MainTex_ST;
            half4 _OneColor, _ZeroColor;
            half _Process;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                half4 color : COLOR;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 pos : SV_POSITION;
                half4 color : COLOR;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.color = v.color;
                return o;
            }

            half4 frag (v2f i) : SV_Target
            {
                half4 col = tex2D(_MainTex, i.uv);
                half process = step(_Process, i.uv.y);

                col = lerp(_OneColor, _ZeroColor, process) * col * i.color;
                return col;
            }
            ENDCG
        }
    }
}
