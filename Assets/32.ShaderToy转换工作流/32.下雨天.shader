Shader "Unlit/32.下雨天"
{
    Properties
    {
        _Size ("Size", Float) = 1
        _T ("T", Float) = 1
        _Distortion ("Dirstortion", range(-5, 5)) = 1
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
            #define S(a, b, t) smoothstep(a, b, t)

            #include "UnityCG.cginc"

            float _Size, _T, _Distortion;
            sampler2D _GrabTexture;
            
            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 pos : SV_POSITION;
                float4 grabPos : TEXCOORD1;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                o.grabPos = ComputeGrabScreenPos(o.pos);
                return o;
            }

            float N21(float2 p)
            {
                p = frac(p * float2(123.34, 345.45));
                p += dot(p, p + 34.56);
                return frac(p.x * p.y);
            }

            half4 frag (v2f i) : SV_Target
            {
                half4 col = 0;
                float t = fmod(_Time.y * 1 + _T, 7200);

                float2 aspect = float2(2, 1);
                float2 uv = i.uv * _Size * aspect;
                // 相对运动
                uv.y += t * 0.25;
                float2 gv = frac(uv) - 0.5;
                float2 id = floor(uv);
                float n = N21(id);
                t += n * 6.28;
                // col.rg = gv;
   
                // 位置偏移
                float w = i.uv.y * 10;
                float x = (n - 0.5) * 0.8;
                x += (0.4 - abs(x)) * sin(3*w)*pow(sin(w), 6) * 0.45;
                float y = -sin(t + sin(t + sin(t)* 0.5)) * 0.45;
                y -= (gv.x - x) * (gv.x - x);

                // 画点
                float2 dropPos = (gv - float2(x, y)) / aspect;
                float drop = S(.05, .03, length(dropPos));
                col += drop;

                // 尾巴
                float2 trailPos = (gv - float2(x, 0.25 * t)) / aspect;
                trailPos.y = (frac(trailPos.y * 8)  - 0.5) / 8;
                float trail = S(.03, .01, length(trailPos));

                // 雾
                float fogTrail = S(-0.05, 0.05, dropPos.y);
                fogTrail *= S(.5, y, gv.y);
                trail *= fogTrail;
                col += trail;

                fogTrail *= S(.05, .04, abs(dropPos.x));
                col += fogTrail * 0.5;
                
                // 划线
                // if (gv.x > 0.48 || gv.y > 0.49) col = float4(1,0,0,1);
                // col *= 0;
                // col += N21(id);
                float2 offs = drop * dropPos + trail * trailPos;
                col = tex2D(_GrabTexture, i.grabPos.xy / i.grabPos.w + offs * _Distortion);
                return col;
            }
            ENDCG
        }
    }
}
