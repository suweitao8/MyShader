// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32781,y:32729,varname:node_3138,prsc:2|emission-9361-OUT,olwid-5006-OUT,olcol-1683-RGB;n:type:ShaderForge.SFN_Tex2d,id:3501,x:32101,y:32541,ptovrint:False,ptlb:node_3501,ptin:_node_3501,varname:node_3501,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:1ffa09dd2472baa449817f99d66386e6,ntxv:0,isnm:False;n:type:ShaderForge.SFN_NormalVector,id:5868,x:31401,y:32772,prsc:2,pt:False;n:type:ShaderForge.SFN_LightVector,id:6161,x:31401,y:32926,varname:node_6161,prsc:2;n:type:ShaderForge.SFN_Dot,id:1203,x:31578,y:32863,varname:node_1203,prsc:2,dt:0|A-5868-OUT,B-6161-OUT;n:type:ShaderForge.SFN_Multiply,id:9361,x:32488,y:32818,varname:node_9361,prsc:2|A-3501-RGB,B-6355-RGB;n:type:ShaderForge.SFN_Clamp01,id:4602,x:31755,y:32863,varname:node_4602,prsc:2|IN-1203-OUT;n:type:ShaderForge.SFN_Tex2d,id:6355,x:32205,y:32944,ptovrint:False,ptlb:node_6355,ptin:_node_6355,varname:node_6355,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:0b87e0e915efac2419715324cb55cb4f,ntxv:0,isnm:False|UVIN-1481-OUT;n:type:ShaderForge.SFN_Append,id:1481,x:31983,y:32961,varname:node_1481,prsc:2|A-4602-OUT,B-7367-OUT;n:type:ShaderForge.SFN_Vector1,id:7367,x:31707,y:33139,varname:node_7367,prsc:2,v1:0.1;n:type:ShaderForge.SFN_Vector1,id:5006,x:32521,y:33100,varname:node_5006,prsc:2,v1:0.0015;n:type:ShaderForge.SFN_Color,id:1683,x:32498,y:33204,ptovrint:False,ptlb:node_1683,ptin:_node_1683,varname:node_1683,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.01176471,c2:0.01176471,c3:0.4078432,c4:1;proporder:3501-6355-1683;pass:END;sub:END;*/

Shader "Shader Forge/Learn8" {
    Properties {
        _node_3501 ("node_3501", 2D) = "white" {}
        _node_6355 ("node_6355", 2D) = "white" {}
        _node_1683 ("node_1683", Color) = (0.01176471,0.01176471,0.4078432,1)
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "Outline"
            Tags {
            }
            Cull Front
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma target 3.0
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _node_1683)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.pos = UnityObjectToClipPos( float4(v.vertex.xyz + v.normal*0.0015,1) );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                float4 _node_1683_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_1683 );
                return fixed4(_node_1683_var.rgb,0);
            }
            ENDCG
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            uniform sampler2D _node_3501; uniform float4 _node_3501_ST;
            uniform sampler2D _node_6355; uniform float4 _node_6355_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                LIGHTING_COORDS(3,4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
////// Lighting:
////// Emissive:
                float4 _node_3501_var = tex2D(_node_3501,TRANSFORM_TEX(i.uv0, _node_3501));
                float2 node_1481 = float2(saturate(dot(i.normalDir,lightDirection)),0.1);
                float4 _node_6355_var = tex2D(_node_6355,TRANSFORM_TEX(node_1481, _node_6355));
                float3 emissive = (_node_3501_var.rgb*_node_6355_var.rgb);
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma target 3.0
            uniform sampler2D _node_3501; uniform float4 _node_3501_ST;
            uniform sampler2D _node_6355; uniform float4 _node_6355_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                LIGHTING_COORDS(3,4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
////// Lighting:
                float3 finalColor = 0;
                return fixed4(finalColor * 1,0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
