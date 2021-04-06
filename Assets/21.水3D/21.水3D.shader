Shader "Unlit/21.水3D"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _GTex ("Gradient", 2D) = "white" {}       //水深度颜色
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

        GrabPass{ "_GrabTex" }
        
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "Assets/ShaderGraph.cginc"

            sampler2D _MainTex, _CameraDepthTexture, _GTex, _GrabTex;
            float4 _MainTex_ST;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 pos : SV_POSITION;
                float4 screenPos : TEXCOORD1;
                float4 grabPos : TEXCOORD2;
            };

            v2f vert (appdata v)
            {
                v2f o;

                // 波浪
                half noise;
                Unity_SimpleNoise_half(v.uv, 10, noise);
                v.vertex.y += sin(_Time.y * 3 + (v.vertex.x + v.vertex.z) * 10 + noise * 10) * 0.5;
                
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);

                // 屏幕
                o.screenPos = ComputeScreenPos(o.pos);
                o.grabPos = ComputeGrabScreenPos(o.pos);
                
                return o;
            }

            half4 frag (v2f i) : SV_Target
            {
                half4 col = tex2D(_MainTex, i.uv);

                // 深度图
                float4 depthSample = SAMPLE_DEPTH_TEXTURE_PROJ(_CameraDepthTexture, i.screenPos);
                float depth = LinearEyeDepth(depthSample);
                float foamLine = saturate(0.1 * (depth - i.screenPos.w));
                half2 gUV = half2(foamLine, 0.5);
                half4 depthColor = tex2D(_GTex, gUV);

                // 折射
                half noise;
                Unity_SimpleNoise_half(i.uv + half2(_Time.y, 0), 10, noise);
                i.grabPos.xz += half2(0.5,0) * noise;
                float4 disColor = tex2Dproj(_GrabTex, UNITY_PROJ_COORD(i.grabPos));
                col = col * depthColor + disColor;
                
                return half4(col.rgb,1);
            }
            ENDCG
        }
    }
}
