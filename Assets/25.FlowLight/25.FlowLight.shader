Shader "Unlit/25.FlowLight"
{
    Properties
    {
        [HideInInspector] _MainTex ("Texture", 2D) = "white" {}
        _Offset ("Offset", Range(-1, 1)) = 0
        _Int ("Int", Range(0, 1)) = 0.5
        _Color ("Color", Color) = (1,1,1,1)
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
            half4 _MainTex_ST, _Color;
            half _Offset, _Int;

            struct appdata
            {
                half4 vertex : POSITION;
                half2 uv : TEXCOORD0;
            };

            struct v2f
            {
                half2 uv : TEXCOORD0;
                half2 rectUV : TEXCOORD1;
                half4 pos : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                
                Unity_Rotate_Degrees_half(v.uv, half2(0.5,0.5), 45, o.rectUV);
                // 0 ~ 1 -10, 10
                o.rectUV += half2(0, frac(_Time.y * 0.1) * 5 - 2);
                return o;
            }

            void MyRect(half2 uv, half height, out half Out)
            {
                half blur = 0.01;
                half start = smoothstep(-height - blur, -height + blur, uv.y);
                half end = smoothstep(height + blur, height - blur, uv.y);
                Out = start * end;
            }

            half4 frag (v2f i) : SV_Target
            {
                half4 col = tex2D(_MainTex, i.uv);
                half rectangle;

                half2 maskUV = i.uv + half2(-0.2, +0.2);
                half mask;
                Unity_Rectangle_half(maskUV, 0.4, 0.2, mask);

                MyRect(i.rectUV, 0.1, rectangle);
                col.rgb += _Color.rgb * rectangle * _Int * mask;
                
                return col;
            }
            ENDCG
        }
    }
}
