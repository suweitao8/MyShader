Shader "Unlit/29.冲击波"
{
    Properties
    {
        _CircleSize ("Circle Size", Range(0, 1)) = 0.5
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        GrabPass {}
        
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "Assets/ShaderGraph.cginc"

            sampler2D _GrabTexture;
            half _CircleSize;

            struct appdata
            {
                half2 uv : TEXCOORD0;
                float4 vertex : POSITION;
            };

            struct v2f
            {
                half2 uv : TEXCOORD0;
                float4 pos : SV_POSITION;
                float4 screenPos : TEXCOORD1;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.uv = v.uv;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.screenPos = ComputeGrabScreenPos(o.pos);
                return o;
            }

            half4 frag (v2f i) : SV_Target
            {
                half circle1, circle2, circle;
                half4 col;

                SmoothCircle(i.uv, _CircleSize, 0.1, circle1);
                SmoothCircle(i.uv, _CircleSize * 0.8, 0.1, circle2);
                circle = circle1 - circle2;

                half4 offset = half4((i.uv - half2(0.5,0.5)), 0, 0);
                col = tex2Dproj(_GrabTexture, i.screenPos + circle * offset);
                return col;
            }
            ENDCG
        }
    }
}
