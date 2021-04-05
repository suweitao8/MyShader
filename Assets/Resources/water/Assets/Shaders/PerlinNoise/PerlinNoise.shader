Shader "Test/PerlinNoise" {
    Properties {
        _MainTex1 ("Texture", 2D) = "white" {}
        [NoScaleOffset] _MainTex2 ("Texture", 2D) = "white" {}
        [NoScaleOffset] _MainTex3 ("Texture", 2D) = "white" {}
        [NoScaleOffset] _MainTex4 ("Texture", 2D) = "white" {}
        [NoScaleOffset] _MainTex5 ("Texture", 2D) = "white" {}
        [NoScaleOffset] _MainTex6 ("Texture", 2D) = "white" {}
    }
    SubShader {
        Pass {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            struct appdata {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };
            struct v2f {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
            };
            sampler2D _MainTex1;
            sampler2D _MainTex2;
            sampler2D _MainTex3;
            sampler2D _MainTex4;
            sampler2D _MainTex5;
            sampler2D _MainTex6;

            float4 _MainTex1_ST;
            v2f vert (appdata v) {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex1);
                return o;
            }
            fixed4 frag (v2f i) : SV_Target {
                fixed4 col = (
                tex2D(_MainTex1, i.uv) + 
                tex2D(_MainTex2, i.uv) + 
                tex2D(_MainTex3, i.uv) + 
                tex2D(_MainTex4, i.uv) + 
                tex2D(_MainTex5, i.uv) + 
                tex2D(_MainTex6, i.uv)
                ) / 6;
                col.rgb = dot(col.rgb, float3(0.299,0.587,0.114));
                return col;
            }
            ENDCG
        }
    }
    Fallback "Diffuse"
}
