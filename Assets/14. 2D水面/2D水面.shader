Shader "Unlit/2D水面"
{
    Properties
    {
        [HideInInspector] _MainTex ("Texture", 2D) = "white" {}
        _RenderTex ("Render Texture", 2D) = "white" {}
        _Color ("Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "Assets/ShaderGraph.cginc"

            sampler2D _RenderTex, _MainTex;
            half4 _MainTex_ST;
            half3 _Color;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 pos : SV_POSITION;
                half2 noiseUV : TEXCOORD1;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                Unity_TilingAndOffset_float(v.uv, half2(1,1), half2(0, 0.1 * _Time.y), o.noiseUV);
                return o;
            }

            half4 frag (v2f i) : SV_Target
            {
                half noise;
                half2 uv = half2(i.uv.x, 1. - i.uv.y);
                Unity_SimpleNoise_float(i.noiseUV, 30, noise);
                Unity_TilingAndOffset_float(uv, half2(1,1), half2((noise - 0.5) * 0.2, 0) * uv.y, uv);
                half3 col = tex2D(_RenderTex, uv).rgb * _Color;
                return half4(col, 1.0);
            }
            ENDCG
        }
    }
}
