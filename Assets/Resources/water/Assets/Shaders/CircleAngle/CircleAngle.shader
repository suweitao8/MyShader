// jave.lin 2019.08.13
Shader "Test/CircleAngle" {
    Properties {
        _MainTex ("Texture", 2D) = "white" {}
        _Radius ("Radius", Range(0, 1)) = 0.5
        _CircleRadius ("CircleRadius", Range(0, 0.5)) = 0.1
    }
    SubShader {
        Pass {
            CGPROGRAM
            #pragma target 4.0
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
            float _Radius;
            float _CircleRadius;
            v2f vert (appdata v) {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }
            // 输出uv到屏幕，红色就u增长方向，绿色是v的
            fixed4 p0(v2f i) { return fixed4(i.uv,0,1);}
            // 与uv源点的距离，越远越白，用到length(a)，返回a向量模，等价于sqrt(dot(a,a))
            fixed4 p1(v2f i) { return length(i.uv); }
            // 与uv源点距离小于小于某值显示白色，用到step(a,b)函数，返回a<b?1:0
            // 类似截断效果，就是a>b，就返回0，后面应该该值相乘就会为0，而截断
            fixed4 p2(v2f i) {
                float l = length(i.uv);
                return step(l, _Radius);// * (_Radius - fmod(l,_Radius));
            }
            // 与uv源点距离按某个值折叠，如：0~100,折叠值为20，那么将会折叠5段
            // 用到fmod(a,b)函数，返回a/b的余值
            // 如：9除10，余9，9就是余值
            // 如：11/10，与1, 1就是余值
            // 以此来实现折叠效果
            fixed4 p3(v2f i) {
                float l = length(i.uv);
                return fmod(l,_Radius);     
            }
            // 与P3基本一样，不同的是，添加了uv与源点超过某个值，将截断
            fixed4 p4(v2f i) {
                float l = length(i.uv);
                return step(l, _Radius) * fmod(l,_Radius);
            }
            // 与P4基本一样，不同的是，添加了截断倍数
            fixed4 p5(v2f i, int stepTimes=2) {
                float l = length(i.uv);
                return step(l, _Radius*stepTimes) * fmod(l,_Radius);
            }
            // 折叠10段，每段将从0到某值，将折叠会0，所以从0到模值，这个过程会渐变
            fixed4 p6(v2f i, int segment=10) {
                float l = length(i.uv);
                return fmod(l * segment, _Radius);
            }
            // 在P6基础上，对数据滤波处理
            // 使用上面提到的step(a,b)来滤波
            // 对数据大于cutoff的缩放到最小：0
            // 对数据小与cutoff的缩放到最大：1
            // 所以这样就会生成黑白间条
            fixed4 p7(v2f i, float cutoff=0.5, int segment=10) {
                float l = length(i.uv);
                return step(cutoff, fmod(l * segment, _Radius));
            }

            fixed4 p8(v2f i) {
                return noise(i.uv.x);
            }
            fixed4 frag (v2f i) : SV_Target {
                float siny01 = sin(_Time.y) * 0.5 + 0.5;
                //return p6(i, siny01 * 10);
                return p7(i, siny01);
                //return p7(i);
                //float2 uv = i.uv;//float2(i.uv.x, 1 - i.uv.y);
                ////return fixed4(uv,0,1);
                //return step(uv.y-0.01, uv.x) * step(uv.x-0.01, uv.y);

                return 1;
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);

                float2 duv = abs(i.uv - 0.5);
                float2 rxy = fmod(i.uv, _Radius);
                //return length(rxy);
                float2 mxy = step(_Radius, duv); // 求大于_Radius的那部分(==0)
                //return length(mxy);
                return mxy.x*mxy.y * step(0.1, length(duv));
                float len = length(duv);//return len;
                
                float ax = step(len, _Radius);//return ax;
                float ay = step(len, _Radius);//return ay;
                //return fixed4(ax,ay,0,1);
                if (ax*ay==0)discard;

                return col;
            }
            ENDCG
        }
    }
}
