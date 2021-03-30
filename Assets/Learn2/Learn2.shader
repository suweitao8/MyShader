// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33409,y:32740,varname:node_3138,prsc:2|emission-8333-RGB;n:type:ShaderForge.SFN_Tex2d,id:8333,x:32874,y:32686,ptovrint:False,ptlb:node_8333,ptin:_node_8333,varname:node_8333,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:bd3249e8aae01e748aaca0c062e2c19c,ntxv:0,isnm:False|UVIN-2375-OUT;n:type:ShaderForge.SFN_Tex2d,id:83,x:32098,y:32867,ptovrint:False,ptlb:node_83,ptin:_node_83,varname:node_83,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:7aad8c583ef292e48b06af0d1f2fab97,ntxv:0,isnm:False|UVIN-572-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:5379,x:32137,y:32625,varname:node_5379,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Add,id:2375,x:32649,y:32776,varname:node_2375,prsc:2|A-8320-UVOUT,B-2285-OUT;n:type:ShaderForge.SFN_Multiply,id:2285,x:32324,y:32906,varname:node_2285,prsc:2|A-83-R,B-3029-OUT;n:type:ShaderForge.SFN_Slider,id:3029,x:32005,y:33093,ptovrint:False,ptlb:node_3029,ptin:_node_3029,varname:node_3029,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.1638619,max:1;n:type:ShaderForge.SFN_TexCoord,id:4556,x:31659,y:32849,varname:node_4556,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Panner,id:572,x:31887,y:32867,varname:node_572,prsc:2,spu:0.2,spv:0.2|UVIN-4556-UVOUT;n:type:ShaderForge.SFN_Panner,id:8320,x:32359,y:32671,varname:node_8320,prsc:2,spu:0.1,spv:0.1|UVIN-5379-UVOUT;proporder:8333-83-3029;pass:END;sub:END;*/

Shader "Shader Forge/Learn2" {
    Properties {
        _node_8333 ("node_8333", 2D) = "white" {}
        _node_83 ("node_83", 2D) = "white" {}
        _node_3029 ("node_3029", Range(0, 1)) = 0.1638619
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
            uniform sampler2D _node_8333; uniform float4 _node_8333_ST;
            uniform sampler2D _node_83; uniform float4 _node_83_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _node_3029)
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
                float4 node_5708 = _Time;
                float2 node_572 = (i.uv0+node_5708.g*float2(0.2,0.2));
                float4 _node_83_var = tex2D(_node_83,TRANSFORM_TEX(node_572, _node_83));
                float _node_3029_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_3029 );
                float2 node_2375 = ((i.uv0+node_5708.g*float2(0.1,0.1))+(_node_83_var.r*_node_3029_var));
                float4 _node_8333_var = tex2D(_node_8333,TRANSFORM_TEX(node_2375, _node_8333));
                float3 emissive = _node_8333_var.rgb;
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
