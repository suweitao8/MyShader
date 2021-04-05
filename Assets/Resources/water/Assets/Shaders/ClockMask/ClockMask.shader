// jave.lin 2019.08.11
Shader "Test/ClockMask" {
    Properties {
        _MainTex ("Texture", 2D) = "white" {}                       // 主纹理
        _MaskColor ("MaskColor", Color) = (1,1,1,0.5)               // 遮罩颜色
        _Percent("Percent", Range(0,1))=0                           // 遮罩百分比
        _StartDegreeOffset("StartDegreeOffset", Range(0, 360))=0    // 起始偏移角度
        [Toggle] _IsClock("IsClock", Float) = 1                     // 是否顺时针
    }
    SubShader {
        Pass {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            struct appdata {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };
            struct v2f {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
            };
            sampler2D _MainTex;
            float4 _MainTex_ST;
            float4 _MainTex_TexelSize;
            fixed4 _MaskColor;
            float _Percent;
            float _StartDegreeOffset;
            float _IsClock;
            v2f vert (appdata v) {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }
            fixed4 frag (v2f i) : SV_Target {
                fixed4 col = tex2D(_MainTex, i.uv);
                float2 uv1 = float2(i.uv.x, 1 - i.uv.y);
                // 四象限：左上：红，右上：黑，左下：黄，右下：绿
                //return fixed4(step(uv1.x, 0.5), step(0.5, uv1.y),0,1);
                float2 duv = uv1 - 0.5; // 用当前片段坐标减去中心坐标得出反向
                const float PI = 3.1415926;
                const float PI2 = 3.1415926 * 2;
                const float Deg2Rad = PI / 180;
                // 开始角度偏移
                float startRadian = Deg2Rad * _StartDegreeOffset;
                
                // 相当于
                /*
                | cos(a), sin(a)  |  x | x | = | rx |
                | -sin(a), cos(a) |    | y |   | ry |
                */
                float rx = cos(startRadian) * duv.x + sin(startRadian) * duv.y;
                float ry = -sin(startRadian) * duv.x + cos(startRadian) * duv.y;
               
                // 重新计算起始弧度
                float radian = atan2(ry, rx); // 得到的角度为：顺时针转，Y轴负半轴，从X轴正值转向X轴负值方向，Y轴正半轴，从X轴负值转向正轴方向

                radian = radian < 0 ? radian + PI2 : radian; // 上半轴，我们调整为正值的
                // 顺时针转，0~2PI，从黑到白
                //return radian / PI2;
                float p = _IsClock ? _Percent : 1 - _Percent;
                float maxRadian = p * PI2;
                if (_IsClock)
                {
                    if (radian < maxRadian)
                        return col;
                    else
                        return lerp(col, _MaskColor, _MaskColor.a);
                }
                else
                {
                    if (radian > maxRadian)
                        return col;
                    else
                        return lerp(col, _MaskColor, _MaskColor.a);
                }
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
