Shader "Unlit/SpriteTint"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        [HDR] _TintColor ("Tint Color", Color) = (1,1,1,1)
        _TintWait ("Tint Frequency", Range(0, 1)) = 0
        _TintSpeed ("Tint Speed", Float) = 5
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

            sampler2D _MainTex;
            float4 _MainTex_ST;
            half3 _TintColor;
            half _TintWait, _TintSpeed;

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
                half4 col = tex2D(_MainTex, i.uv);
                // half time = sin(_Time.y * _TintSpeed);   // -1 ~ 1
                // half tint = smoothstep(_TintWait, _TintWait + 0.1, time);
                col.rgb += _TintWait * _TintColor;
                return col;
            }
            ENDCG
        }
    }
}
