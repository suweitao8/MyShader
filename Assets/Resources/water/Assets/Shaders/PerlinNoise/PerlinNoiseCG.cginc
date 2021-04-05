#include "UnityCG.cginc"
#include "Lighting.cginc"
#include "AutoLight.cginc"
struct appdata {
    float4 vertex : POSITION;
    float2 uv : TEXCOORD0;
    float3 normal : NORMAL;
};
struct v2f {
    float4 vertex : SV_POSITION;
    float2 uv : TEXCOORD0;
    float3 normal : TEXCOORD1;
    float3 wPos : TEXCOORD2;
};

sampler2D _MainTex;
sampler2D _NoiseTex;
fixed _NoiseScaleX;
fixed _NoiseScaleY;
fixed _NoiseSpeedX;
fixed _NoiseSpeedY;
fixed _NoiseBrightOffset;
fixed _SpecularGlossy;
fixed _SpecularIntensity;

v2f vert (appdata v) {
    v2f o;
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.uv = v.uv;
    o.normal = UnityObjectToWorldNormal(v.normal);
    o.wPos = mul(unity_ObjectToWorld, v.vertex);
    return o;
}

fixed4 frag (v2f i) : SV_Target {
    fixed2 ouvxy = fixed2( // 噪点图采样，用于主纹理的UV偏移的
        tex2D(_NoiseTex, i.uv + fixed2(_Time.x * _NoiseSpeedX, 0)).r,
        tex2D(_NoiseTex, i.uv + fixed2(0, _Time.x * _NoiseSpeedY)).r);
    ouvxy -= _NoiseBrightOffset; // 0~1 to ==> -_NoiseBrightOffset~ 1 - _NoiseBrightOffset
    ouvxy *= fixed2(_NoiseScaleX, _NoiseScaleY); // 扰动放大系数
    fixed4 col = tex2D(_MainTex, i.uv + ouvxy); // 加上扰动UV后再采样主纹理

    i.normal.xy += ouvxy; // 扰动法线

    // diffuse
    half3 L = normalize(_WorldSpaceLightPos0.xyz);
    half3 N = normalize(i.normal);
    half LdotN = dot(L, N);
    fixed3 diffuse = col.rgb * LdotN;

    // specular
    half3 specular = 0;
    half3 V = normalize(_WorldSpaceCameraPos.xyz - i.wPos);
    half3 H = normalize(L + V);
    if (LdotN > 0)
    {
        half HdotN = max(0, dot(H, N)); // blinn-phone
        specular = _LightColor0.rgb * pow(HdotN, _SpecularGlossy * 100) * _SpecularIntensity;
    }

    // ambient
    half3 ambient = UNITY_LIGHTMODEL_AMBIENT.rgb;

    return fixed4(diffuse + specular + ambient, 1);
}