Shader "Unlit/31.Mandelbrot"
{
    Properties
    {
        [HideInInspector] _MainTex ("Texture", 2D) = "white" {}
        _Area ("Area", Vector) = (0, 0, 4, 4)
        _Angle ("Angle", Range(0, 360)) = 0
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
            float4 _MainTex_ST, _Area;
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
                o.uv = v.uv;
                return o;
            }

            float2 rot(float2 p, float2 pivot, float a)
            {
                float s = sin(a);
                float c = cos(a);
                p -= pivot;
                p = float2(p.x * c - p.y * s, p.x * s + p.y * c);
                p += pivot;
                return p;
            }

            half4 frag (v2f i) : SV_Target
            {
                float2 c = (i.uv - 0.5) * _Area.zw + _Area.xy;
                c = rot(c, _Area.xy, _Angle);
                float2 z;
                float iter;
                for (iter = 0; iter < 255; iter++)
                {
                    z = float2(z.x * z.x - z.y * z.y, 2 * z.x * z.y) + c;
                    if (length(z) > 2) break;
                }
                return iter / 255;
            }
            ENDCG
        }
    }
}
