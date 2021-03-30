// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32793,y:32698,varname:node_3138,prsc:2|emission-4705-OUT,alpha-9185-OUT;n:type:ShaderForge.SFN_Tex2d,id:1780,x:32135,y:32706,ptovrint:False,ptlb:node_1780,ptin:_node_1780,varname:node_1780,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:519dafacd208bb64c83d5124be03b09d,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:1055,x:31925,y:33028,ptovrint:False,ptlb:node_1055,ptin:_node_1055,varname:node_1055,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:9a7c574206d6d4d4bb870598877d1211,ntxv:0,isnm:False|UVIN-1290-OUT;n:type:ShaderForge.SFN_Multiply,id:9185,x:32445,y:32983,varname:node_9185,prsc:2|A-1780-A,B-3214-OUT;n:type:ShaderForge.SFN_Add,id:3214,x:32178,y:33074,varname:node_3214,prsc:2|A-1055-R,B-2295-OUT;n:type:ShaderForge.SFN_Slider,id:2295,x:31826,y:33280,ptovrint:False,ptlb:node_2295,ptin:_node_2295,varname:node_2295,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.4347826,max:1;n:type:ShaderForge.SFN_TexCoord,id:1490,x:31491,y:32964,varname:node_1490,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Add,id:1290,x:31698,y:33074,varname:node_1290,prsc:2|A-1490-UVOUT,B-2433-OUT;n:type:ShaderForge.SFN_Vector2,id:5398,x:31357,y:33292,varname:node_5398,prsc:2,v1:0,v2:0.3;n:type:ShaderForge.SFN_Time,id:1028,x:31357,y:33151,varname:node_1028,prsc:2;n:type:ShaderForge.SFN_Multiply,id:2433,x:31548,y:33220,varname:node_2433,prsc:2|A-1028-T,B-5398-OUT;n:type:ShaderForge.SFN_Color,id:1700,x:32285,y:32527,ptovrint:False,ptlb:node_1700,ptin:_node_1700,varname:node_1700,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:0.8682783,c3:0,c4:1;n:type:ShaderForge.SFN_Multiply,id:4705,x:32489,y:32672,varname:node_4705,prsc:2|A-1700-RGB,B-1780-RGB;proporder:1780-1055-2295-1700;pass:END;sub:END;*/

Shader "Shader Forge/Learn4" {
    Properties {
        _node_1780 ("node_1780", 2D) = "white" {}
        _node_1055 ("node_1055", 2D) = "white" {}
        _node_2295 ("node_2295", Range(0, 1)) = 0.4347826
        [HDR]_node_1700 ("node_1700", Color) = (1,0.8682783,0,1)
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
            uniform sampler2D _node_1780; uniform float4 _node_1780_ST;
            uniform sampler2D _node_1055; uniform float4 _node_1055_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _node_2295)
                UNITY_DEFINE_INSTANCED_PROP( float4, _node_1700)
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
                float4 _node_1700_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_1700 );
                float4 _node_1780_var = tex2D(_node_1780,TRANSFORM_TEX(i.uv0, _node_1780));
                float3 emissive = (_node_1700_var.rgb*_node_1780_var.rgb);
                float3 finalColor = emissive;
                float4 node_1028 = _Time;
                float2 node_1290 = (i.uv0+(node_1028.g*float2(0,0.3)));
                float4 _node_1055_var = tex2D(_node_1055,TRANSFORM_TEX(node_1290, _node_1055));
                float _node_2295_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_2295 );
                return fixed4(finalColor,(_node_1780_var.a*(_node_1055_var.r+_node_2295_var)));
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
