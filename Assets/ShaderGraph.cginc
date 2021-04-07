#define FLT_MIN  1.175494351e-38 // Minimum normalized positive halfing-point number

// Ellipse
void Unity_Ellipse_half(half2 UV, half Width, half Height, out half Out)
{
    half d = length((UV * 2 - 1) / half2(Width, Height));
    Out = saturate((1 - d) / fwidth(d));
}

// 平滑圆
void SmoothCircle(half2 UV, half Radius, half Blur, out half Out)
{
    half2 uv = UV - 0.5;
    
    Out = smoothstep(Radius, Radius - Blur, length(uv));
}

// Rectangle
void Unity_Rectangle_half(half2 UV, half Width, half Height, out half Out)
{
    half2 d = abs(UV * 2 - 1) - half2(Width, Height);
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
void SmoothRectangle(half2 UV, half Width, half Height, half Blur, out half Out)
{
    half bar1, bar2;
    SmoothBar(UV.x, -Width/2.0, Width/2.0, Blur, bar1);
    SmoothBar(UV.y, -Height/2.0, Height/2.0, Blur, bar2);
    Out = bar1 * bar2;
}

// RoundedRectangle
void Unity_RoundedRectangle_half(half2 UV, half Width, half Height, half Radius, out half Out)
{
    Radius = max(min(min(abs(Radius * 2), abs(Width)), abs(Height)), 1e-5);
    half2 uv = abs(UV * 2 - 1) - half2(Width, Height) + Radius;
    half d = length(max(0, uv)) / Radius;
    Out = saturate((1 - d) / fwidth(d));
}

// Polygon
void Unity_Polygon_half(half2 UV, half Sides, half Width, half Height, out half Out)
{
    half pi = 3.14159265359;
    half aWidth = Width * cos(pi / Sides);
    half aHeight = Height * cos(pi / Sides);
    half2 uv = (UV * 2 - 1) / half2(aWidth, aHeight);
    uv.y *= -1;
    half pCoord = atan2(uv.x, uv.y);
    half r = 2 * pi / Sides;
    half distance = cos(floor(0.5 + pCoord / r) * r - pCoord) * length(uv);
    Out = saturate((1 - distance) / fwidth(distance));
}

// Tiliing And Offset
void Unity_TilingAndOffset_half(half2 UV, half2 Tiling, half2 Offset, out half2 Out)
{
    Out = UV * Tiling + Offset;
}

// Rotate
void Unity_Rotate_Degrees_half(half2 UV, half2 Center, half Rotation, out half2 Out)
{
    //rotation matrix
    Rotation = Rotation * (3.1415926f/180.0f);
    UV -= Center;
    half s = sin(Rotation);
    half c = cos(Rotation);

    //center rotation matrix
    half2x2 rMatrix = half2x2(c, -s, s, c);
    rMatrix *= 0.5;
    rMatrix += 0.5;
    rMatrix = rMatrix*2 - 1;

    //multiply the UVs by the rotation matrix
    UV.xy = mul(UV.xy, rMatrix);
    UV += Center;

    Out = UV;
}

// Twirl
void Unity_Twirl_half(half2 UV, half2 Center, half Strength, half2 Offset, out half2 Out)
{
    half2 delta = UV - Center;
    half angle = Strength * length(delta);
    half x = cos(angle) * delta.x - sin(angle) * delta.y;
    half y = sin(angle) * delta.x + cos(angle) * delta.y;
    Out = half2(x + Center.x + Offset.x, y + Center.y + Offset.y);
}

// Spherize
void Unity_Spherize_half(half2 UV, half2 Center, half2 Strength, half2 Offset, out half2 Out)
{
    half2 delta = UV - Center;
    half delta2 = dot(delta.xy, delta.xy);
    half delta4 = delta2 * delta2;
    half2 delta_offset = delta4 * Strength;
    Out = UV + delta * delta_offset + Offset;
}

// Checkerboard
void Unity_Checkerboard_half(half2 UV, half3 ColorA, half3 ColorB, half2 Frequency, out half3 Out)
{
    UV = (UV.xy + 0.5) * Frequency;
    half4 derivatives = half4(ddx(UV), ddy(UV));
    half2 duv_length = sqrt(half2(dot(derivatives.xz, derivatives.xz), dot(derivatives.yw, derivatives.yw)));
    half width = 1.0;
    half2 distance3 = 4.0 * abs(frac(UV + 0.25) - 0.5) - width;
    half2 scale = 0.35 / duv_length.xy;
    half freqLimiter = sqrt(clamp(1.1f - max(duv_length.x, duv_length.y), 0.0, 1.0));
    half2 vector_alpha = clamp(distance3 * scale.xy, -1.0, 1.0);
    half alpha = saturate(0.5f + 0.5f * vector_alpha.x * vector_alpha.y * freqLimiter);
    Out = lerp(ColorA, ColorB, alpha.xxx);
}

// Simple Noise
inline half Unity_SimpleNoise_RandomValue_half (half2 uv)
{
    return frac(sin(dot(uv, half2(12.9898, 78.233)))*43758.5453);
}
inline half Unity_SimpleNnoise_Interpolate_half (half a, half b, half t)
{
    return (1.0-t)*a + (t*b);
}

inline half Unity_SimpleNoise_ValueNoise_half (half2 uv)
{
    half2 i = floor(uv);
    half2 f = frac(uv);
    f = f * f * (3.0 - 2.0 * f);

    uv = abs(frac(uv) - 0.5);
    half2 c0 = i + half2(0.0, 0.0);
    half2 c1 = i + half2(1.0, 0.0);
    half2 c2 = i + half2(0.0, 1.0);
    half2 c3 = i + half2(1.0, 1.0);
    half r0 = Unity_SimpleNoise_RandomValue_half(c0);
    half r1 = Unity_SimpleNoise_RandomValue_half(c1);
    half r2 = Unity_SimpleNoise_RandomValue_half(c2);
    half r3 = Unity_SimpleNoise_RandomValue_half(c3);

    half bottomOfGrid = Unity_SimpleNnoise_Interpolate_half(r0, r1, f.x);
    half topOfGrid = Unity_SimpleNnoise_Interpolate_half(r2, r3, f.x);
    half t = Unity_SimpleNnoise_Interpolate_half(bottomOfGrid, topOfGrid, f.y);
    return t;
}
void Unity_SimpleNoise_half(half2 UV, half Scale, out half Out)
{
    half t = 0.0;

    half freq = pow(2.0, half(0));
    half amp = pow(0.5, half(3-0));
    t += Unity_SimpleNoise_ValueNoise_half(half2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;

    freq = pow(2.0, half(1));
    amp = pow(0.5, half(3-1));
    t += Unity_SimpleNoise_ValueNoise_half(half2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;

    freq = pow(2.0, half(2));
    amp = pow(0.5, half(3-2));
    t += Unity_SimpleNoise_ValueNoise_half(half2(UV.x*Scale/freq, UV.y*Scale/freq))*amp;

    Out = t;
}

// voronoi
inline half2 unity_voronoi_noise_randomVector (half2 UV, half offset)
{
    half2x2 m = half2x2(15.27, 47.63, 99.41, 89.98);
    UV = frac(sin(mul(UV, m)) * 46839.32);
    return half2(sin(UV.y*+offset)*0.5+0.5, cos(UV.x*offset)*0.5+0.5);
}
void Unity_Voronoi_half(half2 UV, half AngleOffset, half CellDensity, out half Out, out half Cells)
{
    half2 g = floor(UV * CellDensity);
    half2 f = frac(UV * CellDensity);
    half t = 8.0;
    half3 res = half3(8.0, 0.0, 0.0);

    for(int y=-1; y<=1; y++)
    {
        for(int x=-1; x<=1; x++)
        {
            half2 lattice = half2(x,y);
            half2 offset = unity_voronoi_noise_randomVector(lattice + g, AngleOffset);
            half d = distance(lattice + offset, f);

            if(d < res.x)
            {
                res = half3(d, offset.x, offset.y);
                Out = res.x;
                Cells = res.y;
            }
        }
    }
}

// Remap
void Unity_Remap_half(half In, half2 InMinMax, half2 OutMinMax, out half Out)
{
    Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
}

// Polar Coordinares
void Unity_PolarCoordinates_half(half2 UV, half2 Center, half RadialScale, half LengthScale, out half2 Out)
{
    half2 delta = UV - Center;
    half radius = length(delta) * 2 * RadialScale;
    half angle = atan2(delta.x, delta.y) * 1.0/6.28 * LengthScale;
    Out = half2(radius, angle);
}

// Replace Color
void Unity_ReplaceColor_half(half3 In, half3 From, half3 To, half Range, half Fuzziness, out half3 Out)
{
    half Distance = distance(From, In);
    Out = lerp(To, In, saturate((Distance - Range) / max(Fuzziness, 1e-5f)));
}

// Subtract
void Unity_Subtract_half(half A, half B, out half Out)
{
    Out = A - B;
}

// Combine
void Unity_Combine_half(half R, half G, half B, half A, out half4 RGBA, out half3 RGB, out half2 RG)
{
    RGBA = half4(R, G, B, A);
    RGB = half3(R, G, B);
    RG = half2(R, G);
}

// Sine
void Unity_Sine_half(half In, out half Out)
{
    Out = sin(In);
}

// Negate
void Unity_Negate_half(half In, out half Out)
{
    Out = -1 * In;
}

// One Minus
void Unity_OneMinus_half(half In, out half Out)
{
    Out = 1 - In;
}

// Multiplay
void Unity_Multiply_half (half4 A, half4 B, out half4 Out)
{
    Out = A * B;
}
void Unity_Multiply_half (half2 A, half2 B, out half2 Out)
{
    Out = A * B;
}
void Unity_Multiply_half (half A, half B, out half Out)
{
    Out = A * B;
}
void Unity_Multiply_half (half A, half3 B, out half3 Out)
{
    Out = A * B;
}
void Unity_Multiply_half (half3 A, half B, out half3 Out)
{
    Out = A * B;
}

// Add
void Unity_Add_half(half A, half B, out half Out)
{
    Out = A + B;
}
void Unity_Add_half(half3 A, half3 B, out half3 Out)
{
    Out = A + B;
}

// Reciprocal
void Unity_Reciprocal_half2(half2 In, out half2 Out)
{
    Out = 1.0/In;
}

// Modulo
void Unity_Modulo_half2(half2 A, half2 B, out half2 Out)
{
    Out = fmod(A, B);
}

// Invert Color
void Unity_InvertColors_half(half In, half InvertColors, out half Out)
{
    Out = abs(InvertColors - In);
}

// Power
void Unity_Power_half(half A, half B, out half Out)
{
    Out = pow(A, B);
}

// Posterize
void Unity_Posterize_half(half In, half Steps, out half Out)
{
    Out = floor(In / (1 / Steps)) * (1 / Steps);
}

// Gradient Noise
half2 Unity_GradientNoise_Dir_half(half2 p)
{
    // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
    p = p % 289;
    half x = (34 * p.x + 1) * p.x % 289 + p.y;
    x = (34 * x + 1) * x % 289;
    x = frac(x / 41) * 2 - 1;
    return normalize(half2(x - floor(x + 0.5), abs(x) - 0.5));
}
void Unity_GradientNoise_half(half2 UV, half Scale, out half Out)
{ 
    half2 p = UV * Scale;
    half2 ip = floor(p);
    half2 fp = frac(p);
    half d00 = dot(Unity_GradientNoise_Dir_half(ip), fp);
    half d01 = dot(Unity_GradientNoise_Dir_half(ip + half2(0, 1)), fp - half2(0, 1));
    half d10 = dot(Unity_GradientNoise_Dir_half(ip + half2(1, 0)), fp - half2(1, 0));
    half d11 = dot(Unity_GradientNoise_Dir_half(ip + half2(1, 1)), fp - half2(1, 1));
    fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
    Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
}

// Modulo
void Unity_Modulo_half(half A, half B, out half Out)
{
    Out = fmod(A, B);
}

// Saturation
void Unity_Saturation_half(half3 In, half Saturation, out half3 Out)
{
    half luma = dot(In, half3(0.2126729, 0.7151522, 0.0721750));
    Out =  luma.xxx + Saturation.xxx * (In - luma.xxx);
}

// Normalize that account for vectors with zero length
half3 SafeNormalize(half3 inVec)
{
    half dp3 = max(FLT_MIN, dot(inVec, inVec));
    return inVec * rsqrt(dp3);
}

// This function does the exact inverse of TransformTangentToWorld() and is
// also decribed within comments in mikktspace.h and it follows implicitly
// from the scalar triple product (google it).
half3 TransformWorldToTangent(half3 dirWS, half3x3 tangentToWorld)
{
    // Note matrix is in row major convention with left multiplication as it is build on the fly
    half3 row0 = tangentToWorld[0];
    half3 row1 = tangentToWorld[1];
    half3 row2 = tangentToWorld[2];
    
    // these are the columns of the inverse matrix but scaled by the determinant
    half3 col0 = cross(row1, row2);
    half3 col1 = cross(row2, row0);
    half3 col2 = cross(row0, row1);
    
    half determinant = dot(row0, col0);
    half sgn = determinant<0.0 ? (-1.0) : 1.0;
    
    // inverse transposed but scaled by determinant
    // Will remove transpose part by using matrix as the first arg in the mul() below
    // this makes it the exact inverse of what TransformTangentToWorld() does.
    half3x3 matTBN_I_T = half3x3(col0, col1, col2);
    
    return SafeNormalize( sgn * mul(matTBN_I_T, dirWS) );
}

// 高度转法线
void Unity_NormalFromHeight_Tangent_half(half In, half3 Position, half3x3 TangentMatrix, out half3 Out)
{
    half3 worldDirivativeX = ddx(Position * 100);
    half3 worldDirivativeY = ddy(Position * 100);
            
    half3 crossX = cross(TangentMatrix[2].xyz, worldDirivativeX);
    half3 crossY = cross(TangentMatrix[2].xyz, worldDirivativeY);
    half3 d = abs(dot(crossY, worldDirivativeX));
    half3 inToNormal = ((((In + ddx(In)) - In) * crossY) + (((In + ddy(In)) - In) * crossX)) * sign(d);
    inToNormal.y *= -1.0;
            
    Out = SafeNormalize((d * TangentMatrix[2].xyz) - inToNormal);
    Out = TransformWorldToTangent(Out, TangentMatrix);
}

// 调整法线强度
void Unity_NormalStrength_half(half3 In, half Strength, out half3 Out)
{
    Out = half3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
}

// 饱和度
void Unity_Saturate_half(half In, out half Out)
{
    Out = saturate(In);
}
