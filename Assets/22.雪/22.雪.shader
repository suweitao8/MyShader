Shader "Unlit/22.雪"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _AO ("AO", 2D) = "white" {}
        _SnowDir ("Snow Dir", Vector) = (0,1,0,0)
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            sampler2D _MainTex, _AO;
            half4 _MainTex_ST, _SnowDir;

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
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.nDirWS = UnityObjectToWorldNormal(v.normal);
                half snow = saturate(dot(o.nDirWS, _SnowDir));
                snow = step(0.5, snow);

                v.vertex *= 1 + snow * 0.01;
                
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.pos = UnityObjectToClipPos(v.vertex);
                o.posWS = mul(unity_ObjectToWorld, v.vertex);
                return o;
            }

            half4 frag (v2f i) : SV_Target
            {
                half3 vDirWS = normalize(UnityWorldSpaceViewDir(i.posWS));
                half snow = saturate(dot(i.nDirWS, _SnowDir));
                half ao = tex2D(_AO, i.uv);
                snow = smoothstep(0.5, 0.6, snow * ao);
                
                half4 col = tex2D(_MainTex, i.uv);
                half fresnel = pow(1 - saturate(dot(vDirWS, i.nDirWS)), 2);
                
                float3 finalColor = lerp(col.rgb, half3(1,1,1), snow) * ao + fresnel;
                return half4(finalColor, 1);
            }
            ENDCG
        }
    }
}
