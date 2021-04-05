// jave.lin 2019.08.11
Shader "Test/Flash" {
    Properties {
        _MainTex ("Texture", 2D) = "white" {}
        [NoScaleOffset] _FlashTex ("FlashTex", 2D) = "white" {}
        [NoScaleOffset] _FlashMaxTex ("FlashMaskTex", 2D) = "white"{}
        _Percent("Percent", Range(0, 1)) = 0
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
            sampler2D _MainTex;
            float4 _MainTex_ST;
            sampler2D _FlashTex;
            sampler2D _FlashMaxTex;
            float _Percent;
            v2f vert (appdata v) {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }
            fixed4 frag (v2f i) : SV_Target {
                float x = _Percent * 2 - 1; // _Percent是0~1的，我们转换为-1~1
                fixed4 flash = tex2D(_FlashTex, i.uv + fixed2(-x, 0));
                fixed flash_mask = tex2D(_FlashMaxTex, i.uv).r;
                flash *= flash.a * flash_mask;
                fixed4 col = tex2D(_MainTex, i.uv) + flash;
                return col;
            }
            ENDCG
        }
    }
}
