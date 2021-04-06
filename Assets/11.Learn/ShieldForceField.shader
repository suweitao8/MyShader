Shader "Unlit/ShieldForceField"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        [NoScaleOffset] _LightTex ("LightTex", 2D) = "white" {}
        [HDR] _LightColor ("Light Color", Color) = (1,1,1,1)
        _Hologram ("Hologram", 2D) = "white" {}
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

            sampler2D _MainTex, _LightTex, _Hologram;
            float4 _MainTex_ST;
            half4 _LightColor;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                half2 uvGlow : TEXCOORD1;
                float4 pos : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                half2 uv = TRANSFORM_TEX(v.uv, _MainTex);
                Unity_TilingAndOffset_half(uv, half2(1,1), half2(0, -_Time.x), o.uv);
                Unity_TilingAndOffset_half(uv, half2(1,1), half2(0, -_Time.y), o.uvGlow);
                return o;
            }

            half4 frag (v2f i) : SV_Target
            {
                half4 col = tex2D(_MainTex, i.uv);
                half4 light = tex2D(_LightTex, i.uv);
                light.rgb = light.r * _LightColor.rgb;
                col.rgb += light.rgb * _LightColor.a;
                col.a = 0.8;
                half4 holoColor = tex2D(_Hologram, i.uvGlow);
                col += holoColor * 0.3;
                return col;
            }
            ENDCG
        }
    }
}
