// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "shadertoy/Waves" {  //see https://www.shadertoy.com/view/4dsGzH

	Properties
	{
	   _WaveWidth("WaveWight",float) = 0.01
	}
	SubShader {  
	     Pass
        {
        CGINCLUDE  
 
		#include "UnityCG.cginc"              
		#pragma target 3.0  

		struct vertOut 
		{  
			float4 pos:SV_POSITION;  
			float4 srcPos : TEXCOORD;
		};

		float _WaveWidth;
 
		vertOut vert(appdata_base v) 
		{
			vertOut o;
			o.pos = UnityObjectToClipPos (v.vertex);
			o.srcPos = ComputeScreenPos(o.pos);
			return o;
		}
 
		fixed4 frag(vertOut i) : COLOR0 {
 
			fixed3 COLOR1 = fixed3(0.0,0.0,0.3);
			fixed3 COLOR2 = fixed3(0.5,0.0,0.0);
 
			float2 uv = (i.srcPos.xy/i.srcPos.w);
 
			fixed3 final_color = (1.0);
			fixed3 bg_color = (0.0);
			fixed3 wave_color = (0.0);

			uv = -1.0 + 2.0*uv;
			uv.y += 0.5;

			for(int i=0; i<5; i++) 
			{
				uv.y += (0.07 * sin(uv.x + i/7.0 +  _Time.y));

				_WaveWidth = abs(1.0 / (150.0 * uv.y));

				wave_color += fixed3(_WaveWidth,_WaveWidth, _WaveWidth);
			}

			final_color = bg_color + wave_color;
 
			return fixed4(final_color, 1.0);
		}
 
	ENDCG  
 }
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