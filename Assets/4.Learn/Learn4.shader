Shader "Unlit/Learn4"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _ProcessTex ("ProcessTex", 2D) = "white" {}
        _Process ("Process", Range(0, 1)) = 0
        _Segments ("Segments", Int) = 2
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
            float4 _MainTex_ST;
            sampler2D _ProcessTex;
            half _Process, _Segments;

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
                half alpha, stepH, stepV, procH, procV, mulHV, procH2, stepH2, stepH3, addHV, stepV2, modulo;
                half2 horUV, verUV2;
                half4 horColor, col, verColor, verColor2;
                
                col = tex2D(_MainTex, i.uv);
                verColor = tex2D(_ProcessTex, i.uv);
                Unity_TilingAndOffset_half(i.uv, half2(1,1), half2(-1,0), verUV2);
                verColor2 = tex2D(_ProcessTex, verUV2);

                Unity_Rotate_Degrees_half(i.uv, half2(0.5, 0.5), 90, horUV);
                horColor = tex2D(_ProcessTex, horUV);

                // 算求
                Unity_Modulo_half(floor(_Process * _Segments), 2, modulo);

                procH = floor(_Process * _Segments) / _Segments;
                stepH = step(horColor.r, procH);
                procH2 = procH + (1.0 / _Segments);
                stepH2 = step(horColor.r, procH2);
                stepH3 = stepH2 - stepH;

                Unity_Modulo_half(_Process, 1 / _Segments, procV);
                Unity_Multiply_half(procV, _Segments, procV);
                stepV = step(verColor.r, procV);
                stepV2 = step(verColor2.r, procV);
                
                mulHV = stepH3 * stepV;
                if (modulo != 0)
                {
                    mulHV = stepH3 * stepV2;
                }
                addHV = mulHV + stepH;
                
                alpha = saturate(addHV * col.a);
                
                return half4(col.rgb, alpha);
            }
            ENDCG
        }
    }
}
