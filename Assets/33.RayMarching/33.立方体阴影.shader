Shader "Unlit/33.立方体阴影"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { 
            "RenderType"="Opaque"
        }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "Assets/ShaderGraph.cginc"

            #define MAX_DISTANCE 100
            #define MAX_STEP 100
            #define MIN_DISTANCE 0.01

            sampler2D _MainTex;
            float4 _MainTex_ST;

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

            float CubeDis(float3 p, float3 size)
            {
                return length(max(abs(p) - size, 0.0));
            }
            
            float GetDist(float3 p)
            {
                float3 rp = p;
                rp.xz = mul(RotationByAngle(_Time.y), rp.xz);
                float cube = CubeDis(rp, float3(0.1, 1, 0.5));

                float3 spA = p;
                spA -= float3(0, 1, 0);
                float sdA = (length(spA) - 1);
                float sdB = length(p - float3(0, 2, 0)) - 1;

                float sd = smoothmin(sdA, sdB, 0.1);
                
                float result = min(cube, p.y + 0.5);
                result = min(sd, result);
                return result;
            }

            float Raycast(float3 ro, float3 rd)
            {
                float d = 0;

                for (int i = 0; i < MAX_STEP; i++)
                {
                    float3 p = ro + rd * d;
                    float dS = GetDist(p);
                    d += dS;
                    if (d > MAX_DISTANCE || d < MIN_DISTANCE) break;
                }
                
                return d;
            }

            float3 GetNormal(float3 p)
            {
                float2 e = float2(1e-3, 0);
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
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.posWS = mul(unity_ObjectToWorld, v.vertex);
                return o;
            }

            half4 frag (v2f i) : SV_Target
            {
                half4 col = 0;
                float3 ro = _WorldSpaceCameraPos.xyz;
                float3 posWS = i.posWS;
                float3 vDirWS = UnityWorldSpaceViewDir(posWS);
                float3 lDirWS = normalize(_WorldSpaceLightPos0.xyz);
                float3 hDirWS = normalize(vDirWS + lDirWS);
                float3 rd = normalize(posWS - ro);

                float d = Raycast(ro, rd);

                if (d < MAX_DISTANCE)
                {
                    float3 p = ro + rd * d;
                    float3 n = GetNormal(p);
                    // 漫反射
                    float ndotl = dot(n, lDirWS) * 0.5 + 0.5;
                    float ndoth = pow(saturate(dot(n, hDirWS)), 64);
                    col.rgb = ndotl + ndoth;
                    // 阴影
                    float shadow = Raycast(p + n * MIN_DISTANCE * 2, lDirWS);
                    if (shadow < MAX_DISTANCE) col.rgb *= 0.5;
                }
                else discard;
                    
                return col;
            }
            ENDCG
        }
    }
}
