// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33788,y:32637,varname:node_3138,prsc:2|emission-9890-OUT,alpha-2341-OUT;n:type:ShaderForge.SFN_TexCoord,id:3223,x:31992,y:32669,varname:node_3223,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Length,id:9955,x:32558,y:32753,varname:node_9955,prsc:2|IN-2696-OUT;n:type:ShaderForge.SFN_RemapRange,id:2696,x:32174,y:32669,varname:node_2696,prsc:2,frmn:0,frmx:1,tomn:-1,tomx:1|IN-3223-UVOUT;n:type:ShaderForge.SFN_Floor,id:1605,x:32769,y:32827,varname:node_1605,prsc:2|IN-9955-OUT;n:type:ShaderForge.SFN_OneMinus,id:3572,x:32976,y:32827,varname:node_3572,prsc:2|IN-1605-OUT;n:type:ShaderForge.SFN_Floor,id:9614,x:32915,y:32596,varname:node_9614,prsc:2|IN-9835-OUT;n:type:ShaderForge.SFN_OneMinus,id:145,x:33109,y:32623,varname:node_145,prsc:2|IN-9614-OUT;n:type:ShaderForge.SFN_Vector1,id:7215,x:32538,y:32596,varname:node_7215,prsc:2,v1:0.1;n:type:ShaderForge.SFN_Add,id:9835,x:32744,y:32596,varname:node_9835,prsc:2|A-7215-OUT,B-9955-OUT;n:type:ShaderForge.SFN_ArcTan2,id:3705,x:32664,y:33049,varname:node_3705,prsc:2,attp:2|A-7440-R,B-9062-OUT;n:type:ShaderForge.SFN_ComponentMask,id:7440,x:32397,y:32977,varname:node_7440,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-2696-OUT;n:type:ShaderForge.SFN_Negate,id:9062,x:32458,y:33192,varname:node_9062,prsc:2|IN-7440-G;n:type:ShaderForge.SFN_Multiply,id:2341,x:33419,y:32909,varname:node_2341,prsc:2|A-3572-OUT,B-7167-OUT;n:type:ShaderForge.SFN_Slider,id:5149,x:32756,y:33287,ptovrint:False,ptlb:node_5149,ptin:_node_5149,varname:node_5149,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.2173913,max:1;n:type:ShaderForge.SFN_Tex2d,id:9576,x:33289,y:32474,ptovrint:False,ptlb:node_9576,ptin:_node_9576,varname:node_9576,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:758ac31a9bff9ac4181f54de54a6ecb7,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:9890,x:33569,y:32686,varname:node_9890,prsc:2|A-9576-RGB,B-2341-OUT;n:type:ShaderForge.SFN_Step,id:9110,x:33137,y:33119,varname:node_9110,prsc:2|A-9744-OUT,B-5149-OUT;n:type:ShaderForge.SFN_OneMinus,id:9744,x:32913,y:33059,varname:node_9744,prsc:2|IN-3705-OUT;n:type:ShaderForge.SFN_Multiply,id:7973,x:33343,y:33153,varname:node_7973,prsc:2|A-9110-OUT,B-7920-OUT;n:type:ShaderForge.SFN_Vector1,id:984,x:33137,y:33341,varname:node_984,prsc:2,v1:1;n:type:ShaderForge.SFN_Subtract,id:2629,x:33403,y:33355,varname:node_2629,prsc:2|A-984-OUT,B-7920-OUT;n:type:ShaderForge.SFN_Slider,id:7920,x:32940,y:33467,ptovrint:False,ptlb:node_7920,ptin:_node_7920,varname:node_7920,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.8,max:1;n:type:ShaderForge.SFN_Add,id:7167,x:33566,y:33166,varname:node_7167,prsc:2|A-7973-OUT,B-2629-OUT;proporder:5149-9576-7920;pass:END;sub:END;*/

Shader "Shader Forge/Test1" {
    Properties {
        _node_5149 ("node_5149", Range(0, 1)) = 0.2173913
        _node_9576 ("node_9576", 2D) = "white" {}
        _node_7920 ("node_7920", Range(0, 1)) = 0.8
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
            uniform sampler2D _node_9576; uniform float4 _node_9576_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _node_5149)
                UNITY_DEFINE_INSTANCED_PROP( float, _node_7920)
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
                float4 _node_9576_var = tex2D(_node_9576,TRANSFORM_TEX(i.uv0, _node_9576));
                float2 node_2696 = (i.uv0*2.0+-1.0);
                float node_9955 = length(node_2696);
                float2 node_7440 = node_2696.rg;
                float _node_5149_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_5149 );
                float _node_7920_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_7920 );
                float node_2341 = ((1.0 - floor(node_9955))*((step((1.0 - ((atan2(node_7440.r,(-1*node_7440.g))/6.28318530718)+0.5)),_node_5149_var)*_node_7920_var)+(1.0-_node_7920_var)));
                float3 emissive = (_node_9576_var.rgb*node_2341);
                float3 finalColor = emissive;
                return fixed4(finalColor,node_2341);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
