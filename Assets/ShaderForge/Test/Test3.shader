// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33104,y:32747,varname:node_3138,prsc:2|emission-6162-OUT,clip-3853-OUT;n:type:ShaderForge.SFN_Tex2d,id:8355,x:32222,y:32695,ptovrint:False,ptlb:node_8355,ptin:_node_8355,varname:node_8355,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:519dafacd208bb64c83d5124be03b09d,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:8061,x:31886,y:33295,ptovrint:False,ptlb:node_8061,ptin:_node_8061,varname:node_8061,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:7aad8c583ef292e48b06af0d1f2fab97,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Step,id:8541,x:32317,y:33065,varname:node_8541,prsc:2|A-7612-OUT,B-8061-R;n:type:ShaderForge.SFN_Slider,id:7612,x:31760,y:33031,ptovrint:False,ptlb:node_7612,ptin:_node_7612,varname:node_7612,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.3565217,max:1;n:type:ShaderForge.SFN_Multiply,id:3853,x:32488,y:32959,varname:node_3853,prsc:2|A-8355-A,B-8541-OUT;n:type:ShaderForge.SFN_Add,id:9038,x:32077,y:33110,varname:node_9038,prsc:2|A-7612-OUT,B-4691-OUT;n:type:ShaderForge.SFN_Slider,id:4691,x:31729,y:33148,ptovrint:False,ptlb:node_4691,ptin:_node_4691,varname:node_4691,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.05217392,max:1;n:type:ShaderForge.SFN_Step,id:4001,x:32243,y:33260,varname:node_4001,prsc:2|A-9038-OUT,B-8061-R;n:type:ShaderForge.SFN_Subtract,id:1789,x:32506,y:33189,varname:node_1789,prsc:2|A-8541-OUT,B-4001-OUT;n:type:ShaderForge.SFN_Multiply,id:1634,x:32684,y:33206,varname:node_1634,prsc:2|A-1789-OUT,B-6202-RGB;n:type:ShaderForge.SFN_Color,id:6202,x:32476,y:33357,ptovrint:False,ptlb:node_6202,ptin:_node_6202,varname:node_6202,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:0,c3:0.9654913,c4:1;n:type:ShaderForge.SFN_Add,id:6162,x:32836,y:32932,varname:node_6162,prsc:2|A-8355-RGB,B-1634-OUT;proporder:8355-8061-7612-4691-6202;pass:END;sub:END;*/

Shader "Shader Forge/Test3" {
    Properties {
        _node_8355 ("node_8355", 2D) = "white" {}
        _node_8061 ("node_8061", 2D) = "white" {}
        _node_7612 ("node_7612", Range(0, 1)) = 0.3565217
        _node_4691 ("node_4691", Range(0, 1)) = 0.05217392
        [HDR]_node_6202 ("node_6202", Color) = (1,0,0.9654913,1)
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
            uniform sampler2D _node_8355; uniform float4 _node_8355_ST;
            uniform sampler2D _node_8061; uniform float4 _node_8061_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _node_7612)
                UNITY_DEFINE_INSTANCED_PROP( float, _node_4691)
                UNITY_DEFINE_INSTANCED_PROP( float4, _node_6202)
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
                float4 _node_8355_var = tex2D(_node_8355,TRANSFORM_TEX(i.uv0, _node_8355));
                float _node_7612_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_7612 );
                float4 _node_8061_var = tex2D(_node_8061,TRANSFORM_TEX(i.uv0, _node_8061));
                float node_8541 = step(_node_7612_var,_node_8061_var.r);
                clip((_node_8355_var.a*node_8541) - 0.5);
////// Lighting:
////// Emissive:
                float _node_4691_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_4691 );
                float4 _node_6202_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_6202 );
                float3 emissive = (_node_8355_var.rgb+((node_8541-step((_node_7612_var+_node_4691_var),_node_8061_var.r))*_node_6202_var.rgb));
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
            uniform sampler2D _node_8355; uniform float4 _node_8355_ST;
            uniform sampler2D _node_8061; uniform float4 _node_8061_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _node_7612)
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
                float4 _node_8355_var = tex2D(_node_8355,TRANSFORM_TEX(i.uv0, _node_8355));
                float _node_7612_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_7612 );
                float4 _node_8061_var = tex2D(_node_8061,TRANSFORM_TEX(i.uv0, _node_8061));
                float node_8541 = step(_node_7612_var,_node_8061_var.r);
                clip((_node_8355_var.a*node_8541) - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
