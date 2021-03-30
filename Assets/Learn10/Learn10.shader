Shader "Unlit/Learn10"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _OutlineWidth ("Outline Width", Range(0, 0.1)) = 0.015
        [HDR] _OutlineColor ("Outline Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags {
            "RenderType"="Opaque"
        }

        Pass
        {
            Cull Front
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            half _OutlineWidth;
            half3 _OutlineColor;
            sampler2D _MainTex;
            float4 _MainTex_ST;
            
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
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            half4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                return half4(_OutlineColor, 1);
            }
            ENDCG
        }
        
        Pass
        {
            Cull Off 
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

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                return col;
            }
            ENDCG
        }
    }
}
