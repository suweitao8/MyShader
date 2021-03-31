Shader "Unlit/Fire2D"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        [HDR] _FireColor ("Fire Color", Color) = (1,0,0,1)
        _UpSpeed ("Up Speed", Range(0,2)) = 0.5
        _NoiseScale ("Noise Scale", Float) = 35
        _DistortionStrength ("Distortion Strength", Range(0,1)) = 0.2
        _FireBottomOffset ("Fire Bottom Offset", Range(0.1, 10)) = 1
        _ElliSize ("Ellipse Size", Vector) = (0.4, 0.6, 0.55, 0.8)
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
            half4 _MainTex_ST, _ElliSize;
            half3 _FireColor;
            half _UpSpeed, _NoiseScale, _DistortionStrength, _FireBottomOffset;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 pos : SV_POSITION;
                half2 noiseUV : TEXCOORD1;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);

                half time;
                Unity_Multiply_float(_Time.y, -_UpSpeed, time);
                Unity_TilingAndOffset_float(o.uv, half2(1.,1.), half2(0.,time), o.noiseUV);
                return o;
            }

            half4 frag (v2f i) : SV_Target
            {
                half time, simpleNoise, fireBottomOffset, innerFire, outerFire, fireUp, postersize;
                half2 fireUVOffset, fireUV;
                half3 col;

                // 噪声
                Unity_SimpleNoise_float(i.noiseUV, _NoiseScale, simpleNoise);
                simpleNoise -= 0.5;
                simpleNoise *= _DistortionStrength;

                // 对底影响
                Unity_Power_float(i.uv.y, _FireBottomOffset, fireBottomOffset);

                // 扰动UV
                fireUVOffset = half2(0., fireBottomOffset * simpleNoise);
                Unity_TilingAndOffset_float(i.uv, half2(1,1), fireUVOffset, fireUV);

                // 上焰
                fireUp = pow(1.0 - fireUV.y, 2.);
                
                // 内焰
                Unity_Ellipse_float(half2(fireUV.x, fireUp), _ElliSize.x, _ElliSize.y, innerFire);

                // 层次
                postersize = (fireUp + 0.4) * 1.5;
                Unity_Posterize_float(postersize, 4, postersize);
                innerFire += postersize;
                col = innerFire * _FireColor;

                // 外焰
                Unity_Ellipse_float(half2(fireUV.x, fireUp), _ElliSize.z, _ElliSize.w, outerFire);
                
                return half4(col, outerFire);
            }
            ENDCG
        }
    }
}
