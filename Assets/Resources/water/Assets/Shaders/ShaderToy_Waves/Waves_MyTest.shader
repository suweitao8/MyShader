Shader "shadertoy/Waves_MyTest" {
	Properties
	{
		_lineThick("line tick", Range(1, 10)) = 1
		_blockNum("block num", Range(10, 50)) = 30
	}
	CGINCLUDE  
		#include "UnityCG.cginc"   
		
		struct vertOut 
		{  
			float4 pos:SV_POSITION;  
			float4 srcPos : TEXCOORD;
		};

		float _lineThick;
		float _blockNum;

		vertOut vert(appdata_base v) 
		{
			vertOut o;
			o.pos = UnityObjectToClipPos (v.vertex);
			o.srcPos = ComputeScreenPos(o.pos);
			return o;
		}

		fixed4 frag(vertOut i) : COLOR0 {
            float siny = sin(_Time.y);
            float sinx = sin(_Time.x);
            float sinz = sin(_Time.z);
            float siny01 = siny * 0.5 + 0.5;
            float sinx01 = sinx * 0.5 + 0.5;
            float sinz01 = sinz * 0.5 + 0.5;

            float divTimes = siny01 * 10 + _blockNum - 10;
            float fmodV = 1 / divTimes;

            float radius = (siny01) * 0.1 + 0.25;
 
            // xy数值范围:[0~1],左下角是(0,0)点
            // x:[0~1]是从左到右
            // y:[0~1]是从下到上
			float2 screenXY = (i.srcPos.xy/i.srcPos.w);
			float2 sxy_bk = screenXY;
            screenXY = screenXY * 2 - 1;
            screenXY.x += (cos(_Time.y) * 0.5 + 0.5) * radius;
            screenXY.y += (siny01) * radius;
            float r = fmod(screenXY.x, fmodV) * divTimes; 
            float g = fmod(screenXY.g, fmodV) * divTimes; 

            float2 v = floor(screenXY * divTimes);
            if (fmod(v.x, 2.0) == 0 || fmod(v.y, 2.0)==0)
                r = g = 0; // 偶数的行列都不显示

            float amp = 0.2;
			fixed2 wave_color2 = 0;
			float count = 10;
			screenXY.y -= 0.12 * count;
			for(float i = 0; i < count; i++)
			{
				float freq_wave = sin(screenXY.x + _Time.y + i);
				screenXY.y += freq_wave * amp + pow(0.1, i);
				float wave_width = abs(1.0 * _lineThick / (500 * screenXY.y));
				 wave_color2 += fixed2(wave_width, wave_width); // 黄线
			}
			fixed4 blockColor = fixed4(r * screenXY.x, g * screenXY.y, 0, 1);
            fixed4 combinedColor = blockColor;

			// 白线
			float fw = sin(screenXY.x + _Time.w);
			screenXY.y += fw * 0.3 + pow(0.1, 6);
			float ww = abs(1.0 * _lineThick / (100 * screenXY.y)) + (0.8 - sxy_bk.x);
			combinedColor.xyz += ww;

            combinedColor.xy += wave_color2;

			return combinedColor;
		}
	ENDCG  
	SubShader {  
		Pass {  
			CGPROGRAM  
			#pragma vertex vert  
			#pragma fragment frag  
			#pragma fragmentoption ARB_precision_hint_fastest   
			ENDCG  
		}  
	}   
	FallBack Off  
}