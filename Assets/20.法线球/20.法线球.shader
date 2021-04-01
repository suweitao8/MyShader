Shader "Unlit/20.法线球"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _NormalMap ("Normal Map", 2D) = "bump" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            Tags {
                "LightMode"="ForwardBase"
            }
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "Assets/ShaderGraph.cginc"
            #include "Lighting.cginc"

            sampler2D _MainTex, _NormalMap;
            float4 _MainTex_ST;
            half4 _Color;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float4 normal : NORMAL;
                float4 tangent : TANGENT;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 pos : SV_POSITION;
                float3 nDirWS   : TEXCOORD2;  // 世界空间法线方向
                float3 tDirWS   : TEXCOORD3;  // 世界空间切线方向
                float3 bDirWS   : TEXCOORD4;  // 世界空间副切线方向
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);

                o.nDirWS = UnityObjectToWorldNormal(v.normal);  // 法线方向 OS>WS
                o.tDirWS = normalize(mul(unity_ObjectToWorld, float4(v.tangent.xyz, 0.0)).xyz); // 切线方向 OS>WS
                o.bDirWS = normalize(cross(o.nDirWS, o.tDirWS) * v.tangent.w);  // 副切线方向
                
                return o;
            }

            half4 frag (v2f i) : SV_Target
            {
                half3 lDir;
                
                float3x3 TBN = float3x3(i.tDirWS, i.bDirWS, i.nDirWS);
                lDir = _WorldSpaceLightPos0.xyz;

                half3 nDirTS = UnpackNormal(tex2D(_NormalMap, i.uv));
                half3 nDirWS = normalize(mul(nDirTS, TBN));
                Unity_NormalStrength_float(nDirWS, 1, nDirWS);
                nDirWS = normalize(nDirWS);
                half ndotl = dot(nDirWS, lDir);
                
                half4 col = tex2D(_MainTex, i.uv);
                return col * ndotl;
            }
            ENDCG
        }
    }
}
