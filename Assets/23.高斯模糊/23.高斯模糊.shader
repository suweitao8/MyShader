Shader "Unlit/23.高斯模糊"
{
    Properties
    {
        _Blur ("Blur", Float) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue"="Transparent" }

        GrabPass { "_GTex"}
        
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            half _Blur;
            sampler2D _GTex;
            half4 _GTex_TexelSize;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 pos : SV_POSITION;
                float4 screenPos : TEXCOORD1;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.screenPos = ComputeScreenPos(o.pos);
                return o;
            }

            half4 frag (v2f i) : SV_Target
            {
                half3 result = tex2Dproj(_GTex, i.screenPos).rgb * 4;
                
                half2 offset = _GTex_TexelSize.xy * _Blur;
                
                result += tex2Dproj(_GTex, i.screenPos + half4(offset * half2(-1,0),0,0)).rgb * 2;
                result += tex2Dproj(_GTex, i.screenPos + half4(offset * half2(1,0),0,0)).rgb * 2;
                
                result += tex2Dproj(_GTex, i.screenPos + half4(offset * half2(-1,-1),0,0)).rgb;
                result += tex2Dproj(_GTex, i.screenPos + half4(offset * half2(0,-1),0,0)).rgb * 2;
                result += tex2Dproj(_GTex, i.screenPos + half4(offset * half2(1,-1),0,0)).rgb;
                
                result += tex2Dproj(_GTex, i.screenPos + half4(offset * half2(-1,1),0,0)).rgb;
                result += tex2Dproj(_GTex, i.screenPos + half4(offset * half2(0,1),0,0)).rgb * 2;
                result += tex2Dproj(_GTex, i.screenPos + half4(offset * half2(1,1),0,0)).rgb;
                
                result /= 16;
                return half4(result, 1);
            }
            ENDCG
        }
    }
}
