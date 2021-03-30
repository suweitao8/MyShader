// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32853,y:32731,varname:node_3138,prsc:2|emission-1363-OUT,alpha-2200-OUT;n:type:ShaderForge.SFN_Tex2d,id:5011,x:32175,y:32690,ptovrint:False,ptlb:node_5011,ptin:_node_5011,varname:node_5011,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:519dafacd208bb64c83d5124be03b09d,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:9582,x:32016,y:32971,ptovrint:False,ptlb:node_9582,ptin:_node_9582,varname:node_9582,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:9a7c574206d6d4d4bb870598877d1211,ntxv:0,isnm:False|UVIN-6216-UVOUT;n:type:ShaderForge.SFN_Multiply,id:2200,x:32441,y:32952,varname:node_2200,prsc:2|A-5011-A,B-1828-OUT;n:type:ShaderForge.SFN_Add,id:1828,x:32214,y:33027,varname:node_1828,prsc:2|A-9582-R,B-5298-OUT;n:type:ShaderForge.SFN_Slider,id:5298,x:31859,y:33190,ptovrint:False,ptlb:node_5298,ptin:_node_5298,varname:node_5298,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.3217391,max:1;n:type:ShaderForge.SFN_Panner,id:6216,x:31782,y:32969,varname:node_6216,prsc:2,spu:0,spv:0.1|UVIN-2125-OUT;n:type:ShaderForge.SFN_Color,id:6213,x:32294,y:32518,ptovrint:False,ptlb:node_6213,ptin:_node_6213,varname:node_6213,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:1363,x:32516,y:32661,varname:node_1363,prsc:2|A-6213-RGB,B-5011-RGB;n:type:ShaderForge.SFN_ScreenPos,id:7146,x:31313,y:32925,varname:node_7146,prsc:2,sctp:0;n:type:ShaderForge.SFN_Depth,id:7748,x:31243,y:33112,varname:node_7748,prsc:2;n:type:ShaderForge.SFN_Multiply,id:2125,x:31524,y:33019,varname:node_2125,prsc:2|A-7146-UVOUT,B-7748-OUT;proporder:5011-9582-5298-6213;pass:END;sub:END;*/

Shader "Shader Forge/Test4" {
    Properties {
        _node_5011 ("node_5011", 2D) = "white" {}
        _node_9582 ("node_9582", 2D) = "white" {}
        _node_5298 ("node_5298", Range(0, 1)) = 0.3217391
        [HDR]_node_6213 ("node_6213", Color) = (0.5,0.5,0.5,1)
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
            uniform sampler2D _node_5011; uniform float4 _node_5011_ST;
            uniform sampler2D _node_9582; uniform float4 _node_9582_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _node_5298)
                UNITY_DEFINE_INSTANCED_PROP( float4, _node_6213)
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
                float4 posWorld : TEXCOORD1;
                float4 projPos : TEXCOORD2;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                float partZ = max(0,i.projPos.z - _ProjectionParams.g);
                float2 sceneUVs = (i.projPos.xy / i.projPos.w);
////// Lighting:
////// Emissive:
                float4 _node_6213_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_6213 );
                float4 _node_5011_var = tex2D(_node_5011,TRANSFORM_TEX(i.uv0, _node_5011));
                float3 emissive = (_node_6213_var.rgb*_node_5011_var.rgb);
                float3 finalColor = emissive;
                float4 node_5494 = _Time;
                float2 node_6216 = (((sceneUVs * 2 - 1).rg*partZ)+node_5494.g*float2(0,0.1));
                float4 _node_9582_var = tex2D(_node_9582,TRANSFORM_TEX(node_6216, _node_9582));
                float _node_5298_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_5298 );
                return fixed4(finalColor,(_node_5011_var.a*(_node_9582_var.r+_node_5298_var)));
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
