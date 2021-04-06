Shader "Unlit/25.FlowLight"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Offset ("Offset", Range(-1, 1)) = 0
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
            float4 _MainTex_ST;
            half _Offset;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float2 rectUV : TEXCOORD1;
                float4 pos : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                
                Unity_Rotate_Degrees_float(v.uv, half2(0.5,0.5), 45, o.rectUV);
                o.rectUV += half2(0, _Offset * 1 - 0.5);
                return o;
            }

            void MyRect(half2 uv, half height, out half Out)
            {
                half blur = 0.05;
                half start = smoothstep(-height - blur, -height + blur, uv.y);
                half end = smoothstep(height + blur, height - blur, uv.y);
                Out = start * end;
            }

            half4 frag (v2f i) : SV_Target
            {
                half4 col = tex2D(_MainTex, i.uv);
                half rectangle;

                MyRect(i.rectUV, 0.1, rectangle);
                
                col.rgb += rectangle * 0.5;
                
                return col;
            }
            ENDCG
        }
    }
}
