// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32958,y:32751,varname:node_3138,prsc:2|emission-8771-RGB,clip-8771-A;n:type:ShaderForge.SFN_Tex2d,id:8771,x:32615,y:32883,ptovrint:False,ptlb:node_8771,ptin:_node_8771,varname:node_8771,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:7ccd60d72644f734597ef352c7e07ec0,ntxv:0,isnm:False|UVIN-522-OUT;n:type:ShaderForge.SFN_ValueProperty,id:467,x:30540,y:33059,ptovrint:False,ptlb:Column,ptin:_Column,varname:node_467,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:8;n:type:ShaderForge.SFN_ValueProperty,id:8995,x:32040,y:33098,ptovrint:False,ptlb:Row,ptin:_Row,varname:node_8995,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:8;n:type:ShaderForge.SFN_TexCoord,id:9752,x:31480,y:32655,varname:node_9752,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Divide,id:9948,x:32219,y:32784,varname:node_9948,prsc:2|A-1753-R,B-467-OUT;n:type:ShaderForge.SFN_Divide,id:6019,x:32205,y:32972,varname:node_6019,prsc:2|A-1753-G,B-8995-OUT;n:type:ShaderForge.SFN_Append,id:522,x:32382,y:32883,varname:node_522,prsc:2|A-9948-OUT,B-6019-OUT;n:type:ShaderForge.SFN_Add,id:2967,x:31704,y:32767,varname:node_2967,prsc:2|A-9752-UVOUT,B-5325-OUT;n:type:ShaderForge.SFN_ComponentMask,id:1753,x:31936,y:32732,varname:node_1753,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-2967-OUT;n:type:ShaderForge.SFN_Time,id:6124,x:30172,y:33184,varname:node_6124,prsc:2;n:type:ShaderForge.SFN_Floor,id:7952,x:30619,y:33194,varname:node_7952,prsc:2|IN-5574-OUT;n:type:ShaderForge.SFN_Divide,id:3137,x:30849,y:33143,varname:node_3137,prsc:2|A-7952-OUT,B-467-OUT;n:type:ShaderForge.SFN_Floor,id:6822,x:31067,y:33096,varname:node_6822,prsc:2|IN-3137-OUT;n:type:ShaderForge.SFN_Append,id:5325,x:31741,y:33151,varname:node_5325,prsc:2|A-651-OUT,B-763-OUT;n:type:ShaderForge.SFN_Negate,id:763,x:31361,y:33145,varname:node_763,prsc:2|IN-6822-OUT;n:type:ShaderForge.SFN_Fmod,id:651,x:31160,y:33340,varname:node_651,prsc:2|A-7952-OUT,B-467-OUT;n:type:ShaderForge.SFN_Multiply,id:5574,x:30439,y:33250,varname:node_5574,prsc:2|A-6124-TDB,B-3884-OUT;n:type:ShaderForge.SFN_Slider,id:3884,x:30083,y:33413,ptovrint:False,ptlb:node_3884,ptin:_node_3884,varname:node_3884,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:10,max:20;proporder:8771-467-8995-3884;pass:END;sub:END;*/

Shader "Shader Forge/Learn7" {
    Properties {
        _node_8771 ("node_8771", 2D) = "white" {}
        _Column ("Column", Float ) = 8
        _Row ("Row", Float ) = 8
        _node_3884 ("node_3884", Range(0, 20)) = 10
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
            Cull Off
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            uniform sampler2D _node_8771; uniform float4 _node_8771_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _Column)
                UNITY_DEFINE_INSTANCED_PROP( float, _Row)
                UNITY_DEFINE_INSTANCED_PROP( float, _node_3884)
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
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float4 node_6124 = _Time;
                float _node_3884_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_3884 );
                float node_7952 = floor((node_6124.b*_node_3884_var));
                float _Column_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Column );
                float node_3137 = (node_7952/_Column_var);
                float node_6822 = floor(node_3137);
                float2 node_1753 = (i.uv0+float2(fmod(node_7952,_Column_var),(-1*node_6822))).rg;
                float _Row_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Row );
                float2 node_522 = float2((node_1753.r/_Column_var),(node_1753.g/_Row_var));
                float4 _node_8771_var = tex2D(_node_8771,TRANSFORM_TEX(node_522, _node_8771));
                clip(_node_8771_var.a - 0.5);
////// Lighting:
////// Emissive:
                float3 emissive = _node_8771_var.rgb;
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
            Cull Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma target 3.0
            uniform sampler2D _node_8771; uniform float4 _node_8771_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _Column)
                UNITY_DEFINE_INSTANCED_PROP( float, _Row)
                UNITY_DEFINE_INSTANCED_PROP( float, _node_3884)
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
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float4 node_6124 = _Time;
                float _node_3884_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_3884 );
                float node_7952 = floor((node_6124.b*_node_3884_var));
                float _Column_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Column );
                float node_3137 = (node_7952/_Column_var);
                float node_6822 = floor(node_3137);
                float2 node_1753 = (i.uv0+float2(fmod(node_7952,_Column_var),(-1*node_6822))).rg;
                float _Row_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Row );
                float2 node_522 = float2((node_1753.r/_Column_var),(node_1753.g/_Row_var));
                float4 _node_8771_var = tex2D(_node_8771,TRANSFORM_TEX(node_522, _node_8771));
                clip(_node_8771_var.a - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
