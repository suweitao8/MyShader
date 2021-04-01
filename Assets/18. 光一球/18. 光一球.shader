Shader "Unlit/18. 光一球"
{
    Properties
    {
        [HDR] _BaseColor ("Base Color", Color) = (1,1,1,1)
        [HDR] _LightColor ("Color Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "Assets/ShaderGraph.cginc"

            half3 _BaseColor, _LightColor;

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
                o.uv = v.uv;
                return o;
            }

            half4 frag (v2f i) : SV_Target
            {
                half rectangle;
                half3 col;

                Unity_Rectangle_float(i.uv, 1.0, 0.02, rectangle);
                col = lerp(_BaseColor, _LightColor, rectangle);
                
                return half4(col, 1.0);
            }
            ENDCG
        }
    }
}
