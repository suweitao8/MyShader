Shader "Unlit/Learn2"
{
    Properties
    {
        _MainTex ("Main Tex", 2D) = "white" {}
        _OutlineWidth ("Outline Width", Range(0, 0.1)) = 0.01
        [HDR] _OutlineColorA ("Outline Color A", Color) = (1,1,1,1)
        [HDR] _OutlineColorB ("Outline Color B", Color) = (1,1,1,1)
        }
    SubShader
    {
        Tags { 
            "RenderType"="Transparent"
            "Queue"="Transparent"
        }

        Pass
        {
            Blend SrcAlpha OneMinusSrcAlpha
            Cull Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "Assets/ShaderGraph.cginc"

            sampler2D _MainTex;
            half4 _MainTex_ST;
            half _OutlineWidth;
            half3 _OutlineColorB, _OutlineColorA;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv[9] : TEXCOORD0;   // 上下左右 左上 左下 右上 右下
                float4 pos : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv[0] = v.uv;
                Unity_TilingAndOffset_float(v.uv, half2(1, 1), half2(0., _OutlineWidth), o.uv[1]);
                Unity_TilingAndOffset_float(v.uv, half2(1, 1), half2(0., -_OutlineWidth), o.uv[2]);
                Unity_TilingAndOffset_float(v.uv, half2(1, 1), half2(-_OutlineWidth, 0), o.uv[3]);
                Unity_TilingAndOffset_float(v.uv, half2(1, 1), half2(_OutlineWidth, 0.), o.uv[4]);
                Unity_TilingAndOffset_float(v.uv, half2(1, 1), half2(-_OutlineWidth, _OutlineWidth), o.uv[5]);
                Unity_TilingAndOffset_float(v.uv, half2(1, 1), half2(-_OutlineWidth, -_OutlineWidth), o.uv[6]);
                Unity_TilingAndOffset_float(v.uv, half2(1, 1), half2(_OutlineWidth, _OutlineWidth), o.uv[7]);
                Unity_TilingAndOffset_float(v.uv, half2(1, 1), half2(_OutlineWidth, -_OutlineWidth), o.uv[8]);
                return o;
            }

            half4 frag (v2f i) : SV_Target
            {
                half alpha, outer, time, gradient, gradientInvert;
                half2 gradientUV;
                half3 outerColor, outerColorA, outerColorB;
                half4 colors[9];

                colors[0] = tex2D(_MainTex, i.uv[0]);
                colors[1] = tex2D(_MainTex, i.uv[1]);
                colors[2] = tex2D(_MainTex, i.uv[2]);
                colors[3] = tex2D(_MainTex, i.uv[3]);
                colors[4] = tex2D(_MainTex, i.uv[4]);
                colors[5] = tex2D(_MainTex, i.uv[5]);
                colors[6] = tex2D(_MainTex, i.uv[6]);
                colors[7] = tex2D(_MainTex, i.uv[7]);
                colors[8] = tex2D(_MainTex, i.uv[8]);

                // alpha
                alpha = colors[1].a + colors[2].a + colors[3].a + colors[4].a + colors[5].a + colors[6].a + colors[7].a + colors[8].a;
                alpha = saturate(alpha);    // clamp 0~1
                outer = alpha - colors[0].a;

                // 外描边颜色
                Unity_Multiply_float(_Time.y, -0.5, time);
                Unity_TilingAndOffset_float(i.uv[0], half2(1,1), half2(0,time), gradientUV);
                Unity_GradientNoise_float(gradientUV, 10, gradient);
                Unity_Multiply_float(gradient, _OutlineColorA, outerColorA);

                Unity_OneMinus_float(gradient, gradientInvert);
                Unity_Multiply_float(gradientInvert, _OutlineColorB, outerColorB);

                Unity_Add_float(outerColorA, outerColorB, outerColor);
                
                half3 finalColor = lerp(colors[0].rgb, outerColor, outer);
                return half4(finalColor, alpha);
            }
            ENDCG
        }
    }
    Fallback "Diffuse"
}
