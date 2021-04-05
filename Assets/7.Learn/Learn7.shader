Shader "Unlit/Learn7"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Blur ("Blur", Range(0, 0.1)) = 0.01
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
            #pragma target 3.0

            #include "UnityCG.cginc"
            #include "Assets/ShaderGraph.cginc"

            sampler2D _MainTex;
            float4 _MainTex_ST;
            half _Blur;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv[9] : TEXCOORD0;
                float4 pos : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv[0] = v.uv;
                 Unity_TilingAndOffset_float(v.uv, half2(1, 1), half2(0., _Blur), o.uv[1]);
                Unity_TilingAndOffset_float(v.uv, half2(1, 1), half2(0., -_Blur), o.uv[2]);
                Unity_TilingAndOffset_float(v.uv, half2(1, 1), half2(-_Blur, 0), o.uv[3]);
                Unity_TilingAndOffset_float(v.uv, half2(1, 1), half2(_Blur, 0.), o.uv[4]);
                Unity_TilingAndOffset_float(v.uv, half2(1, 1), half2(-_Blur, _Blur), o.uv[5]);
                Unity_TilingAndOffset_float(v.uv, half2(1, 1), half2(-_Blur, -_Blur), o.uv[6]);
                Unity_TilingAndOffset_float(v.uv, half2(1, 1), half2(_Blur, _Blur), o.uv[7]);
                Unity_TilingAndOffset_float(v.uv, half2(1, 1), half2(_Blur, -_Blur), o.uv[8]);
                return o;
            }

            half4 frag (v2f i) : SV_Target
            {
                half4 colors[9], totalColor;
                colors[0] = tex2D(_MainTex, i.uv[0]);
                colors[1] = tex2D(_MainTex, i.uv[1]);
                colors[2] = tex2D(_MainTex, i.uv[2]);
                colors[3] = tex2D(_MainTex, i.uv[3]);
                colors[4] = tex2D(_MainTex, i.uv[4]);
                colors[5] = tex2D(_MainTex, i.uv[5]);
                colors[6] = tex2D(_MainTex, i.uv[6]);
                colors[7] = tex2D(_MainTex, i.uv[7]);
                colors[8] = tex2D(_MainTex, i.uv[8]);
                totalColor = colors[0] + colors[1] + colors[2] + colors[3] + colors[4] + colors[5] + colors[6] + colors[7] + colors[8];
                return totalColor / 9.;
            }
            ENDCG
        }
    }
}
