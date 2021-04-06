Shader "Unlit/Learn3"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _WarpInt ("Warp Int", Range(0,1)) = 0.5
        _WarpRange ("Warp Range", Range(0.1, 5)) = 1
        _NoiseScale ("NoiseScale", Range(0.1, 50)) = 30
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
            half4 _MainTex_ST;
            half _WarpInt, _WarpRange, _NoiseScale;

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
                half noise, influ;
                half2 uv, noiseUV;

                Unity_TilingAndOffset_half(i.uv, half2(1,1), half2(_Time.y, 0), noiseUV);
                Unity_SimpleNoise_half(noiseUV, _NoiseScale, noise);
                Unity_Remap_half(noise, half2(0,1), half2(-0.5, 0.5) * _WarpInt, noise);

                // 计算影响范围
                influ = i.uv.y;
                Unity_Power_half(influ, _WarpRange, influ);
                influ = saturate(influ);
                
                Unity_TilingAndOffset_half(i.uv, half2(1,1), half2(noise * influ,0),uv);

                half4 col = tex2D(_MainTex, uv);
                return col;
            }
            ENDCG
        }
    }
}
