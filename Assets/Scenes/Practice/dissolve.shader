Shader "Toon/VerticalDissolve" {
	Properties{
		[Header(Base)]
		_Color("Color", Color) = (1,1,1,1)
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_OffsetT("ToonRamp Offset", Range(0,1)) = 0.5
		_Speed("Speed", Range(0.1,100)) = 0.5


		[Space]
		[Header(Noise)]
		_Noise("Noise Texture (RGB)", 2D) = "white" {}
		_Scale("Noise Texture Scale", Range(0,5)) = 1
		[Toggle(LOCAL)] _LOCAL("Local Texture?", Float) = 0

		[Space]
		[Header(Dissolve)]
		_DisAmount("Dissolve Amount", Range(-5,5)) = 0.0
		[Toggle(INVERT)] _INVERT("Inverse Direction?", Float) = 1
		_DisColor("Dissolve Color", Color) = (1,1,0,1)
		_DissolveColorWidth("Dissolve Color Width", Range(0,0.1)) = 0.01
		_Brightness("Dissolve Color Brightness", Range(0,20)) = 10
		_Cutoff("Noise Cutoff", Range(0,1)) = 0.5
		_Smoothness("Cutoff Smoothness", Range(0,2)) = 0.05
		_Shrink("Shrink/Stretch Y", Range(0,5)) = 1

		[Space]
		[Header(Vertex Displacement)]
		_ScaleV("Displacement Scale", Range(0,1)) = 0.1
		_Offset("Displacement Y Offset", Range(-1,1)) = 0.7
		_DisplacementWidth("Displacement Segment Width", Range(0,1)) = 0.3
		_HeightScale("Height Displacement Amount", Range(0,0.2)) = 0.0

	}

		SubShader{
			Tags{ "RenderType" = "Opaque" }
		LOD 200
		Cull Off

		CGPROGRAM

		#pragma shader_feature INVERT
		#pragma shader_feature LOCAL
		#pragma surface surf ToonRamp vertex:vert fullforwardshadows addshadow keepalpha// alphatest:_Cutoff
#pragma target 3.5
			float _OffsetT,_Shrink;
		// custom lighting function that uses a texture ramp based
		// on angle between light direction and normal
	#pragma lighting ToonRamp //exclude_path:prepass
		inline half4 LightingToonRamp(SurfaceOutput s, half3 lightDir, half atten)
		{
	#ifndef USING_DIRECTIONAL_LIGHT
			lightDir = normalize(lightDir);
	#endif
			  float d = dot(s.Normal, lightDir);
			float3 lightIntensity = smoothstep(0 , fwidth(d) + _OffsetT, d);

			half4 c;
			c.rgb = s.Albedo * _LightColor0.rgb * lightIntensity * (atten * 2);
			c.a = s.Alpha;
			return c;
		}

		float _DisAmount, _Scale, _ScaleV;
		float _HeightScale;
		float _DisplacementWidth;
		float _Offset, _Speed;

		struct Input
		{
			float2 uv_MainTex;
			float4 pos : POSITION;
			float3 worldNormal;
			float3 worldPos;
			float3 local;
		};

		void vert(inout appdata_full v, out Input o)
		{
			UNITY_INITIALIZE_OUTPUT(Input, o);
			// vertex position
			o.pos = mul(unity_ObjectToWorld, v.vertex.xyz);

			// local position that also takes rotation into account
			float3 rotatedLocal = mul((float3x3)unity_WorldToObject, o.pos);
			o.local = rotatedLocal;

			o.pos.y *= _Shrink;
			_DisAmount *= _Shrink;
			// position on model
			float dispPos = (o.pos.y + _DisAmount + _Offset);
			// clamped segment of model
			float dispPosClamped = smoothstep(0, 0.15, dispPos) * smoothstep(dispPos, dispPos + 0.15, _DisplacementWidth);
#if INVERT
			// position on model
			dispPos = 1 - (o.pos.y + _DisAmount + _Offset);
			// clamped segment of model
			dispPosClamped = smoothstep(0, 0.15, dispPos) * smoothstep(dispPos, dispPos + 0.15, _DisplacementWidth);

			//distort the mesh up
			v.vertex.y += (dispPosClamped * _HeightScale);
#else
			//or down
			v.vertex.y -= (dispPosClamped * _HeightScale);
#endif

			//distort the mesh sideways
			v.vertex.xz += dispPosClamped * (_ScaleV * (v.normal.xz));

			// do this again to account for displacement
			o.pos = mul(unity_ObjectToWorld, v.vertex.xyz);
			o.pos.y *= _Shrink;

		}

		sampler2D _MainTex, _Noise;
		half _Glossiness;
		half _Metallic;
		float _DissolveColorWidth, _Brightness, _Cutoff, _Smoothness;
		fixed4 _Color, _DisColor;

		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_BUFFER_START(Props)
			//UNITY_DEFINE_INSTANCED_PROP(float, _DisAmount) // uncomment this to use it per-instance
			// put more per-instance properties here
			UNITY_INSTANCING_BUFFER_END(Props)

			void surf(Input IN, inout SurfaceOutput o)
		{
			_DisAmount *= _Shrink;
			// Main texture tinted by color
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;

			float3 blendNormal = saturate(pow(IN.worldNormal * 1.4, 4));

			float3 adjustedworldpos = IN.worldPos;
#if LOCAL
				adjustedworldpos = IN.worldPos;
#endif

#if INVERT
				adjustedworldpos.y -= _Time.x * _Speed;
#else
				adjustedworldpos.y += _Time.x * _Speed;
#endif
				// normal noise triplanar for x, y, z sides
				float3 xn = tex2D(_Noise, adjustedworldpos.zy * _Scale);
				float3 yn = tex2D(_Noise, adjustedworldpos.zx * _Scale);
				float3 zn = tex2D(_Noise, adjustedworldpos.xy * _Scale);

				// lerped together all sides for noise texture
				float3 noisetexture = zn;
				noisetexture = lerp(noisetexture, xn, blendNormal.x);
				noisetexture = lerp(noisetexture, yn, blendNormal.y);

				float noise = noisetexture.r;

				// position on model
				float MovingPosOnModel = _DisAmount + IN.pos.y;
				// add noise
				MovingPosOnModel *= noise;

				// glowing bit that's a bit longer
				float maintexturePart = smoothstep(0, _Smoothness, MovingPosOnModel - _DissolveColorWidth);
				maintexturePart = step(_Cutoff, maintexturePart);

				// normal texture
				float glowingPart = smoothstep(0, _Smoothness, MovingPosOnModel);
				glowingPart = step(_Cutoff, glowingPart);
				// take out the normal texture part
				glowingPart *= (1 - maintexturePart);

#if INVERT

				// glowing bit that's a bit longer
				maintexturePart = 1 - smoothstep(0, _Smoothness, MovingPosOnModel + _DissolveColorWidth);
				maintexturePart = step(_Cutoff, maintexturePart);

				// normal texture
				glowingPart = 1 - smoothstep(0, _Smoothness, MovingPosOnModel);
				glowingPart = step(_Cutoff, glowingPart);
				// take out the normal texture part
				glowingPart *= (1 - maintexturePart);
#endif

				// Colorized Dissolve
				float4 glowingColored = glowingPart * _DisColor;

				// discard pixels beyond dissolving
				clip((maintexturePart + glowingPart) - 0.01);

				// main texture cutoff by dissolve
				float3 mainTexture = maintexturePart * c.rgb;

				// set main texture
				o.Albedo = mainTexture;

				// glowing dissolve
				o.Emission = (glowingColored * noisetexture) * _Brightness;

				// base settings
				o.Alpha = c.a;
			}
			ENDCG

		}

			Fallback "Diffuse"
}