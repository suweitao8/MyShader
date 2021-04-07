Shader "Unlit/30.卡通渲染"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _RampTex ("Ramp Tex", 2D) = "white" {}
        _OutlineWidth ("Outline Width", Range(0, 0.1)) = 0.015
        [HDR] _OutlineColor ("Outline Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            Cull Front
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            half _OutlineWidth;
            half3 _OutlineColor;
            
            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
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
                o.pos = UnityObjectToClipPos(v.vertex + v.normal * _OutlineWidth);
                o.uv = v.uv;
                return o;
            }

            half4 frag (v2f i) : SV_Target
            {
                return half4(_OutlineColor, 1);
            }
            ENDCG
        }
        
        Pass
        {
            Tags {
                "LightMode"="ForwardBase"
            }
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fwdbase_fullshadows

            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "AutoLight.cginc"

            sampler2D _MainTex, _RampTex;
            float4 _MainTex_ST;

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
                float3 nDirWS : TEXCOORD1;
                float3 posWS : TEXCOORD2;
                //LIGHTING_COORDS(5,6)
                LIGHTING_COORDS(5,6) 
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.nDirWS = UnityObjectToWorldNormal(v.normal);
                o.posWS = mul(unity_ObjectToWorld, v.vertex);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            

            half4 frag (v2f i) : SV_Target
            {
                float3 lDirWS = normalize(_WorldSpaceLightPos0.xyz);
                half ndotl = dot(lDirWS, i.nDirWS); // -1 ~ 1
                half attenuation = LIGHT_ATTENUATION(i);
                half rampCol = tex2D(_RampTex, half2(ndotl * attenuation, 0.3213214));
                half4 col = tex2D(_MainTex, i.uv) * rampCol;
                return col;
            }
            ENDCG
        }
    }
    Fallback "Diffuse"
}
