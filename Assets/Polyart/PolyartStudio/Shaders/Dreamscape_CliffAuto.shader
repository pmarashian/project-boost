// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Polyart/Dreamscape CliffAuto"
{
	Properties
	{
		_StoneDirtSharpness("Stone Dirt Sharpness", Float) = 0
		_StoneDirtBias("Stone Dirt Bias", Float) = 0
		_GrassSharpness("Grass Sharpness", Float) = 0
		_GrassBias("Grass Bias", Float) = 0
		_Normal("Normal", Range( 0 , 2)) = 1
		_SmoothnessMultiplier("Smoothness Multiplier", Range( -2 , 2)) = 1
		_StoneColor("Stone Color", 2D) = "white" {}
		_GrassColour("Grass Colour", 2D) = "white" {}
		_GrassSmooth("Grass Smooth", 2D) = "white" {}
		_GrassNormal("Grass Normal", 2D) = "bump" {}
		_DirtColor("Dirt Color", 2D) = "white" {}
		_DirtNormal("Dirt Normal", 2D) = "bump" {}
		_StoneSmooth("Stone Smooth", 2D) = "white" {}
		_DirtSmooth("Dirt Smooth", 2D) = "white" {}
		_StoneNormal("Stone Normal", 2D) = "bump" {}
		_CliffTiling("Cliff Tiling", Vector) = (1,1,0,0)
		_Tiling("Tiling", Vector) = (1,1,0,0)
		_GrassTint("Grass Tint", Color) = (1,1,1,0)
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGINCLUDE
		#include "UnityStandardUtils.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.5
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
		};

		uniform sampler2D _StoneNormal;
		uniform float2 _CliffTiling;
		uniform sampler2D _DirtNormal;
		uniform float2 _Tiling;
		uniform float _StoneDirtSharpness;
		uniform float _StoneDirtBias;
		uniform sampler2D _GrassNormal;
		uniform float _GrassSharpness;
		uniform float _GrassBias;
		uniform float _Normal;
		uniform sampler2D _StoneColor;
		uniform sampler2D _DirtColor;
		uniform float4 _GrassTint;
		uniform sampler2D _GrassColour;
		uniform sampler2D _StoneSmooth;
		uniform sampler2D _DirtSmooth;
		uniform sampler2D _GrassSmooth;
		uniform float _SmoothnessMultiplier;


		inline float4 TriplanarSampling193( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
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


		inline float4 TriplanarSampling213( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
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


		inline float4 TriplanarSampling195( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
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


		inline float4 TriplanarSampling205( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
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


		inline float4 TriplanarSampling192( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
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


		inline float4 TriplanarSampling194( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
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


		inline float4 TriplanarSampling201( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
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


		inline float4 TriplanarSampling216( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
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


		inline float4 TriplanarSampling217( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
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


		inline float4 TriplanarSampling207( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
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
			float2 vCliffTiling197 = ( _CliffTiling / float2( 10,10 ) );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float4 triplanar193 = TriplanarSampling193( _StoneNormal, ase_worldPos, ase_worldNormal, 1.0, vCliffTiling197, 1.0, 0 );
			float4 triplanar213 = TriplanarSampling213( _DirtNormal, ase_worldPos, ase_worldNormal, 1.0, vCliffTiling197, 1.0, 0 );
			float2 VTiling220 = ( _Tiling / float2( 10,10 ) );
			float4 triplanar195 = TriplanarSampling195( _DirtNormal, ase_worldPos, ase_worldNormal, 1.0, VTiling220, 1.0, 0 );
			float3 normalizeResult58_g125 = normalize( float3(0,1,0) );
			float dotResult57_g125 = dot( normalize( (WorldNormalVector( i , UnpackNormal( triplanar195 ) )) ) , normalizeResult58_g125 );
			float temp_output_67_0_g125 = _StoneDirtSharpness;
			float temp_output_68_0_g125 = _StoneDirtBias;
			float clampResult66_g125 = clamp( ( ( ( ( dotResult57_g125 * 0.5 ) + 0.5 ) * temp_output_67_0_g125 ) + ( temp_output_68_0_g125 - ( temp_output_67_0_g125 * 0.5 ) ) ) , 0.0 , 1.0 );
			float temp_output_60_55 = clampResult66_g125;
			float4 lerpResult47 = lerp( triplanar193 , triplanar213 , temp_output_60_55);
			float4 vStoneDirtNormal72 = lerpResult47;
			float4 triplanar205 = TriplanarSampling205( _GrassNormal, ase_worldPos, ase_worldNormal, 1.0, VTiling220, 1.0, 0 );
			float3 ase_normWorldNormal = normalize( ase_worldNormal );
			float3 normalizeResult44_g126 = normalize( float3(0,1,0) );
			float dotResult45_g126 = dot( ase_normWorldNormal , normalizeResult44_g126 );
			float temp_output_67_0_g126 = _GrassSharpness;
			float temp_output_68_0_g126 = _GrassBias;
			float clampResult41_g126 = clamp( ( ( ( ( dotResult45_g126 * 0.5 ) + 0.5 ) * temp_output_67_0_g126 ) + ( temp_output_68_0_g126 - ( temp_output_67_0_g126 * 0.5 ) ) ) , 0.0 , 1.0 );
			float temp_output_57_25 = clampResult41_g126;
			float4 lerpResult88 = lerp( vStoneDirtNormal72 , triplanar205 , temp_output_57_25);
			o.Normal = UnpackScaleNormal( lerpResult88, _Normal );
			float4 triplanar192 = TriplanarSampling192( _StoneColor, ase_worldPos, ase_worldNormal, 1.0, vCliffTiling197, 1.0, 0 );
			float4 triplanar194 = TriplanarSampling194( _DirtColor, ase_worldPos, ase_worldNormal, 1.0, VTiling220, 1.0, 0 );
			float4 lerpResult54 = lerp( triplanar192 , triplanar194 , temp_output_60_55);
			float4 vStoneDirtColor61 = lerpResult54;
			float4 triplanar201 = TriplanarSampling201( _GrassColour, ase_worldPos, ase_worldNormal, 1.0, VTiling220, 1.0, 0 );
			float4 lerpResult34 = lerp( vStoneDirtColor61 , ( _GrassTint * triplanar201 ) , temp_output_57_25);
			o.Albedo = lerpResult34.rgb;
			float4 triplanar216 = TriplanarSampling216( _StoneSmooth, ase_worldPos, ase_worldNormal, 1.0, vCliffTiling197, 1.0, 0 );
			float4 triplanar217 = TriplanarSampling217( _DirtSmooth, ase_worldPos, ase_worldNormal, 1.0, vCliffTiling197, 1.0, 0 );
			float4 lerpResult81 = lerp( triplanar216 , triplanar217 , temp_output_60_55);
			float4 vStoneDirtSmooth82 = lerpResult81;
			float4 triplanar207 = TriplanarSampling207( _GrassSmooth, ase_worldPos, ase_worldNormal, 1.0, VTiling220, 1.0, 0 );
			float4 lerpResult210 = lerp( vStoneDirtSmooth82 , triplanar207 , float4( 0,0,0,0 ));
			o.Smoothness = ( ( 1.0 - lerpResult210 ) * _SmoothnessMultiplier ).x;
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
			#pragma target 3.5
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
				float4 tSpace0 : TEXCOORD1;
				float4 tSpace1 : TEXCOORD2;
				float4 tSpace2 : TEXCOORD3;
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
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
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
Version=18910
756;73;2308;1317;2680.289;2403.626;1;True;True
Node;AmplifyShaderEditor.Vector2Node;218;-6017.847,-1248.075;Inherit;False;Property;_Tiling;Tiling;16;0;Create;True;0;0;0;False;0;False;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleDivideOpNode;219;-5827.226,-1243.348;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;10,10;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;220;-5665.847,-1250.075;Inherit;False;VTiling;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;196;-6016.07,-1408.874;Inherit;False;Property;_CliffTiling;Cliff Tiling;15;0;Create;True;0;0;0;False;0;False;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;200;-4980.431,-1230.21;Inherit;False;220;VTiling;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;199;-5824.448,-1403.147;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;10,10;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;62;-5026.395,-1419.566;Inherit;True;Property;_DirtNormal;Dirt Normal;11;0;Create;True;0;0;0;False;0;False;None;None;False;bump;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TriplanarNode;195;-4651.269,-1414.969;Inherit;True;Spherical;World;False;Top Texture 3;_TopTexture3;white;-1;None;Mid Texture 3;_MidTexture3;white;-1;None;Bot Texture 3;_BotTexture3;white;-1;None;Triplanar Sampler;Tangent;10;0;SAMPLER2D;;False;5;FLOAT;1;False;1;SAMPLER2D;;False;6;FLOAT;0;False;2;SAMPLER2D;;False;7;FLOAT;0;False;9;FLOAT3;0,0,0;False;8;FLOAT;1;False;3;FLOAT2;1,1;False;4;FLOAT;1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;197;-5663.07,-1409.874;Inherit;False;vCliffTiling;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;74;-4042.076,-642.3586;Inherit;True;Property;_StoneSmooth;Stone Smooth;12;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexturePropertyNode;73;-4044.988,-385.8292;Inherit;True;Property;_DirtSmooth;Dirt Smooth;13;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.UnpackScaleNormalNode;64;-4251.296,-1414.198;Inherit;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;29;-4257.382,-1585.781;Inherit;False;Property;_StoneDirtSharpness;Stone Dirt Sharpness;0;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;212;-3992.793,-770.3837;Inherit;False;197;vCliffTiling;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-4213.733,-1511.15;Inherit;False;Property;_StoneDirtBias;Stone Dirt Bias;1;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;222;-3992.419,-888.0977;Inherit;False;197;vCliffTiling;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;214;-4347.016,-1017.463;Inherit;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.FunctionNode;60;-3832.638,-1607.276;Inherit;False;PolyartWorldAlignedBlend;-1;;125;2c0b2e018c1710b44867976bd3691e95;0;3;1;FLOAT3;0,0,1;False;67;FLOAT;1;False;68;FLOAT;-1;False;2;FLOAT;25;FLOAT;55
Node;AmplifyShaderEditor.TriplanarNode;217;-3645.914,-377.8295;Inherit;True;Spherical;World;False;Top Texture 9;_TopTexture9;white;-1;None;Mid Texture 9;_MidTexture9;white;-1;None;Bot Texture 9;_BotTexture9;white;-1;None;Triplanar Sampler;World;10;0;SAMPLER2D;;False;5;FLOAT;1;False;1;SAMPLER2D;;False;6;FLOAT;0;False;2;SAMPLER2D;;False;7;FLOAT;0;False;9;FLOAT3;0,0,0;False;8;FLOAT;1;False;3;FLOAT2;1,1;False;4;FLOAT;1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;68;-4021.483,-1211.884;Inherit;True;Property;_StoneNormal;Stone Normal;14;0;Create;True;0;0;0;False;0;False;None;None;False;bump;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TriplanarNode;216;-3645.813,-636.1625;Inherit;True;Spherical;World;False;Top Texture 8;_TopTexture8;white;-1;None;Mid Texture 8;_MidTexture8;white;-1;None;Bot Texture 8;_BotTexture8;white;-1;None;Triplanar Sampler;World;10;0;SAMPLER2D;;False;5;FLOAT;1;False;1;SAMPLER2D;;False;6;FLOAT;0;False;2;SAMPLER2D;;False;7;FLOAT;0;False;9;FLOAT3;0,0,0;False;8;FLOAT;1;False;3;FLOAT2;1,1;False;4;FLOAT;1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;198;-4025.171,-1723.974;Inherit;False;220;VTiling;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;55;-4245.437,-1804.354;Inherit;True;Property;_DirtColor;Dirt Color;10;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TriplanarNode;213;-3652.016,-932.4634;Inherit;True;Spherical;World;False;Top Texture 7;_TopTexture7;white;-1;None;Mid Texture 7;_MidTexture7;white;-1;None;Bot Texture 7;_BotTexture7;white;-1;None;Triplanar Sampler;World;10;0;SAMPLER2D;;False;5;FLOAT;1;False;1;SAMPLER2D;;False;6;FLOAT;0;False;2;SAMPLER2D;;False;7;FLOAT;0;False;9;FLOAT3;0,0,0;False;8;FLOAT;1;False;3;FLOAT2;1,1;False;4;FLOAT;1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TriplanarNode;193;-3646.153,-1192.041;Inherit;True;Spherical;World;False;Top Texture 1;_TopTexture1;white;-1;None;Mid Texture 1;_MidTexture1;white;-1;None;Bot Texture 1;_BotTexture1;white;-1;None;Triplanar Sampler;World;10;0;SAMPLER2D;;False;5;FLOAT;1;False;1;SAMPLER2D;;False;6;FLOAT;0;False;2;SAMPLER2D;;False;7;FLOAT;0;False;9;FLOAT3;0,0,0;False;8;FLOAT;1;False;3;FLOAT2;1,1;False;4;FLOAT;1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;52;-4247.629,-2037.299;Inherit;True;Property;_StoneColor;Stone Color;6;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.GetLocalVarNode;221;-4024.419,-1965.098;Inherit;False;197;vCliffTiling;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;81;-2991.711,-403.5161;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.LerpOp;47;-2904.657,-960.169;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;209;-2110.257,-308.9713;Inherit;False;220;VTiling;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;208;-2156.037,-495.675;Inherit;True;Property;_GrassSmooth;Grass Smooth;8;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RegisterLocalVarNode;203;-3920.979,-1422.281;Inherit;False;vExplicitNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;82;-2742.754,-408.824;Inherit;False;vStoneDirtSmooth;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TriplanarNode;194;-3779.896,-1799.598;Inherit;True;Spherical;World;False;Top Texture 2;_TopTexture2;white;-1;None;Mid Texture 2;_MidTexture2;white;-1;None;Bot Texture 2;_BotTexture2;white;-1;None;Triplanar Sampler;Tangent;10;0;SAMPLER2D;;False;5;FLOAT;1;False;1;SAMPLER2D;;False;6;FLOAT;0;False;2;SAMPLER2D;;False;7;FLOAT;0;False;9;FLOAT3;0,0,0;False;8;FLOAT;1;False;3;FLOAT2;1,1;False;4;FLOAT;1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TriplanarNode;192;-3797.596,-2006.801;Inherit;True;Spherical;World;False;Top Texture 0;_TopTexture0;white;-1;None;Mid Texture 0;_MidTexture0;white;-1;None;Bot Texture 0;_BotTexture0;white;-1;None;Triplanar Sampler;Tangent;10;0;SAMPLER2D;;False;5;FLOAT;1;False;1;SAMPLER2D;;False;6;FLOAT;0;False;2;SAMPLER2D;;False;7;FLOAT;0;False;9;FLOAT3;0,0,0;False;8;FLOAT;1;False;3;FLOAT2;1,1;False;4;FLOAT;1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;206;-2258.376,-914.1042;Inherit;False;220;VTiling;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;86;-2300.155,-1100.808;Inherit;True;Property;_GrassNormal;Grass Normal;9;0;Create;True;0;0;0;False;0;False;None;None;False;bump;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.LerpOp;54;-3267.842,-1738.268;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;211;-1701.599,-596.4031;Inherit;False;82;vStoneDirtSmooth;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-2492.051,-1333.158;Inherit;False;Property;_GrassSharpness;Grass Sharpness;2;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;84;-2327.3,-1720.301;Inherit;True;Property;_GrassColour;Grass Colour;7;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RangedFloatNode;37;-2448.885,-1251.239;Inherit;False;Property;_GrassBias;Grass Bias;3;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;204;-2511.491,-1416.254;Inherit;False;203;vExplicitNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;72;-2633.105,-965.6179;Inherit;False;vStoneDirtNormal;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TriplanarNode;207;-1852.257,-489.9711;Inherit;True;Spherical;World;False;Top Texture 6;_TopTexture6;white;-1;None;Mid Texture 6;_MidTexture6;white;-1;None;Bot Texture 6;_BotTexture6;white;-1;None;Triplanar Sampler;Tangent;10;0;SAMPLER2D;;False;5;FLOAT;1;False;1;SAMPLER2D;;False;6;FLOAT;0;False;2;SAMPLER2D;;False;7;FLOAT;0;False;9;FLOAT3;0,0,0;False;8;FLOAT;1;False;3;FLOAT2;1,1;False;4;FLOAT;1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;202;-2284.645,-1532.123;Inherit;False;220;VTiling;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;210;-1382.464,-591.0471;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;89;-1848.718,-1201.536;Inherit;False;72;vStoneDirtNormal;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TriplanarNode;205;-2000.376,-1095.104;Inherit;True;Spherical;World;False;Top Texture 5;_TopTexture5;white;-1;None;Mid Texture 5;_MidTexture5;white;-1;None;Bot Texture 5;_BotTexture5;white;-1;None;Triplanar Sampler;Tangent;10;0;SAMPLER2D;;False;5;FLOAT;1;False;1;SAMPLER2D;;False;6;FLOAT;0;False;2;SAMPLER2D;;False;7;FLOAT;0;False;9;FLOAT3;0,0,0;False;8;FLOAT;1;False;3;FLOAT2;1,1;False;4;FLOAT;1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;57;-2069.045,-1408.43;Inherit;False;PolyartWorldAlignedBlend;-1;;126;2c0b2e018c1710b44867976bd3691e95;0;3;1;FLOAT3;0,0,1;False;67;FLOAT;1;False;68;FLOAT;-1;False;2;FLOAT;25;FLOAT;55
Node;AmplifyShaderEditor.RegisterLocalVarNode;61;-3066.32,-1742.408;Inherit;False;vStoneDirtColor;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TriplanarNode;201;-2029.786,-1717.117;Inherit;True;Spherical;World;False;Top Texture 4;_TopTexture4;white;-1;None;Mid Texture 4;_MidTexture4;white;-1;None;Bot Texture 4;_BotTexture4;white;-1;None;Triplanar Sampler;Tangent;10;0;SAMPLER2D;;False;5;FLOAT;1;False;1;SAMPLER2D;;False;6;FLOAT;0;False;2;SAMPLER2D;;False;7;FLOAT;0;False;9;FLOAT3;0,0,0;False;8;FLOAT;1;False;3;FLOAT2;1,1;False;4;FLOAT;1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;224;-1968.289,-1959.626;Inherit;False;Property;_GrassTint;Grass Tint;17;0;Create;True;0;0;0;False;0;False;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;223;-1557.289,-1715.626;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;40;-1605.404,-1045.721;Inherit;False;Property;_Normal;Normal;4;0;Create;True;0;0;0;False;0;False;1;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;88;-1467.582,-1194.18;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.OneMinusNode;45;-1230.621,-595.3173;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;85;-1418.652,-1800.492;Inherit;False;61;vStoneDirtColor;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-1377.145,-464.3606;Inherit;False;Property;_SmoothnessMultiplier;Smoothness Multiplier;5;0;Create;True;0;0;0;False;0;False;1;0;-2;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;34;-1023.738,-1742.8;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.UnpackScaleNormalNode;90;-1272.748,-1194.18;Inherit;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;44;-1069.677,-597.2112;Inherit;True;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-695.7205,-1222.164;Float;False;True;-1;3;;0;0;Standard;Polyart/Dreamscape CliffAuto;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;16;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;219;0;218;0
WireConnection;220;0;219;0
WireConnection;199;0;196;0
WireConnection;195;0;62;0
WireConnection;195;3;200;0
WireConnection;197;0;199;0
WireConnection;64;0;195;0
WireConnection;214;0;62;0
WireConnection;60;1;64;0
WireConnection;60;67;29;0
WireConnection;60;68;30;0
WireConnection;217;0;73;0
WireConnection;217;3;212;0
WireConnection;216;0;74;0
WireConnection;216;3;222;0
WireConnection;213;0;214;0
WireConnection;213;3;212;0
WireConnection;193;0;68;0
WireConnection;193;3;222;0
WireConnection;81;0;216;0
WireConnection;81;1;217;0
WireConnection;81;2;60;55
WireConnection;47;0;193;0
WireConnection;47;1;213;0
WireConnection;47;2;60;55
WireConnection;203;0;64;0
WireConnection;82;0;81;0
WireConnection;194;0;55;0
WireConnection;194;3;198;0
WireConnection;192;0;52;0
WireConnection;192;3;221;0
WireConnection;54;0;192;0
WireConnection;54;1;194;0
WireConnection;54;2;60;55
WireConnection;72;0;47;0
WireConnection;207;0;208;0
WireConnection;207;3;209;0
WireConnection;210;0;211;0
WireConnection;210;1;207;0
WireConnection;205;0;86;0
WireConnection;205;3;206;0
WireConnection;57;1;204;0
WireConnection;57;67;36;0
WireConnection;57;68;37;0
WireConnection;61;0;54;0
WireConnection;201;0;84;0
WireConnection;201;3;202;0
WireConnection;223;0;224;0
WireConnection;223;1;201;0
WireConnection;88;0;89;0
WireConnection;88;1;205;0
WireConnection;88;2;57;25
WireConnection;45;0;210;0
WireConnection;34;0;85;0
WireConnection;34;1;223;0
WireConnection;34;2;57;25
WireConnection;90;0;88;0
WireConnection;90;1;40;0
WireConnection;44;0;45;0
WireConnection;44;1;43;0
WireConnection;0;0;34;0
WireConnection;0;1;90;0
WireConnection;0;4;44;0
ASEEND*/
//CHKSM=3DA326813C8805BD914B378F03CF4BAC51B13B24