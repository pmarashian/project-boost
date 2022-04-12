// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Toon/TFF_CustomGrass"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_TextureSample("Texture Sample", 2D) = "white" {}
		_Color1("Color 1", Color) = (0,0,0,1)
		_Color2("Color 2", Color) = (1,1,1,0)
		_Color1Level("Color 1 Level", Range( 0 , 1)) = 0.35
		[Toggle(_HIGHLIGHTS_ON)] _Highlights("Highlights", Float) = 1
		_HighlightColor("Highlight Color", Color) = (0,0,0,1)
		_WindNoiseTexture("Wind Noise Texture", 2D) = "white" {}
		_WindScroll("Wind Scroll", Range( 0 , 1)) = 0.1
		_WindJitter("Wind Jitter", Range( 0 , 1)) = 0.1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature _HIGHLIGHTS_ON
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows dithercrossfade vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _WindNoiseTexture;
		uniform float _WindScroll;
		uniform float _WindJitter;
		uniform float4 _Color2;
		uniform sampler2D _TextureSample;
		uniform float4 _TextureSample_ST;
		uniform float4 _Color1;
		uniform float _Color1Level;
		uniform float4 _HighlightColor;
		uniform float _Cutoff = 0.5;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float2 appendResult60 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 temp_output_61_0 = ( appendResult60 * 0.1 );
			float2 panner63 = ( ( (0.0 + (_WindScroll - 0.0) * (0.3 - 0.0) / (1.0 - 0.0)) * _Time.y ) * float2( 1,1 ) + temp_output_61_0);
			float2 panner74 = ( ( _Time.y * (0.0 + (_WindJitter - 0.0) * (0.5 - 0.0) / (1.0 - 0.0)) ) * float2( 1,1 ) + ( temp_output_61_0 * float2( 2,2 ) ));
			float4 WindScroll68 = ( ( pow( tex2Dlod( _WindNoiseTexture, float4( panner63, 0, 0.0) ) , 2.5 ) * tex2Dlod( _WindNoiseTexture, float4( panner74, 0, 0.0) ) ) * v.color );
			float4 temp_output_134_0 = WindScroll68;
			v.vertex.xyz += temp_output_134_0.rgb;
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TextureSample = i.uv_texcoord * _TextureSample_ST.xy + _TextureSample_ST.zw;
			float4 tex2DNode127 = tex2D( _TextureSample, uv_TextureSample );
			float4 lerpResult119 = lerp( ( _Color2 * tex2DNode127 ) , ( tex2DNode127 * _Color1 ) , saturate( ( i.uv_texcoord.y + (-1.0 + (_Color1Level - 0.0) * (1.0 - -1.0) / (1.0 - 0.0)) ) ));
			float3 ase_worldPos = i.worldPos;
			float2 appendResult60 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 temp_output_61_0 = ( appendResult60 * 0.1 );
			float2 panner63 = ( ( (0.0 + (_WindScroll - 0.0) * (0.3 - 0.0) / (1.0 - 0.0)) * _Time.y ) * float2( 1,1 ) + temp_output_61_0);
			float2 panner74 = ( ( _Time.y * (0.0 + (_WindJitter - 0.0) * (0.5 - 0.0) / (1.0 - 0.0)) ) * float2( 1,1 ) + ( temp_output_61_0 * float2( 2,2 ) ));
			float4 WindScroll68 = ( ( pow( tex2D( _WindNoiseTexture, panner63 ) , 2.5 ) * tex2D( _WindNoiseTexture, panner74 ) ) * i.vertexColor );
			#ifdef _HIGHLIGHTS_ON
				float4 staticSwitch148 = ( lerpResult119 + ( WindScroll68 * _HighlightColor ) );
			#else
				float4 staticSwitch148 = lerpResult119;
			#endif
			o.Albedo = staticSwitch148.rgb;
			o.Alpha = 1;
			clip( tex2DNode127.a - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
}
/*ASEBEGIN
Version=18910
372;10;1221;1000;24.1236;1267.672;1.91317;True;False
Node;AmplifyShaderEditor.WorldPosInputsNode;59;-986.3873,-1095.243;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;64;-1161.37,-825.0721;Inherit;False;Property;_WindScroll;Wind Scroll;8;0;Create;True;0;0;0;False;0;False;0.1;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;77;-1145.484,-480.3462;Inherit;False;Property;_WindJitter;Wind Jitter;9;0;Create;True;0;0;0;False;0;False;0.1;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;60;-707.387,-1111.242;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;80;-820.8512,-837.0983;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;0.3;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;62;-719.3701,-939.0721;Inherit;False;Constant;_NoiseSize;Noise Size;3;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;66;-731.3701,-654.072;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;65;-518.3701,-783.072;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;61;-524.3701,-1101.072;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;79;-820.6073,-487.6216;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;-519.2531,-575.8951;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;63;-280.3696,-1093.072;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;73;-278.613,-814.8079;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;2,2;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;67;23.23467,-1118.616;Inherit;True;Property;_WindNoiseTexture;Wind Noise Texture;7;0;Create;True;0;0;0;False;0;False;-1;None;41d01fe6e8db970449385e7f43d4aa06;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;74;-105.5129,-814.1079;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;75;102.4871,-815.1079;Inherit;True;Property;_TextureSample0;Texture Sample 0;7;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;67;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;72;420.66,-1060.765;Inherit;False;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;2.5;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;78;632.5909,-915.3308;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;130;-334.3833,257.0578;Inherit;False;Property;_Color1Level;Color 1 Level;4;0;Create;True;0;0;0;False;0;False;0.35;0.35;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;83;531.6942,-739.6173;Inherit;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;84;886.6118,-859.1572;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;132;-38.45207,261.2453;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;128;-73.40897,123.4554;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;112;-55.41583,-90.67146;Inherit;False;Property;_Color1;Color 1;2;0;Create;True;0;0;0;False;0;False;0,0,0,1;0.1946422,0.509434,0.3875169,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;127;-144.6953,-297.3263;Inherit;True;Property;_TextureSample;Texture Sample;1;0;Create;True;0;0;0;False;0;False;-1;None;cc7e7bd6e8649344dbadd965a58f1123;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;129;212.1222,204.1867;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;110;-57.90097,-474.9566;Inherit;False;Property;_Color2;Color 2;3;0;Create;True;0;0;0;False;0;False;1,1,1,0;0.2082592,0.3709351,0.3773585,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;68;1118.331,-864.3554;Inherit;False;WindScroll;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;131;341.5467,205.0753;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;134;429.4825,-82.39482;Inherit;False;68;WindScroll;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;116;319.8973,-392.9248;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;139;426.2008,3.271336;Inherit;False;Property;_HighlightColor;Highlight Color;6;0;Create;True;0;0;0;False;0;False;0,0,0,1;0.8679245,0.6056536,0.3643645,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;117;315.7307,-206.4161;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;119;668.6838,-307.5066;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;144;706.0293,14.13594;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;145;918.3446,-220.0813;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;148;1101.063,-322.8511;Inherit;False;Property;_Highlights;Highlights;5;0;Create;True;0;0;0;False;0;False;0;1;1;True;;Toggle;2;Key0;Key1;Create;False;True;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1423.71,-316.0227;Float;False;True;-1;2;;0;0;Standard;Toon/TFF_CustomGrass;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;15.82;0,0,0,0;VertexOffset;False;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;60;0;59;1
WireConnection;60;1;59;3
WireConnection;80;0;64;0
WireConnection;65;0;80;0
WireConnection;65;1;66;0
WireConnection;61;0;60;0
WireConnection;61;1;62;0
WireConnection;79;0;77;0
WireConnection;76;0;66;0
WireConnection;76;1;79;0
WireConnection;63;0;61;0
WireConnection;63;1;65;0
WireConnection;73;0;61;0
WireConnection;67;1;63;0
WireConnection;74;0;73;0
WireConnection;74;1;76;0
WireConnection;75;1;74;0
WireConnection;72;0;67;0
WireConnection;78;0;72;0
WireConnection;78;1;75;0
WireConnection;84;0;78;0
WireConnection;84;1;83;0
WireConnection;132;0;130;0
WireConnection;129;0;128;2
WireConnection;129;1;132;0
WireConnection;68;0;84;0
WireConnection;131;0;129;0
WireConnection;116;0;110;0
WireConnection;116;1;127;0
WireConnection;117;0;127;0
WireConnection;117;1;112;0
WireConnection;119;0;116;0
WireConnection;119;1;117;0
WireConnection;119;2;131;0
WireConnection;144;0;134;0
WireConnection;144;1;139;0
WireConnection;145;0;119;0
WireConnection;145;1;144;0
WireConnection;148;1;119;0
WireConnection;148;0;145;0
WireConnection;0;0;148;0
WireConnection;0;10;127;4
WireConnection;0;11;134;0
ASEEND*/
//CHKSM=92C24475FA06949920E37613DDEADB75CA810C88