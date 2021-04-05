// jave.lin 2019.08.12
Shader "Test/PerlinNoiseApp" {
    Properties {
        [NoScaleOffset] _MainTex ("MainTex", 2D) = "white" {}               // 主纹理
        [NoScaleOffset] _NoiseTex ("NoiseTex", 2D) = "white" {}             // 噪点图
        _NoiseScaleX ("NoiseScaleX", Range(0, 1)) = 0.1                     // 水平噪点放大系数
        _NoiseScaleY ("NoiseScaleY", Range(0, 1)) = 0.1                     // 垂直放大系数
        _NoiseSpeedX ("NoiseSpeedX", Range(0, 10)) = 1                      // 水平扰动速度
        _NoiseSpeedY ("NoiseSpeedY", Range(0, 10)) = 1                      // 垂直扰动速度
        _NoiseBrightOffset ("NoiseBrightOffset", Range(0, 0.9)) = 0.25      // 噪点图整体的数值偏移
        _SpecularGlossy ("SpecularGlossy", Range(0, 1)) = 0.16              // 水面光泽度
        _SpecularIntensity ("SpecularIntensity", Range(0, 1)) = 0.5         // 高光强度
    }

    CGINCLUDE
    #include "PerlinNoiseCG.cginc"
    ENDCG

    SubShader {
        Pass {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            ENDCG
        }
    }
    Fallback "Diffuse"
}
