// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32719,y:32712,varname:node_3138,prsc:2|emission-7090-RGB,voffset-5015-OUT;n:type:ShaderForge.SFN_Tex2d,id:7090,x:32196,y:32772,ptovrint:False,ptlb:node_7090,ptin:_node_7090,varname:node_7090,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:677cca399782dea41aedc1d292ecb67d,ntxv:0,isnm:False|UVIN-3961-UVOUT;n:type:ShaderForge.SFN_Tex2d,id:7516,x:32008,y:33044,varname:node_7516,prsc:2,tex:7aad8c583ef292e48b06af0d1f2fab97,ntxv:0,isnm:False|UVIN-3445-OUT,TEX-9615-TEX;n:type:ShaderForge.SFN_TexCoord,id:3681,x:31781,y:32710,varname:node_3681,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Panner,id:3961,x:31975,y:32758,varname:node_3961,prsc:2,spu:0,spv:0.1|UVIN-3681-UVOUT;n:type:ShaderForge.SFN_Slider,id:7983,x:32087,y:33277,ptovrint:False,ptlb:node_7983,ptin:_node_7983,varname:node_7983,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.07826088,max:1;n:type:ShaderForge.SFN_Multiply,id:5015,x:32430,y:33172,varname:node_5015,prsc:2|A-9371-OUT,B-7983-OUT;n:type:ShaderForge.SFN_RemapRange,id:9371,x:32223,y:33052,varname:node_9371,prsc:2,frmn:0,frmx:1,tomn:-1,tomx:1|IN-7516-RGB;n:type:ShaderForge.SFN_Tex2dAsset,id:9615,x:30993,y:33218,ptovrint:False,ptlb:node_9615,ptin:_node_9615,varname:node_9615,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:7aad8c583ef292e48b06af0d1f2fab97,ntxv:0,isnm:False;n:type:ShaderForge.SFN_TexCoord,id:9524,x:30914,y:32898,varname:node_9524,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Tex2d,id:618,x:31298,y:32996,varname:node_618,prsc:2,tex:7aad8c583ef292e48b06af0d1f2fab97,ntxv:0,isnm:False|UVIN-561-UVOUT,TEX-9615-TEX;n:type:ShaderForge.SFN_Panner,id:561,x:31098,y:32996,varname:node_561,prsc:2,spu:0,spv:0.1|UVIN-9524-UVOUT;n:type:ShaderForge.SFN_Add,id:3445,x:31725,y:32932,varname:node_3445,prsc:2|A-9524-UVOUT,B-1446-OUT;n:type:ShaderForge.SFN_Multiply,id:1446,x:31515,y:32996,varname:node_1446,prsc:2|A-618-R,B-2079-OUT;n:type:ShaderForge.SFN_Slider,id:2079,x:31170,y:33170,ptovrint:False,ptlb:node_2079,ptin:_node_2079,varname:node_2079,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.2347826,max:1;proporder:7090-7983-9615-2079;pass:END;sub:END;*/

Shader "Shader Forge/Learn5" {
    Properties {
        _node_7090 ("node_7090", 2D) = "white" {}
        _node_7983 ("node_7983", Range(0, 1)) = 0.07826088
        _node_9615 ("node_9615", 2D) = "white" {}
        _node_2079 ("node_2079", Range(0, 1)) = 0.2347826
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
            uniform sampler2D _node_7090; uniform float4 _node_7090_ST;
            uniform sampler2D _node_9615; uniform float4 _node_9615_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _node_7983)
                UNITY_DEFINE_INSTANCED_PROP( float, _node_2079)
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
                float4 node_4687 = _Time;
                float2 node_561 = (o.uv0+node_4687.g*float2(0,0.1));
                float4 node_618 = tex2Dlod(_node_9615,float4(TRANSFORM_TEX(node_561, _node_9615),0.0,0));
                float _node_2079_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_2079 );
                float2 node_3445 = (o.uv0+(node_618.r*_node_2079_var));
                float4 node_7516 = tex2Dlod(_node_9615,float4(TRANSFORM_TEX(node_3445, _node_9615),0.0,0));
                float _node_7983_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_7983 );
                v.vertex.xyz += ((node_7516.rgb*2.0+-1.0)*_node_7983_var);
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
////// Lighting:
////// Emissive:
                float4 node_4687 = _Time;
                float2 node_3961 = (i.uv0+node_4687.g*float2(0,0.1));
                float4 _node_7090_var = tex2D(_node_7090,TRANSFORM_TEX(node_3961, _node_7090));
                float3 emissive = _node_7090_var.rgb;
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
            uniform sampler2D _node_9615; uniform float4 _node_9615_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _node_7983)
                UNITY_DEFINE_INSTANCED_PROP( float, _node_2079)
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
                float4 node_3022 = _Time;
                float2 node_561 = (o.uv0+node_3022.g*float2(0,0.1));
                float4 node_618 = tex2Dlod(_node_9615,float4(TRANSFORM_TEX(node_561, _node_9615),0.0,0));
                float _node_2079_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_2079 );
                float2 node_3445 = (o.uv0+(node_618.r*_node_2079_var));
                float4 node_7516 = tex2Dlod(_node_9615,float4(TRANSFORM_TEX(node_3445, _node_9615),0.0,0));
                float _node_7983_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_7983 );
                v.vertex.xyz += ((node_7516.rgb*2.0+-1.0)*_node_7983_var);
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
