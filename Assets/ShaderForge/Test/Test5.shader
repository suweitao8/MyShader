// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32938,y:32734,varname:node_3138,prsc:2|emission-318-OUT,voffset-5121-OUT;n:type:ShaderForge.SFN_Tex2d,id:5194,x:32338,y:32893,ptovrint:False,ptlb:node_5194,ptin:_node_5194,varname:node_5194,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:677cca399782dea41aedc1d292ecb67d,ntxv:0,isnm:False|UVIN-9294-UVOUT;n:type:ShaderForge.SFN_Panner,id:9294,x:31972,y:32887,varname:node_9294,prsc:2,spu:0,spv:0.1|UVIN-8293-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:8293,x:31683,y:32878,varname:node_8293,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Multiply,id:318,x:32551,y:32910,varname:node_318,prsc:2|A-5194-RGB,B-5778-RGB;n:type:ShaderForge.SFN_Color,id:5778,x:32338,y:33084,ptovrint:False,ptlb:node_5778,ptin:_node_5778,varname:node_5778,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:0.920137,c3:0,c4:1;n:type:ShaderForge.SFN_Tex2d,id:7775,x:32149,y:33274,varname:node_7775,prsc:2,tex:7aad8c583ef292e48b06af0d1f2fab97,ntxv:0,isnm:False|UVIN-3441-OUT,TEX-6637-TEX;n:type:ShaderForge.SFN_Multiply,id:5121,x:32550,y:33292,varname:node_5121,prsc:2|A-5987-OUT,B-1436-OUT;n:type:ShaderForge.SFN_Slider,id:1436,x:31430,y:33809,ptovrint:False,ptlb:node_1436,ptin:_node_1436,varname:node_1436,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.1004193,max:1;n:type:ShaderForge.SFN_RemapRange,id:5987,x:32317,y:33274,varname:node_5987,prsc:2,frmn:0,frmx:1,tomn:-1,tomx:1|IN-7775-RGB;n:type:ShaderForge.SFN_TexCoord,id:549,x:31175,y:33250,varname:node_549,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Tex2dAsset,id:6637,x:31299,y:33551,ptovrint:False,ptlb:node_6637,ptin:_node_6637,varname:node_6637,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:7aad8c583ef292e48b06af0d1f2fab97,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Add,id:3441,x:31821,y:33196,varname:node_3441,prsc:2|A-549-UVOUT,B-1415-OUT;n:type:ShaderForge.SFN_Multiply,id:1415,x:31762,y:33458,varname:node_1415,prsc:2|A-2941-R,B-1436-OUT;n:type:ShaderForge.SFN_Tex2d,id:2941,x:31572,y:33404,varname:node_2941,prsc:2,tex:7aad8c583ef292e48b06af0d1f2fab97,ntxv:0,isnm:False|UVIN-5107-UVOUT,TEX-6637-TEX;n:type:ShaderForge.SFN_Panner,id:5107,x:31365,y:33319,varname:node_5107,prsc:2,spu:0.1,spv:0.1|UVIN-549-UVOUT;proporder:5194-5778-1436-6637;pass:END;sub:END;*/

Shader "Shader Forge/Test5" {
    Properties {
        _node_5194 ("node_5194", 2D) = "white" {}
        [HDR]_node_5778 ("node_5778", Color) = (1,0.920137,0,1)
        _node_1436 ("node_1436", Range(0, 1)) = 0.1004193
        _node_6637 ("node_6637", 2D) = "white" {}
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
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
            uniform sampler2D _node_5194; uniform float4 _node_5194_ST;
            uniform sampler2D _node_6637; uniform float4 _node_6637_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _node_5778)
                UNITY_DEFINE_INSTANCED_PROP( float, _node_1436)
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
                float4 node_4216 = _Time;
                float2 node_5107 = (o.uv0+node_4216.g*float2(0.1,0.1));
                float4 node_2941 = tex2Dlod(_node_6637,float4(TRANSFORM_TEX(node_5107, _node_6637),0.0,0));
                float _node_1436_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_1436 );
                float2 node_3441 = (o.uv0+(node_2941.r*_node_1436_var));
                float4 node_7775 = tex2Dlod(_node_6637,float4(TRANSFORM_TEX(node_3441, _node_6637),0.0,0));
                v.vertex.xyz += ((node_7775.rgb*2.0+-1.0)*_node_1436_var);
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
////// Lighting:
////// Emissive:
                float4 node_4216 = _Time;
                float2 node_9294 = (i.uv0+node_4216.g*float2(0,0.1));
                float4 _node_5194_var = tex2D(_node_5194,TRANSFORM_TEX(node_9294, _node_5194));
                float4 _node_5778_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_5778 );
                float3 emissive = (_node_5194_var.rgb*_node_5778_var.rgb);
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
            uniform sampler2D _node_6637; uniform float4 _node_6637_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _node_1436)
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
                float4 node_6001 = _Time;
                float2 node_5107 = (o.uv0+node_6001.g*float2(0.1,0.1));
                float4 node_2941 = tex2Dlod(_node_6637,float4(TRANSFORM_TEX(node_5107, _node_6637),0.0,0));
                float _node_1436_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_1436 );
                float2 node_3441 = (o.uv0+(node_2941.r*_node_1436_var));
                float4 node_7775 = tex2Dlod(_node_6637,float4(TRANSFORM_TEX(node_3441, _node_6637),0.0,0));
                v.vertex.xyz += ((node_7775.rgb*2.0+-1.0)*_node_1436_var);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
