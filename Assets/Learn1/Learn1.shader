// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:34115,y:32686,varname:node_3138,prsc:2|emission-3593-OUT,alpha-2768-OUT;n:type:ShaderForge.SFN_TexCoord,id:213,x:31630,y:32746,varname:node_213,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_RemapRange,id:5934,x:31796,y:32764,varname:node_5934,prsc:2,frmn:0,frmx:1,tomn:-1,tomx:1|IN-213-UVOUT;n:type:ShaderForge.SFN_Length,id:4709,x:31973,y:32764,varname:node_4709,prsc:2|IN-5934-OUT;n:type:ShaderForge.SFN_Floor,id:2529,x:32153,y:32764,varname:node_2529,prsc:2|IN-4709-OUT;n:type:ShaderForge.SFN_OneMinus,id:2768,x:32349,y:32792,varname:node_2768,prsc:2|IN-2529-OUT;n:type:ShaderForge.SFN_Tex2d,id:6997,x:33095,y:32604,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:node_6997,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:758ac31a9bff9ac4181f54de54a6ecb7,ntxv:0,isnm:False;n:type:ShaderForge.SFN_ArcTan2,id:1331,x:32266,y:33021,varname:node_1331,prsc:2,attp:2|A-4094-R,B-9326-OUT;n:type:ShaderForge.SFN_ComponentMask,id:4094,x:31947,y:32972,varname:node_4094,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-5934-OUT;n:type:ShaderForge.SFN_Negate,id:9326,x:32109,y:33052,varname:node_9326,prsc:2|IN-4094-G;n:type:ShaderForge.SFN_Slider,id:2245,x:32151,y:33256,ptovrint:False,ptlb:FillAmount,ptin:_FillAmount,varname:node_2245,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.6771309,max:1;n:type:ShaderForge.SFN_Step,id:5590,x:32639,y:33307,varname:node_5590,prsc:2|A-2245-OUT,B-3077-OUT;n:type:ShaderForge.SFN_Multiply,id:4957,x:33477,y:32720,varname:node_4957,prsc:2|A-6997-RGB,B-7387-OUT;n:type:ShaderForge.SFN_OneMinus,id:3077,x:32453,y:33059,varname:node_3077,prsc:2|IN-1331-OUT;n:type:ShaderForge.SFN_OneMinus,id:1580,x:32855,y:33322,varname:node_1580,prsc:2|IN-5590-OUT;n:type:ShaderForge.SFN_Color,id:8123,x:32855,y:33107,ptovrint:False,ptlb:White,ptin:_White,varname:node_8123,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Color,id:6907,x:32833,y:32950,ptovrint:False,ptlb:Black,ptin:_Black,varname:node_6907,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.4811321,c2:0.3154593,c3:0.3154593,c4:1;n:type:ShaderForge.SFN_Lerp,id:7387,x:33180,y:33174,varname:node_7387,prsc:2|A-6907-RGB,B-8123-RGB,T-1580-OUT;n:type:ShaderForge.SFN_Add,id:3207,x:32167,y:32593,varname:node_3207,prsc:2|A-3144-OUT,B-4709-OUT;n:type:ShaderForge.SFN_Slider,id:3144,x:31830,y:32515,ptovrint:False,ptlb:LineWidth,ptin:_LineWidth,varname:node_3144,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.1287129,max:1;n:type:ShaderForge.SFN_Floor,id:2489,x:32349,y:32593,varname:node_2489,prsc:2|IN-3207-OUT;n:type:ShaderForge.SFN_OneMinus,id:9885,x:32536,y:32593,varname:node_9885,prsc:2|IN-2489-OUT;n:type:ShaderForge.SFN_Subtract,id:291,x:33180,y:32983,varname:node_291,prsc:2|A-2768-OUT,B-9885-OUT;n:type:ShaderForge.SFN_Lerp,id:3593,x:33754,y:32835,varname:node_3593,prsc:2|A-4957-OUT,B-6907-RGB,T-291-OUT;proporder:6997-2245-8123-6907-3144;pass:END;sub:END;*/

Shader "Shader Forge/Learn1" {
    Properties {
        _MainTex ("MainTex", 2D) = "white" {}
        _FillAmount ("FillAmount", Range(0, 1)) = 0.6771309
        _White ("White", Color) = (1,1,1,1)
        _Black ("Black", Color) = (0.4811321,0.3154593,0.3154593,1)
        _LineWidth ("LineWidth", Range(0, 1)) = 0.1287129
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend SrcAlpha OneMinusSrcAlpha
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma target 3.0
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _FillAmount)
                UNITY_DEFINE_INSTANCED_PROP( float4, _White)
                UNITY_DEFINE_INSTANCED_PROP( float4, _Black)
                UNITY_DEFINE_INSTANCED_PROP( float, _LineWidth)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float2 uv0 : TEXCOORD0;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
////// Lighting:
////// Emissive:
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float4 _Black_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Black );
                float4 _White_var = UNITY_ACCESS_INSTANCED_PROP( Props, _White );
                float _FillAmount_var = UNITY_ACCESS_INSTANCED_PROP( Props, _FillAmount );
                float2 node_5934 = (i.uv0*2.0+-1.0);
                float2 node_4094 = node_5934.rg;
                float node_1580 = (1.0 - step(_FillAmount_var,(1.0 - ((atan2(node_4094.r,(-1*node_4094.g))/6.28318530718)+0.5))));
                float3 node_4957 = (_MainTex_var.rgb*lerp(_Black_var.rgb,_White_var.rgb,node_1580));
                float node_4709 = length(node_5934);
                float node_2768 = (1.0 - floor(node_4709));
                float _LineWidth_var = UNITY_ACCESS_INSTANCED_PROP( Props, _LineWidth );
                float node_291 = (node_2768-(1.0 - floor((_LineWidth_var+node_4709))));
                float3 emissive = lerp(node_4957,_Black_var.rgb,node_291);
                float3 finalColor = emissive;
                return fixed4(finalColor,node_2768);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
