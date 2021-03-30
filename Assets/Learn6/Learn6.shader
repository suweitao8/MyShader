// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32719,y:32712,varname:node_3138,prsc:2|emission-4396-OUT;n:type:ShaderForge.SFN_Tex2d,id:4237,x:32110,y:32673,ptovrint:False,ptlb:node_4237,ptin:_node_4237,varname:node_4237,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:52b2bad47f9c8b84ba219fd78fcd6a08,ntxv:0,isnm:False|UVIN-550-OUT;n:type:ShaderForge.SFN_Tex2d,id:605,x:32125,y:32867,ptovrint:False,ptlb:node_605,ptin:_node_605,varname:node_605,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:77e790d889c69a04288831970326ebc6,ntxv:0,isnm:False|UVIN-4484-OUT;n:type:ShaderForge.SFN_Slider,id:7822,x:31319,y:32912,ptovrint:False,ptlb:node_7822,ptin:_node_7822,varname:node_7822,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.2869565,max:1;n:type:ShaderForge.SFN_Slider,id:8223,x:31281,y:33238,ptovrint:False,ptlb:node_8223,ptin:_node_8223,varname:node_8223,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.1956522,max:1;n:type:ShaderForge.SFN_Lerp,id:4396,x:32357,y:32816,varname:node_4396,prsc:2|A-605-RGB,B-4237-RGB,T-4237-A;n:type:ShaderForge.SFN_TexCoord,id:7405,x:31626,y:32649,varname:node_7405,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_TexCoord,id:8483,x:31670,y:33317,varname:node_8483,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Add,id:550,x:31898,y:32690,varname:node_550,prsc:2|A-7405-UVOUT,B-1900-OUT;n:type:ShaderForge.SFN_Vector2,id:1910,x:31378,y:32752,varname:node_1910,prsc:2,v1:1,v2:0;n:type:ShaderForge.SFN_Multiply,id:1900,x:31692,y:32857,varname:node_1900,prsc:2|A-1910-OUT,B-7822-OUT,C-953-T;n:type:ShaderForge.SFN_Time,id:953,x:31397,y:33012,varname:node_953,prsc:2;n:type:ShaderForge.SFN_Multiply,id:5400,x:31640,y:33135,varname:node_5400,prsc:2|A-1910-OUT,B-953-T,C-8223-OUT;n:type:ShaderForge.SFN_Add,id:4484,x:31893,y:33195,varname:node_4484,prsc:2|A-5400-OUT,B-8483-UVOUT;proporder:4237-605-7822-8223;pass:END;sub:END;*/

Shader "Shader Forge/Learn6" {
    Properties {
        _node_4237 ("node_4237", 2D) = "white" {}
        _node_605 ("node_605", 2D) = "white" {}
        _node_7822 ("node_7822", Range(0, 1)) = 0.2869565
        _node_8223 ("node_8223", Range(0, 1)) = 0.1956522
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
            uniform sampler2D _node_4237; uniform float4 _node_4237_ST;
            uniform sampler2D _node_605; uniform float4 _node_605_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _node_7822)
                UNITY_DEFINE_INSTANCED_PROP( float, _node_8223)
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
                float2 node_1910 = float2(1,0);
                float4 node_953 = _Time;
                float _node_8223_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_8223 );
                float2 node_4484 = ((node_1910*node_953.g*_node_8223_var)+i.uv0);
                float4 _node_605_var = tex2D(_node_605,TRANSFORM_TEX(node_4484, _node_605));
                float _node_7822_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_7822 );
                float2 node_550 = (i.uv0+(node_1910*_node_7822_var*node_953.g));
                float4 _node_4237_var = tex2D(_node_4237,TRANSFORM_TEX(node_550, _node_4237));
                float3 emissive = lerp(_node_605_var.rgb,_node_4237_var.rgb,_node_4237_var.a);
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
