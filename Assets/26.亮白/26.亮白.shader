Shader "Unlit/26.亮白"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Blur ("Blur", float) = 1
        _WhiteRange ("White Range", float) = 5
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

            #include "UnityCG.cginc"
            #include "Assets/ShaderGraph.cginc"

            sampler2D _MainTex;
            half4 _MainTex_ST, _MainTex_TexelSize;
            half _Blur, _WhiteRange;

            struct appdata
            {
                half4 vertex : POSITION;
                half2 uv : TEXCOORD0;
            };

            struct v2f
            {
                half2 uv : TEXCOORD0;
                half4 pos : SV_POSITION;
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
                half2 offset = _MainTex_TexelSize.xy * _Blur;
                half noise[9];
                half2 uv[9];
                uv[0] = i.uv;
                uv[1] = i.uv + half2(offset * half2(-1,0));
                uv[2] = i.uv + half2(offset * half2(1,0));
                uv[3] = i.uv + half2(offset * half2(-1,-1));
                uv[4] = i.uv + half2(offset * half2(0,-1));
                uv[5] = i.uv + half2(offset * half2(1,-1));
                uv[6] = i.uv + half2(offset * half2(-1,1));
                uv[7] = i.uv + half2(offset * half2(0,1));
                uv[8] = i.uv + half2(offset * half2(1,1));
                for (int x = 0; x < 9; x++)
                {
                    Unity_SimpleNoise_half(uv[x] + _Time.y * half2(0, 0.3), 30, noise[x]);
                    noise[x] -= 0.5;
                    uv[x] += half2(1,1) * noise[x] * 0.03 * _Blur / _WhiteRange;
                }
                
                half4 col = tex2D(_MainTex, i.uv);
                half alpha = 0.0;
                alpha += tex2D(_MainTex, uv[1]).a * 2;
                alpha += tex2D(_MainTex, uv[2]).a * 2;
                
                alpha += tex2D(_MainTex, uv[3]).a;
                alpha += tex2D(_MainTex, uv[4]).a * 2;
                alpha += tex2D(_MainTex, uv[5]).a;
                
                alpha += tex2D(_MainTex, uv[6]).a;
                alpha += tex2D(_MainTex, uv[7]).a * 2;
                alpha += tex2D(_MainTex, uv[8]).a;
                
                alpha = saturate(alpha);
                col.rgb += half3(1,1,1) * _Blur / _WhiteRange;
                col.rgb = saturate(col.rgb);
                
                return half4(col.rgb, alpha);
            }
            ENDCG
        }
    }
}
