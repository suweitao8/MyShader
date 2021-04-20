Shader "Unlit/34.陀螺"
{
    Properties
    {
        [HideInInspector] _MainTex ("Texture", 2D) = "white" {}
        _Bias ("Bias", Range(0, 2)) = 1
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
            float4 _MainTex_ST;
            float _Bias;

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

            float GetDist(float3 p)
            {
                float4 sphereConf = float4(0, 0, 2, 0.5);
                float sphere = DistanceBySphere(p, sphereConf);

                float3 cubeCenter = float3(0, 1, 5);
                float3 cubeSize = float3(2,2,2);
                float cube = DistanceByCube(p, cubeCenter, cubeSize);

                // float plane = DistanceByPlane(p, -0.5);
                // grid
                float g1 =
                DistanceByGyroid(p, 6.0, 0.03, 1.3);
                float g2 =
                DistanceByGyroid(p, 12.0, 0.03, 0.3);
                float g3 =
                DistanceByGyroid(p, 22.0, 0.03, 0.3);
                float g4 =
                DistanceByGyroid(p, 32.0, 0.03, 0.3);
                float g5 =
                DistanceByGyroid(p, 42.0, 0.03, 0.3);

                
                float g = g1 - g2 * 0.4;
                g += g2 * 0.3;
                g -= g3 * 0.2;
                g += g4 * 0.1;
                g -= g5 * 0.1;

                float d = max(cube, g); // min(plane, cube);
                return d;
            }

            // 射线示例
            float Raycast(float3 ro, float3 rd)
            {
                float d = 0;
                for (int i = 0; i < 100; i++)
                {
                    float3 p = ro + rd * d;
                    float dS = GetDist(p);
                    d += dS;
                    if (d > 100 || abs(d) < 0.01) break;
                }
                return d;
            }

            // 法线示例 
            float3 GetNormal(float3 p)
            {
                float2 e = float2(1e-2, 0);
                float3 n = GetDist(p) - float3(
                    GetDist(p - e.xyy),
                    GetDist(p - e.yxy),
                    GetDist(p - e.yyx)
                );
                return normalize(n);
            }

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            half4 frag (v2f i) : SV_Target
            {
                half4 col = 0;
                float2 uv = i.uv - 0.5;
                float3 ro = float3(5, 3, -3);
                float3 rd = normalize(float3(uv.x - 0.7, uv.y - 0.3, 1));
                float d = Raycast(ro, rd);
                float3 lDir = float3(1, 1, 0);

                float3 p = ro + rd * d;
                float3 n = GetNormal(p);
                if (d < 100)
                {
                    float diffuse = dot(lDir, n) * 0.5 + 0.5;
                    float g2 =
                    DistanceByGyroid(p, 10.76, 0.03, .3);
                    col.rgb = diffuse;
                    // col *= smoothstep(0.0, 0.1, g2);
                }

                return col;
            }
            ENDCG
        }
    }
}
