Shader "Unlit/雪覆盖"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _SnowOpacity ("SnowOpacity", Range(0, 2)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fwdbase_fullshadows

            #include "UnityCG.cginc"
            #include "Assets/ShaderGraph.cginc"
            #include "Lighting.cginc"
            #include "AutoLight.cginc"

            sampler2D _MainTex;
            float4 _MainTex_ST;
            half _SnowOpacity;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 pos : SV_POSITION;
                float3 nDirWS : NORMAL;
                float3 posWS : TEXCOORD1;
                LIGHTING_COORDS(5,6)
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                o.nDirWS = UnityObjectToWorldNormal(v.normal);
                o.posWS = mul(unity_ObjectToWorld, v.vertex);
                TRANSFER_VERTEX_TO_FRAGMENT(o);
                return o;
            }

            half4 frag (v2f i) : SV_Target
            {
                half noise1, snow, ndotl, noise2, noise;
                half4 col;
                half3 lDir, diffuse;
                half2 noiseUV;

                noiseUV = half2(i.posWS.x, i.posWS.z);
                lDir = _WorldSpaceLightPos0.xyz;

                ndotl = dot(i.nDirWS, lDir);
                half shadow = LIGHT_ATTENUATION(i);
                
                Unity_SimpleNoise_float(noiseUV, 100.0, noise1);
                Unity_GradientNoise_float(noiseUV, 0.5, noise2);
                noise = noise1 * noise2;
                noise = saturate(noise + 0.5) * i.nDirWS.y;
                
                snow = saturate(pow(i.nDirWS.y, 1.0)) * noise * _SnowOpacity;
                col = tex2D(_MainTex, i.uv);

                diffuse = saturate(ndotl) * _LightColor0 * (col + snow) * shadow;
                
                return half4(diffuse, 1.0);
            }
            ENDCG
        }
    }
}
