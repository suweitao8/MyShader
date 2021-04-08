Shader "Unlit/31.Floor2"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
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
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            half4 frag (v2f i) : SV_Target
            {
                
                half2 uv = i.uv - 0.5;
                float a = _Time.y;
                float2 p = float2(cos(a), sin(a)) * 0.4;
                float2 distort = uv - p;
                float d = length(distort);
                float m = smoothstep(0.1, 0.08, d);
                distort *= 20 * m;
                
                half4 col = tex2D(_MainTex, i.uv + distort);
                
                return col;
            }
            ENDCG
        }
    }
}
