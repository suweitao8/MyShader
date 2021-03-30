// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32955,y:32796,varname:node_3138,prsc:2|emission-495-OUT,clip-8304-OUT;n:type:ShaderForge.SFN_Tex2d,id:1395,x:32157,y:32715,ptovrint:False,ptlb:node_1395,ptin:_node_1395,varname:node_1395,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:519dafacd208bb64c83d5124be03b09d,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:4775,x:31906,y:32887,ptovrint:False,ptlb:node_4775,ptin:_node_4775,varname:node_4775,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:7aad8c583ef292e48b06af0d1f2fab97,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Step,id:7803,x:32209,y:33023,varname:node_7803,prsc:2|A-2030-OUT,B-4775-R;n:type:ShaderForge.SFN_Slider,id:2030,x:31708,y:33157,ptovrint:False,ptlb:node_2030,ptin:_node_2030,varname:node_2030,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.426087,max:1;n:type:ShaderForge.SFN_Multiply,id:8304,x:32448,y:32993,varname:node_8304,prsc:2|A-1395-A,B-7803-OUT;n:type:ShaderForge.SFN_Add,id:2173,x:32021,y:33215,varname:node_2173,prsc:2|A-2030-OUT,B-2017-OUT;n:type:ShaderForge.SFN_Slider,id:2017,x:31686,y:33257,ptovrint:False,ptlb:node_2017,ptin:_node_2017,varname:node_2017,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.04347826,max:1;n:type:ShaderForge.SFN_Step,id:2472,x:32209,y:33196,varname:node_2472,prsc:2|A-2173-OUT,B-4775-R;n:type:ShaderForge.SFN_Subtract,id:1885,x:32395,y:33160,varname:node_1885,prsc:2|A-7803-OUT,B-2472-OUT;n:type:ShaderForge.SFN_Multiply,id:2829,x:32571,y:33293,varname:node_2829,prsc:2|A-1885-OUT,B-5479-RGB;n:type:ShaderForge.SFN_Color,id:5479,x:32351,y:33354,ptovrint:False,ptlb:node_5479,ptin:_node_5479,varname:node_5479,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:0,c3:0.9504018,c4:1;n:type:ShaderForge.SFN_Add,id:495,x:32708,y:32932,varname:node_495,prsc:2|A-1395-RGB,B-2829-OUT;proporder:1395-4775-2030-2017-5479;pass:END;sub:END;*/

Shader "Shader Forge/Learn3" {
    Properties {
        _node_1395 ("node_1395", 2D) = "white" {}
        _node_4775 ("node_4775", 2D) = "white" {}
        _node_2030 ("node_2030", Range(0, 1)) = 0.426087
        _node_2017 ("node_2017", Range(0, 1)) = 0.04347826
        [HDR]_node_5479 ("node_5479", Color) = (1,0,0.9504018,1)
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "Queue"="AlphaTest"
            "RenderType"="TransparentCutout"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            uniform sampler2D _node_1395; uniform float4 _node_1395_ST;
            uniform sampler2D _node_4775; uniform float4 _node_4775_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _node_2030)
                UNITY_DEFINE_INSTANCED_PROP( float, _node_2017)
                UNITY_DEFINE_INSTANCED_PROP( float4, _node_5479)
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
                float4 _node_1395_var = tex2D(_node_1395,TRANSFORM_TEX(i.uv0, _node_1395));
                float _node_2030_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_2030 );
                float4 _node_4775_var = tex2D(_node_4775,TRANSFORM_TEX(i.uv0, _node_4775));
                float node_7803 = step(_node_2030_var,_node_4775_var.r);
                clip((_node_1395_var.a*node_7803) - 0.5);
////// Lighting:
////// Emissive:
                float _node_2017_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_2017 );
                float4 _node_5479_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_5479 );
                float3 emissive = (_node_1395_var.rgb+((node_7803-step((_node_2030_var+_node_2017_var),_node_4775_var.r))*_node_5479_var.rgb));
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1, 1
            Cull Back
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma target 3.0
            uniform sampler2D _node_1395; uniform float4 _node_1395_ST;
            uniform sampler2D _node_4775; uniform float4 _node_4775_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _node_2030)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float2 uv0 : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                float4 _node_1395_var = tex2D(_node_1395,TRANSFORM_TEX(i.uv0, _node_1395));
                float _node_2030_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_2030 );
                float4 _node_4775_var = tex2D(_node_4775,TRANSFORM_TEX(i.uv0, _node_4775));
                float node_7803 = step(_node_2030_var,_node_4775_var.r);
                clip((_node_1395_var.a*node_7803) - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
