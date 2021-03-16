Shader "Unlit/HealthBar"
{
    Properties
    {
        [NoScaleOffset] _MainTex ("Texture", 2D) = "white" {}
        _Health ("Health", Range(0, 1)) = 1
    }
    SubShader
    {
        Tags { 
            "RenderType"="Transparent" 
            "Queue"="Transparent"
        }

        Pass
        {
            ZWrite Off
            Blend SrcAlpha OneMinusSrcAlpha

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float _Health;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            float InvertLerp(float a, float b, float v) {
                return (v - a) / (b - a);
            }

            float4 frag (v2f i) : SV_Target
            {
                float healthbarMask = _Health > i.uv.x;

                // 中间渐变
                float tHealthColor = saturate(InvertLerp(0.2, 0.8, _Health));
                float3 healthbarColor = lerp(float3(1, 0, 0), float3(0, 1, 0), tHealthColor);
                float3 bgColor = float3(0, 0, 0);


                // 剔除
                // clip(healthbarMask - 0.001);

                // 分段
                // float healthbarMask = _Health > floor(i.uv.x * 8) / 8;

                float3 outColor = lerp(bgColor, healthbarColor, healthbarMask);
                return float4(outColor, 1);
            }
            ENDCG
        }
    }
}
