#define FLT_MIN  1.175494351e-38 // Minimum normalized positive floating-point number

// Ellipse
void Unity_Ellipse_float(float2 UV, float Width, float Height, out float Out)
{
    float d = length((UV * 2 - 1) / float2(Width, Height));
    Out = saturate((1 - d) / fwidth(d));
}

// Rectangle
void Unity_Rectangle_float(float2 UV, float Width, float Height, out float Out)
{
    float2 d = abs(UV * 2 - 1) - float2(Width, Height);
    d = 1 - d / fwidth(d);
    Out = saturate(min(d.x, d.y));
}

// 平滑条
void SmoothBar(half Input, half Start, half End, half Blur, out half Out)
{
    half step1 = smoothstep(Start - Blur, Start + Blur, Input);
    half step2 = smoothstep(End + Blur, End - Blur, Input);
    Out = step1 * step2;
}

// 平滑矩形
void SmoothRectangle(float2 UV, float Width, float Height, half Blur, out float Out)
{
    half bar1, bar2;
    SmoothBar(UV.x, -Width/2.0, Width/2.0, Blur, bar1);
    SmoothBar(UV.y, -Height/2.0, Height/2.0, Blur, bar2);
    Out = bar1 * bar2;
}

// RoundedRectangle
void Unity_RoundedRectangle_float(float2 UV, float Width, float Height, float Radius, out float Out)
{
    Radius = max(min(min(abs(Radius * 2), abs(Width)), abs(Height)), 1e-5);
    float2 uv = abs(UV * 2 - 1) - float2(Width, Height) + Radius;
    float d = length(max(0, uv)) / Radius;
    Out = saturate((1 - d) / fwidth(d));
}

// Polygon
void Unity_Polygon_float(float2 UV, float Sides, float Width, float Height, out float Out)
{
    float pi = 3.14159265359;
    float aWidth = Width * cos(pi / Sides);
    float aHeight = Height * cos(pi / Sides);
    float2 uv = (UV * 2 - 1) / float2(aWidth, aHeight);
    uv.y *= -1;
    float pCoord = atan2(uv.x, uv.y);
    float r = 2 * pi / Sides;
    float distance = cos(floor(0.5 + pCoord / r) * r - pCoord) * length(uv);
    Out = saturate((1 - distance) / fwidth(distance));
}

// Tiliing And Offset
void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
{
    Out = UV * Tiling + Offset;
}

// Rotate
void Unity_Rotate_Degrees_float(float2 UV, float2 Center, float Rotation, out float2 Out)
{
    //rotation matrix
    Rotation = Rotation * (3.1415926f/180.0f);
    UV -= Center;
    float s = sin(Rotation);
    float c = cos(Rotation);

    //center rotation matrix
    float2x2 rMatrix = float2x2(c, -s, s, c);
    rMatrix *= 0.5;
    rMatrix += 0.5;
    rMatrix = rMatrix*2 - 1;

    //multiply the UVs by the rotation matrix
    UV.xy = mul(UV.xy, rMatrix);
    UV += Center;

    Out = UV;
}

// Twirl
void Unity_Twirl_float(float2 UV, float2 Center, float Strength, float2 Offset, out float2 Out)
{
    float2 delta = UV - Center;
    float angle = Strength * length(delta);
    float x = cos(angle) * delta.x - sin(angle) * delta.y;
    float y = sin(angle) * delta.x + cos(angle) * delta.y;
    Out = float2(x + Center.x + Offset.x, y + Center.y + Offset.y);
}

// Spherize
void Unity_Spherize_float(float2 UV, float2 Center, float2 Strength, float2 Offset, out float2 Out)
{
    float2 delta = UV - Center;
    float delta2 = dot(delta.xy, delta.xy);
    float delta4 = delta2 * delta2;
    float2 delta_offset = delta4 * Strength;
    Out = UV + delta * delta_offset + Offset;
}

// Checkerboard
void Unity_Checkerboard_float(float2 UV, float3 ColorA, float3 ColorB, float2 Frequency, out float3 Out)
{
    UV = (UV.xy + 0.5) * Frequency;
    float4 derivatives = float4(ddx(UV), ddy(UV));
    float2 duv_length = sqrt(float2(dot(derivatives.xz, derivatives.xz), dot(derivatives.yw, derivatives.yw)));
    float width = 1.0;
    float2 distance3 = 4.0 * abs(frac(UV + 0.25) - 0.5) - width;
    float2 scale = 0.35 / duv_length.xy;
    float freqLimiter = sqrt(clamp(1.1f - max(duv_length.x, duv_length.y), 0.0, 1.0));
    float2 vector_alpha = clamp(distance3 * scale.xy, -1.0, 1.0);
    float alpha = saturate(0.5f + 0.5f * vector_alpha.x * vector_alpha.y * freqLimiter);
    Out = lerp(ColorA, ColorB, alpha.xxx);
}

// Simple Noise
inline float Unity_SimpleNoise_RandomValue_float (float2 uv)
{
    return frac(sin(dot(uv, float2(12.9898, 78.233)))*43758.5453);
}
inline float Unity_SimpleNnoise_Interpolate_float (float a, float b, float t)
{
    return (1.0-t)*a + (t*b);
}

inline float Unity_SimpleNoise_ValueNoise_float (float2 uv)
{
    float2 i = floor(uv);
    float2 f = frac(uv);
    f = f * f * (3.0 - 2.0 * f);

    uv = abs(frac(uv) - 0.5);
    float2 c0 = i + float2(0.0, 0.0);
    float2 c1 = i + float2(1.0, 0.0);
    float2 c2 = i + float2(0.0, 1.0);
    float2 c3 = i + float2(1.0, 1.0);
    float r0 = Unity_SimpleNoise_RandomValue_float(c0);
    float r1 = Unity_SimpleNoise_RandomValue_float(c1);
    float r2 = Unity_SimpleNoise_RandomValue_float(c2);
    float r3 = Unity_SimpleNoise_RandomValue_float(c3);

    float bottomOfGrid = Unity_SimpleNnoise_Interpolate_float(r0, r1, f.x);
    float topOfGrid = Unity_SimpleNnoise_Interpolate_float(r2, r3, f.x);
    float t = Unity_SimpleNnoise_Interpolate_float(bottomOfGrid, topOfGrid, f.y);
    return t;
}
void Unity_SimpleNoise_float(float2 UV, float Scale, out float Out)
{
    float t = 0.0;

    float freq = pow(2.0, float(0));
    float amp = pow(0.5, float(3-0));
    t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;

    freq = pow(2.0, float(1));
    amp = pow(0.5, float(3-1));
    t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;

    freq = pow(2.0, float(2));
    amp = pow(0.5, float(3-2));
    t += Unity_SimpleNoise_ValueNoise_float(float2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;

    Out = t;
}

// voronoi
inline float2 unity_voronoi_noise_randomVector (float2 UV, float offset)
{
    float2x2 m = float2x2(15.27, 47.63, 99.41, 89.98);
    UV = frac(sin(mul(UV, m)) * 46839.32);
    return float2(sin(UV.y*+offset)*0.5+0.5, cos(UV.x*offset)*0.5+0.5);
}
void Unity_Voronoi_float(float2 UV, float AngleOffset, float CellDensity, out float Out, out float Cells)
{
    float2 g = floor(UV * CellDensity);
    float2 f = frac(UV * CellDensity);
    float t = 8.0;
    float3 res = float3(8.0, 0.0, 0.0);

    for(int y=-1; y<=1; y++)
    {
        for(int x=-1; x<=1; x++)
        {
            float2 lattice = float2(x,y);
            float2 offset = unity_voronoi_noise_randomVector(lattice + g, AngleOffset);
            float d = distance(lattice + offset, f);

            if(d < res.x)
            {
                res = float3(d, offset.x, offset.y);
                Out = res.x;
                Cells = res.y;
            }
        }
    }
}

// Remap
void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
{
    Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
}

// Polar Coordinares
void Unity_PolarCoordinates_float(float2 UV, float2 Center, float RadialScale, float LengthScale, out float2 Out)
{
    float2 delta = UV - Center;
    float radius = length(delta) * 2 * RadialScale;
    float angle = atan2(delta.x, delta.y) * 1.0/6.28 * LengthScale;
    Out = float2(radius, angle);
}

// Replace Color
void Unity_ReplaceColor_float(float3 In, float3 From, float3 To, float Range, float Fuzziness, out float3 Out)
{
    float Distance = distance(From, In);
    Out = lerp(To, In, saturate((Distance - Range) / max(Fuzziness, 1e-5f)));
}

// Subtract
void Unity_Subtract_float(float A, float B, out float Out)
{
    Out = A - B;
}

// Combine
void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
{
    RGBA = float4(R, G, B, A);
    RGB = float3(R, G, B);
    RG = float2(R, G);
}

// Sine
void Unity_Sine_float(float In, out float Out)
{
    Out = sin(In);
}

// Negate
void Unity_Negate_float(float In, out float Out)
{
    Out = -1 * In;
}

// One Minus
void Unity_OneMinus_float(float In, out float Out)
{
    Out = 1 - In;
}

// Multiplay
void Unity_Multiply_float (float4 A, float4 B, out float4 Out)
{
    Out = A * B;
}
void Unity_Multiply_float (float2 A, float2 B, out float2 Out)
{
    Out = A * B;
}
void Unity_Multiply_float (float A, float B, out float Out)
{
    Out = A * B;
}
void Unity_Multiply_float (float A, float3 B, out float3 Out)
{
    Out = A * B;
}
void Unity_Multiply_float (float3 A, float B, out float3 Out)
{
    Out = A * B;
}

// Add
void Unity_Add_float(float A, float B, out float Out)
{
    Out = A + B;
}
void Unity_Add_float(float3 A, float3 B, out float3 Out)
{
    Out = A + B;
}

// Reciprocal
void Unity_Reciprocal_float2(float2 In, out float2 Out)
{
    Out = 1.0/In;
}

// Modulo
void Unity_Modulo_float2(float2 A, float2 B, out float2 Out)
{
    Out = fmod(A, B);
}

// Invert Color
void Unity_InvertColors_float(float In, float InvertColors, out float Out)
{
    Out = abs(InvertColors - In);
}

// Power
void Unity_Power_float(float A, float B, out float Out)
{
    Out = pow(A, B);
}

// Posterize
void Unity_Posterize_float(float In, float Steps, out float Out)
{
    Out = floor(In / (1 / Steps)) * (1 / Steps);
}

// Gradient Noise
float2 Unity_GradientNoise_Dir_float(float2 p)
{
    // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
    p = p % 289;
    float x = (34 * p.x + 1) * p.x % 289 + p.y;
    x = (34 * x + 1) * x % 289;
    x = frac(x / 41) * 2 - 1;
    return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
}
void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
{ 
    float2 p = UV * Scale;
    float2 ip = floor(p);
    float2 fp = frac(p);
    float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
    float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
    float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
    float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
    fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
    Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
}

// Modulo
void Unity_Modulo_float(float A, float B, out float Out)
{
    Out = fmod(A, B);
}

// Saturation
void Unity_Saturation_float(float3 In, float Saturation, out float3 Out)
{
    float luma = dot(In, float3(0.2126729, 0.7151522, 0.0721750));
    Out =  luma.xxx + Saturation.xxx * (In - luma.xxx);
}

// Normalize that account for vectors with zero length
float3 SafeNormalize(float3 inVec)
{
    float dp3 = max(FLT_MIN, dot(inVec, inVec));
    return inVec * rsqrt(dp3);
}

// This function does the exact inverse of TransformTangentToWorld() and is
// also decribed within comments in mikktspace.h and it follows implicitly
// from the scalar triple product (google it).
float3 TransformWorldToTangent(float3 dirWS, float3x3 tangentToWorld)
{
    // Note matrix is in row major convention with left multiplication as it is build on the fly
    float3 row0 = tangentToWorld[0];
    float3 row1 = tangentToWorld[1];
    float3 row2 = tangentToWorld[2];
    
    // these are the columns of the inverse matrix but scaled by the determinant
    float3 col0 = cross(row1, row2);
    float3 col1 = cross(row2, row0);
    float3 col2 = cross(row0, row1);
    
    float determinant = dot(row0, col0);
    float sgn = determinant<0.0 ? (-1.0) : 1.0;
    
    // inverse transposed but scaled by determinant
    // Will remove transpose part by using matrix as the first arg in the mul() below
    // this makes it the exact inverse of what TransformTangentToWorld() does.
    float3x3 matTBN_I_T = float3x3(col0, col1, col2);
    
    return SafeNormalize( sgn * mul(matTBN_I_T, dirWS) );
}

// 高度转法线
void Unity_NormalFromHeight_Tangent_float(float In, float3 Position, float3x3 TangentMatrix, out float3 Out)
{
    float3 worldDirivativeX = ddx(Position * 100);
    float3 worldDirivativeY = ddy(Position * 100);
            
    float3 crossX = cross(TangentMatrix[2].xyz, worldDirivativeX);
    float3 crossY = cross(TangentMatrix[2].xyz, worldDirivativeY);
    float3 d = abs(dot(crossY, worldDirivativeX));
    float3 inToNormal = ((((In + ddx(In)) - In) * crossY) + (((In + ddy(In)) - In) * crossX)) * sign(d);
    inToNormal.y *= -1.0;
            
    Out = SafeNormalize((d * TangentMatrix[2].xyz) - inToNormal);
    Out = TransformWorldToTangent(Out, TangentMatrix);
}

// 调整法线强度
void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
{
    Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
}

// 饱和度
void Unity_Saturate_float(float In, out float Out)
{
    Out = saturate(In);
}
