Shader "Unlit/33.RayMarching"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
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

            #define MAX_STEPS 100
            #define MAX_DIST 100
            #define SURF_DIST 0.01

            #include "UnityCG.cginc"

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
                float3 ro : TEXCOORD1;
                float3 hitPos : TEXCOORD2;
            };

            float sdCapsule(float3 p, float3 a, float3 b, float r)
            {
                float3 ab = b - a;
                float3 ap = p - a;
                float t = dot(ab, ap) / dot(ab, ab);
                t = clamp(t, 0, 1);
                float3 c = a + t * ab;
                return length(p - c) - r;
            }

            float GetDist(float3 p) {
                float sphere = length(p)-0.5;
                float circle = length(float2(length(p.xz) - 0.3, p.y)) - 0.1;
                float capsule = sdCapsule(p, float3(-1, 0, 0), float3(1, 1, 0), 0.3);
                float plane = p.y;
                return capsule;
            }

            float RayMarch(float3 ro, float3 rd) {
	            float dO=0.;
                
                for(int i=0; i<MAX_STEPS; i++) {
    	            float3 p = ro + rd*dO;
                    float dS = GetDist(p);
                    dO += dS;
                    if(dO>MAX_DIST || dS<SURF_DIST) break;
                }
                
                return dO;
            }

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

            float GetLight(float3 p) {
                
            }

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                o.ro = _WorldSpaceCameraPos;
                o.hitPos = mul(unity_ObjectToWorld, v.vertex);
                return o;
            }

            half4 frag (v2f i) : SV_Target
            {
                float4 col = 0;
                float2 uv = i.uv - 0.5;
                float3 ro = i.ro;
                float3 rd = normalize(i.hitPos - ro);//normalize(float3(uv.x, uv.y, 1));

                float d = RayMarch(ro, rd);

                if (d < MAX_DIST)
                {
                    float3 p = ro + rd * d;
                    float3 n = GetNormal(p);
                    col.rgb = n;
                }
                else discard;

                col.a = 1;
                return col;
            }
            ENDCG
        }
    }
}
