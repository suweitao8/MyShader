Shader "Unlit/19.波动球"
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
                half4 vertex : POSITION;
                half2 uv : TEXCOORD0;
                half3 normal : NORMAL;
            };

            struct v2f
            {
                half2 uv : TEXCOORD0;
                half4 pos : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                half time, noise;
                half2 noiseUV;
                half3 offset;
                
                o.uv = v.uv;

                time = _Time.y * 0.2;
                noiseUV = v.vertex.xy + time;
                Unity_SimpleNoise_half(noiseUV, 10.0, noise);
                noise -= 0.5;   // 0~1 -0.5~0.5
                
                offset = v.normal * noise;
                v.vertex.xyz += offset * 0.1;

                o.pos = UnityObjectToClipPos(v.vertex);
                
                return o;
            }

            half4 frag (v2f i) : SV_Target
            {
                half rectangle;
                half3 col;

                Unity_Rectangle_half(i.uv, 1.0, 0.02, rectangle);
                col = lerp(_BaseColor, _LightColor, rectangle);
                
                return half4(col, 1.0);
            }
            ENDCG
        }
    }
}
