Shader "Unlit/28.花"
{
    Properties
    {
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
                o.uv = v.uv;
                return o;
            }

            half4 frag (v2f i) : SV_Target
            {
                half2 uv = i.uv;
                uv -= 0.5; // -0.5 0.5
                half2 polar = half2(atan2(uv.x, uv.y), length(uv));

                uv = half2(polar.x / UNITY_TWO_PI + 0.5 + _Time.y, polar.y);
                half x5 = uv.x * 6;
                half m = min(frac(x5), frac(1 - x5));
                half f = smoothstep(0, 0.01, m * 0.5 + 0.2 - uv.y);
                
                half Out = f;
                return half4(Out, Out, Out, 1);
            }
            ENDCG
        }
    }
}
