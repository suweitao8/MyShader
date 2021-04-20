Shader "Unlit/34.牛顿摆"
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
            #include "Assets/ShaderGraph.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 pos : SV_POSITION;
                float3 posWS : TEXCOORD1;
            };

            float GetSphere(float3 p, float a)
            {
                float yOffset = 1.15;
                p.y -= yOffset;
                p.xy = mul(RotationByAngle(a), p.xy);
                p.y += yOffset;
                
                p += float3(0, -0.5, 0);
                float sphere = length(p) - 0.15;
                float ring = length(float2(length(p.xy - float2(0, 0.15)) - 0.05, p.z)) - 0.01;

                p.z = abs(p.z);
                float line1 =
                    DistanceByCapsule(p,
                        float3(0, 0.15, 0),
                        float3(0, 0.65, 0.22),
                        0.01);
                
                float d = min(sphere, ring);
                d = min(line1, d);
                return d;
            }

            float GetDist(float3 p, float3 oWS)
            {
                p -= oWS;
                
                // 球
                float a = sin(_Time.y);
                float center = 0.1;
                float sphere1 = GetSphere(p - float3(0.6, 0, 0), min(0, a));
                float sphere2 = GetSphere(p - float3(0.3, 0, 0), a * center);
                float sphere3 = GetSphere(p - float3(0.0, 0, 0), a * center);
                float sphere4 = GetSphere(p + float3(0.3, 0, 0), a * center);
                float sphere5 = GetSphere(p + float3(0.6, 0, 0), max(0, a));

                // cube
                float cube = DistanceByCube(p, float3(0,0,0), float3(1,0.1,0.5)) - 0.1;

                // bar
                float bar =
                    length(float2(
                    DistanceByCube(p.xy, float2(0,0), float2(0.8,1)) - 0.15,
                    abs(p.z) - 0.2)) - 0.04;
                
                // plane
                float plane = DistanceByPlane(p, 0);
                
                float d = max(cube, -plane);
                d = min(d, max(bar, -plane));
                d = min(d, sphere1);
                d = min(d, sphere2);
                d = min(d, sphere3);
                d = min(d, sphere4);
                d = min(d, sphere5);
                return d;
            }
            
            // 射线示例
            float Raymarching(float3 ro, float3 rd, float3 oWS)
            {
                float d = 0;
                for (int i = 0; i < RAY_STEP; i++)
                {
                    float3 p = ro + rd * d;
                    float dS = GetDist(p, oWS);
                    d += dS;
                    if (d > RAY_MAX_DIST || abs(d) < RAY_SUF_DIST) break;
                }
                return d;
            }

            float3 GetNormal(float3 p, float3 oWS)
            {
                float2 e = float2(1e-2, 0);
                float3 n = GetDist(p, oWS) - float3(
                    GetDist(p - e.xyy, oWS),
                    GetDist(p - e.yxy, oWS),
                    GetDist(p - e.yyx, oWS)
                );
                return normalize(n);
            }

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                o.posWS = mul(unity_ObjectToWorld, v.vertex);
                return o;
            }

            half4 frag (v2f i) : SV_Target
            {
                float2 uv = i.uv;
                float3 posWS = i.posWS;
                float3 oWS= mul(unity_ObjectToWorld, float4(0, 0, 0, 1));
                float3 viewDir = normalize(UnityWorldSpaceViewDir(posWS));
                float3 lDir = normalize(_WorldSpaceLightPos0.xyz);
                float3 ro = _WorldSpaceCameraPos.xyz;
                float3 rd = normalize(posWS - _WorldSpaceCameraPos.xyz);
                float d = Raymarching(ro, rd, oWS);
                half4 col = 0;

                if (d < RAY_MAX_DIST)
                {
                    float3 p = ro + rd * d;
                    float3 n = GetNormal(p, oWS);
                    float lambert = dot(lDir, n) * 0.5 + 0.5;
                    col.rgb = lambert;
                }
                else discard;
                
                return col;
            }
            ENDCG
        }
    }
}
