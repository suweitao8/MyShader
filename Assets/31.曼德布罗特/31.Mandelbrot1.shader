Shader "Unlit/31.Mandelbrot1"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _ScaleAndOffset ("ST", Vector) = (0, 0, 4, 4)
        _Angle ("Angle", range(0, 360)) = 0
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

            sampler2D _MainTex;
            float4 _MainTex_ST, _ScaleAndOffset;
            float _Angle;

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
                half2 uv;
                Unity_Rotate_Degrees_half(i.uv, half2(0.5, 0.5), _Angle, uv);
                uv = uv * _ScaleAndOffset.zw + _ScaleAndOffset.xy;
                half2 newUV;
                float x = 0;
                for (x = 0; x < 255; x++)
                {
                    newUV = uv + half2(newUV.x * newUV.x - newUV.y * newUV.y, 2 * newUV.x * newUV.y);
                    if (length(newUV) > 2) break;
                }
                return x / 255;
            }
            ENDCG
        }
    }
}
