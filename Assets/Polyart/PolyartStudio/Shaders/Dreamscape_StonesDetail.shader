// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Polyart/Dreamscape Stones Detail"
{
	Properties
	{
		_TilingAlbedo("Tiling Albedo", 2D) = "white" {}
		_TilingSmoothness("Tiling Smoothness", 2D) = "white" {}
		_TilingNormal("Tiling Normal", 2D) = "bump" {}
		_TilingNormalIntensity("Tiling Normal Intensity", Range( 0 , 2)) = 1
		[Header(MAIN)]_AlbedoTint("Albedo Tint", Color) = (1,1,1,0)
		_AlbedoTexture("Albedo Texture", 2D) = "white" {}
		_NormalTexture("Normal Texture", 2D) = "bump" {}
		_NormalIntensity("Normal Intensity", Range( 0 , 2)) = 1
		_SmoothnessTexture("Smoothness Texture", 2D) = "white" {}
		_SmoothnessMultiplier("Smoothness Multiplier", Range( 0 , 2)) = 1
		_EmissiveTexture("Emissive Texture", 2D) = "black" {}
		_EmissiveMultiplier("Emissive Multiplier", Range( 0 , 20)) = 0
		_EmissiveTint("Emissive Tint", Color) = (1,1,1,0)
		_DetailColorIntensity("Detail Color Intensity", Range( 0 , 1)) = 1
		_DetailSmoothIntensity("Detail Smooth Intensity", Range( 0 , 1)) = 1
		_Tiling("Tiling", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityStandardUtils.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
			float2 uv_texcoord;
		};

		uniform sampler2D _TilingNormal;
		uniform float _Tiling;
		uniform float _TilingNormalIntensity;
		uniform sampler2D _NormalTexture;
		uniform float4 _NormalTexture_ST;
		uniform float _NormalIntensity;
		uniform sampler2D _TilingAlbedo;
		uniform float4 _AlbedoTint;
		uniform sampler2D _AlbedoTexture;
		uniform float4 _AlbedoTexture_ST;
		uniform float _DetailColorIntensity;
		uniform sampler2D _EmissiveTexture;
		uniform float4 _EmissiveTexture_ST;
		uniform float4 _EmissiveTint;
		uniform float _EmissiveMultiplier;
		uniform sampler2D _TilingSmoothness;
		uniform sampler2D _SmoothnessTexture;
		uniform float4 _SmoothnessTexture_ST;
		uniform float _SmoothnessMultiplier;
		uniform float _DetailSmoothIntensity;


		inline float4 TriplanarSampling72( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
		{
			float3 projNormal = ( pow( abs( worldNormal ), falloff ) );
			projNormal /= ( projNormal.x + projNormal.y + projNormal.z ) + 0.00001;
			float3 nsign = sign( worldNormal );
			half4 xNorm; half4 yNorm; half4 zNorm;
			xNorm = tex2D( topTexMap, tiling * worldPos.zy * float2(  nsign.x, 1.0 ) );
			yNorm = tex2D( topTexMap, tiling * worldPos.xz * float2(  nsign.y, 1.0 ) );
			zNorm = tex2D( topTexMap, tiling * worldPos.xy * float2( -nsign.z, 1.0 ) );
			return xNorm * projNormal.x + yNorm * projNormal.y + zNorm * projNormal.z;
		}


		inline float4 TriplanarSampling71( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
		{
			float3 projNormal = ( pow( abs( worldNormal ), falloff ) );
			projNormal /= ( projNormal.x + projNormal.y + projNormal.z ) + 0.00001;
			float3 nsign = sign( worldNormal );
			half4 xNorm; half4 yNorm; half4 zNorm;
			xNorm = tex2D( topTexMap, tiling * worldPos.zy * float2(  nsign.x, 1.0 ) );
			yNorm = tex2D( topTexMap, tiling * worldPos.xz * float2(  nsign.y, 1.0 ) );
			zNorm = tex2D( topTexMap, tiling * worldPos.xy * float2( -nsign.z, 1.0 ) );
			return xNorm * projNormal.x + yNorm * projNormal.y + zNorm * projNormal.z;
		}


		inline float4 TriplanarSampling73( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
		{
			float3 projNormal = ( pow( abs( worldNormal ), falloff ) );
			projNormal /= ( projNormal.x + projNormal.y + projNormal.z ) + 0.00001;
			float3 nsign = sign( worldNormal );
			half4 xNorm; half4 yNorm; half4 zNorm;
			xNorm = tex2D( topTexMap, tiling * worldPos.zy * float2(  nsign.x, 1.0 ) );
			yNorm = tex2D( topTexMap, tiling * worldPos.xz * float2(  nsign.y, 1.0 ) );
			zNorm = tex2D( topTexMap, tiling * worldPos.xy * float2( -nsign.z, 1.0 ) );
			return xNorm * projNormal.x + yNorm * projNormal.y + zNorm * projNormal.z;
		}


		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 temp_cast_0 = (_Tiling).xx;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float4 triplanar72 = TriplanarSampling72( _TilingNormal, ase_worldPos, ase_worldNormal, 1.0, temp_cast_0, 1.0, 0 );
			float3 vTilingNormal45 = UnpackScaleNormal( triplanar72, _TilingNormalIntensity );
			float2 uv_NormalTexture = i.uv_texcoord * _NormalTexture_ST.xy + _NormalTexture_ST.zw;
			float3 vNormal13 = UnpackScaleNormal( tex2D( _NormalTexture, uv_NormalTexture ), _NormalIntensity );
			o.Normal = BlendNormals( vTilingNormal45 , vNormal13 );
			float2 temp_cast_2 = (_Tiling).xx;
			float4 triplanar71 = TriplanarSampling71( _TilingAlbedo, ase_worldPos, ase_worldNormal, 1.0, temp_cast_2, 1.0, 0 );
			float4 vTilingColor41 = triplanar71;
			float2 uv_AlbedoTexture = i.uv_texcoord * _AlbedoTexture_ST.xy + _AlbedoTexture_ST.zw;
			float4 vColor12 = ( _AlbedoTint * tex2D( _AlbedoTexture, uv_AlbedoTexture ) );
			float4 lerpResult57 = lerp( vTilingColor41 , vColor12 , _DetailColorIntensity);
			o.Albedo = lerpResult57.rgb;
			float2 uv_EmissiveTexture = i.uv_texcoord * _EmissiveTexture_ST.xy + _EmissiveTexture_ST.zw;
			float4 vEmissive31 = ( ( tex2D( _EmissiveTexture, uv_EmissiveTexture ) * _EmissiveTint ) * _EmissiveMultiplier );
			o.Emission = vEmissive31.rgb;
			o.Metallic = 0.0;
			float2 temp_cast_6 = (_Tiling).xx;
			float4 triplanar73 = TriplanarSampling73( _TilingSmoothness, ase_worldPos, ase_worldNormal, 1.0, temp_cast_6, 1.0, 0 );
			float4 vTilingSmooth52 = ( 1.0 - triplanar73 );
			float2 uv_SmoothnessTexture = i.uv_texcoord * _SmoothnessTexture_ST.xy + _SmoothnessTexture_ST.zw;
			float4 vSmoothness24 = ( ( 1.0 - tex2D( _SmoothnessTexture, uv_SmoothnessTexture ) ) * _SmoothnessMultiplier );
			float4 lerpResult64 = lerp( vTilingSmooth52 , vSmoothness24 , _DetailSmoothIntensity);
			o.Smoothness = lerpResult64.r;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
}
/*ASEBEGIN
Version=18912
1038;114;2305;1679;2437.862;2179.91;1.3;True;True
Node;AmplifyShaderEditor.CommentaryNode;25;-1561.519,512.3214;Inherit;False;1230.501;368.35;;6;24;23;22;38;21;20;Smooth;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;11;-1557.127,103.3116;Inherit;False;1123.488;335.8192;;3;7;8;10;Normal;1,1,1,1;0;0
Node;AmplifyShaderEditor.TexturePropertyNode;20;-1549.519,571.3214;Inherit;True;Property;_SmoothnessTexture;Smoothness Texture;8;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.CommentaryNode;51;-1514.76,-948.0509;Inherit;False;1119.636;285;Comment;3;52;55;53;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;44;-1515.36,-1262.112;Inherit;False;1272.636;288;Comment;5;45;49;46;48;72;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;30;-1603.472,927.7177;Inherit;False;1546.638;392.0339;;6;31;29;28;27;26;69;Emissive;1,1,1,1;0;0
Node;AmplifyShaderEditor.TexturePropertyNode;1;-1501.494,-162.2611;Inherit;True;Property;_AlbedoTexture;Albedo Texture;5;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexturePropertyNode;26;-1552.472,977.7177;Inherit;True;Property;_EmissiveTexture;Emissive Texture;10;0;Create;True;0;0;0;False;0;False;None;None;False;black;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.CommentaryNode;6;-1551.494,-395.261;Inherit;False;1117;458.0442;;1;3;Color;1,1,1,1;0;0
Node;AmplifyShaderEditor.TexturePropertyNode;46;-1465.36,-1212.112;Inherit;True;Property;_TilingNormal;Tiling Normal;2;0;Create;True;0;0;0;False;0;False;None;None;False;bump;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexturePropertyNode;53;-1464.76,-898.0509;Inherit;True;Property;_TilingSmoothness;Tiling Smoothness;1;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SamplerNode;21;-1289.588,571.6713;Inherit;True;Property;_TextureSample3;Texture Sample 3;11;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;68;-2059.23,-1156.745;Inherit;False;Property;_Tiling;Tiling;15;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;42;-1516.958,-1565.495;Inherit;False;955.6365;280;Comment;3;40;41;71;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TexturePropertyNode;7;-1507.127,153.3116;Inherit;True;Property;_NormalTexture;Normal Texture;6;0;Create;True;0;0;0;False;0;False;None;None;False;bump;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SamplerNode;8;-1270.118,153.3407;Inherit;True;Property;_TextureSample1;Texture Sample 1;11;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;40;-1466.958,-1515.495;Inherit;True;Property;_TilingAlbedo;Tiling Albedo;0;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SamplerNode;27;-1311.54,978.0676;Inherit;True;Property;_TextureSample2;Texture Sample 2;11;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;3;-1178.494,-345.261;Inherit;False;Property;_AlbedoTint;Albedo Tint;4;0;Create;True;0;0;0;False;1;Header(MAIN);False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;38;-971.063,577.1153;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-1267.588,775.6718;Inherit;False;Property;_SmoothnessMultiplier;Smoothness Multiplier;9;0;Create;True;0;0;0;False;0;False;1;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;49;-1106.729,-1048.89;Inherit;False;Property;_TilingNormalIntensity;Tiling Normal Intensity;3;0;Create;True;0;0;0;False;0;False;1;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-1261.117,-162.2169;Inherit;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;70;-1235.835,1167.674;Inherit;False;Property;_EmissiveTint;Emissive Tint;12;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TriplanarNode;73;-1246.414,-895.5099;Inherit;True;Spherical;World;False;Top Texture 2;_TopTexture2;white;-1;None;Mid Texture 2;_MidTexture2;white;-1;None;Bot Texture 2;_BotTexture2;white;-1;None;Triplanar Sampler;Tangent;10;0;SAMPLER2D;;False;5;FLOAT;1;False;1;SAMPLER2D;;False;6;FLOAT;0;False;2;SAMPLER2D;;False;7;FLOAT;0;False;9;FLOAT3;0,0,0;False;8;FLOAT;1;False;3;FLOAT2;1,1;False;4;FLOAT;1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TriplanarNode;72;-1206.113,-1230.91;Inherit;True;Spherical;World;False;Top Texture 1;_TopTexture1;white;-1;None;Mid Texture 1;_MidTexture1;white;-1;None;Bot Texture 1;_BotTexture1;white;-1;None;Triplanar Sampler;Tangent;10;0;SAMPLER2D;;False;5;FLOAT;1;False;1;SAMPLER2D;;False;6;FLOAT;0;False;2;SAMPLER2D;;False;7;FLOAT;0;False;9;FLOAT3;0,0,0;False;8;FLOAT;1;False;3;FLOAT2;1,1;False;4;FLOAT;1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;10;-1249.639,348.1309;Inherit;False;Property;_NormalIntensity;Normal Intensity;7;0;Create;True;0;0;0;False;0;False;1;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;69;-956.5471,984.1055;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;55;-856.1749,-896.0762;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.UnpackScaleNormalNode;48;-782.808,-1142.149;Inherit;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;29;-1023.54,1202.067;Inherit;False;Property;_EmissiveMultiplier;Emissive Multiplier;11;0;Create;True;0;0;0;False;0;False;0;0;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.UnpackScaleNormalNode;9;-936.6394,159.131;Inherit;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-798.5193,574.3214;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TriplanarNode;71;-1224.313,-1511.71;Inherit;True;Spherical;World;False;Top Texture 0;_TopTexture0;white;-1;None;Mid Texture 0;_MidTexture0;white;-1;None;Bot Texture 0;_BotTexture0;white;-1;None;Triplanar Sampler;Tangent;10;0;SAMPLER2D;;False;5;FLOAT;1;False;1;SAMPLER2D;;False;6;FLOAT;0;False;2;SAMPLER2D;;False;7;FLOAT;0;False;9;FLOAT3;0,0,0;False;8;FLOAT;1;False;3;FLOAT2;1,1;False;4;FLOAT;1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-846.4939,-274.261;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;45;-485.7234,-1148.341;Inherit;False;vTilingNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;41;-813.4213,-1517.326;Inherit;False;vTilingColor;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;52;-684.5228,-900.1794;Inherit;False;vTilingSmooth;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;13;-643.4674,153.8047;Inherit;False;vNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;-666.4714,985.7177;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;24;-549.0178,569.7578;Inherit;False;vSmoothness;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;12;-698.8083,-278.5661;Inherit;False;vColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;32;269.2069,13.4745;Inherit;False;41;vTilingColor;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;33;313.0252,766.6553;Inherit;False;45;vTilingNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;59;272.7181,181.4322;Inherit;False;Property;_DetailColorIntensity;Detail Color Intensity;13;0;Create;True;0;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;31;-370.4042,980.7227;Inherit;False;vEmissive;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;62;60.7815,411.0215;Inherit;False;24;vSmoothness;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;60;-5.736343,502.9773;Inherit;False;Property;_DetailSmoothIntensity;Detail Smooth Intensity;14;0;Create;True;0;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;61;54.51844,324.3857;Inherit;False;52;vTilingSmooth;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;56;347.7428,849.7459;Inherit;False;13;vNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;58;269.9245,93.56525;Inherit;False;12;vColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendNormalsNode;43;584.2504,770.6715;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;50;543.8029,473.1821;Inherit;False;Constant;_Float1;Float 1;11;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;57;634.9246,80.56525;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;34;503.207,338.4745;Inherit;False;31;vEmissive;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;64;346.7815,392.0215;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;850.0451,297.7184;Float;False;True;-1;2;;0;0;Standard;Polyart/Dreamscape Stones Detail;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;21;0;20;0
WireConnection;8;0;7;0
WireConnection;27;0;26;0
WireConnection;38;0;21;0
WireConnection;2;0;1;0
WireConnection;73;0;53;0
WireConnection;73;3;68;0
WireConnection;72;0;46;0
WireConnection;72;3;68;0
WireConnection;69;0;27;0
WireConnection;69;1;70;0
WireConnection;55;0;73;0
WireConnection;48;0;72;0
WireConnection;48;1;49;0
WireConnection;9;0;8;0
WireConnection;9;1;10;0
WireConnection;23;0;38;0
WireConnection;23;1;22;0
WireConnection;71;0;40;0
WireConnection;71;3;68;0
WireConnection;4;0;3;0
WireConnection;4;1;2;0
WireConnection;45;0;48;0
WireConnection;41;0;71;0
WireConnection;52;0;55;0
WireConnection;13;0;9;0
WireConnection;28;0;69;0
WireConnection;28;1;29;0
WireConnection;24;0;23;0
WireConnection;12;0;4;0
WireConnection;31;0;28;0
WireConnection;43;0;33;0
WireConnection;43;1;56;0
WireConnection;57;0;32;0
WireConnection;57;1;58;0
WireConnection;57;2;59;0
WireConnection;64;0;61;0
WireConnection;64;1;62;0
WireConnection;64;2;60;0
WireConnection;0;0;57;0
WireConnection;0;1;43;0
WireConnection;0;2;34;0
WireConnection;0;3;50;0
WireConnection;0;4;64;0
ASEEND*/
//CHKSM=C67987EE9BB9F28469EC229C98BDC6D7E2DF23C6