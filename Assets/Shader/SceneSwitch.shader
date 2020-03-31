Shader "Hidden/Shader/SceneSwitch"
{
	HLSLINCLUDE

#pragma target 4.5

#pragma only_renderers d3d11 ps4 xboxone vulkan metal switch

#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"

#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"

#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"

#include "Packages/com.unity.render-pipelines.high-definition/Runtime/PostProcessing/Shaders/FXAA.hlsl"

#include "Packages/com.unity.render-pipelines.high-definition/Runtime/PostProcessing/Shaders/RTUpscale.hlsl"

	struct Attributes
	{
		uint vertexID : SV_VertexID;

		UNITY_VERTEX_INPUT_INSTANCE_ID
	};

	struct Varyings
	{
		float4 positionCS : SV_POSITION;

		float2 texcoord   : TEXCOORD0;

		UNITY_VERTEX_OUTPUT_STEREO
	};

	Varyings Vert(Attributes input)
	{
		Varyings output;

		UNITY_SETUP_INSTANCE_ID(input);

		UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

		output.positionCS = GetFullScreenTriangleVertexPosition(input.vertexID);

		output.texcoord = GetFullScreenTriangleTexCoord(input.vertexID);

		return output;
	}

	// List of properties to control your post process effect

	TEXTURE2D_X(_Albedo);

	float4 _Viewport;
    float _Width;
    float _Height;
	float _Scale;

    void Unity_Add_float4(float4 A, float4 B, out float4 Out)
    {
        Out = A + B;
    }

    void Unity_Multiply_float(float A, float B, out float Out)
    {
        Out = A * B;
    }

    void Unity_Add_float(float A, float B, out float Out)
    {
        Out = A + B;
    }

    void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
    {
        RGBA = float4(R, G, B, A);
        RGB = float3(R, G, B);
        RG = float2(R, G);
    }

    void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
    {
        Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
    }

    void Unity_Ellipse_float(float2 UV, float Width, float Height, out float Out)
    {
        float d = length((UV * 2 - 1) / float2(Width, Height));
        Out = saturate((1 - d) / fwidth(d));
    }

    void Unity_Multiply_float(float4 A, float4 B, out float4 Out)
    {
        Out = A * B;
    }

	float4 CustomPostProcess(Varyings input) : SV_Target
	{
		UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input);

		uint2 positionSS = input.texcoord * _ScreenSize.xy;

		float3 outColor = LOAD_TEXTURE2D_X(_Albedo, positionSS).xyz;

        float4 _SampleTexture2D_B0F041DD_RGBA_0 = float4(outColor, 1);
        float _SampleTexture2D_B0F041DD_R_4 = _SampleTexture2D_B0F041DD_RGBA_0.r;
        float _SampleTexture2D_B0F041DD_G_5 = _SampleTexture2D_B0F041DD_RGBA_0.g;
        float _SampleTexture2D_B0F041DD_B_6 = _SampleTexture2D_B0F041DD_RGBA_0.b;
        float2 _UV_84A083E5_Out_0 = input.texcoord;
        float _Split_D3A264AF_R_1 = _UV_84A083E5_Out_0[0];
        float _Split_D3A264AF_G_2 = _UV_84A083E5_Out_0[1];
        // float _Split_D3A264AF_B_3 = _UV_84A083E5_Out_0[2];
        // float _Split_D3A264AF_A_4 = _UV_84A083E5_Out_0[3];

        float4 _Property_7D88C27E_Out_0 = _Viewport;
        float4 _Add_4491BBC4_Out_2;
        Unity_Add_float4(_Property_7D88C27E_Out_0, float4(-0.5, -0.5, 0, 0), _Add_4491BBC4_Out_2);
        float _Split_4EEEE0A1_R_1 = _Add_4491BBC4_Out_2[0];
        float _Split_4EEEE0A1_G_2 = _Add_4491BBC4_Out_2[1];
        float _Split_4EEEE0A1_B_3 = _Add_4491BBC4_Out_2[2];
        float _Split_4EEEE0A1_A_4 = _Add_4491BBC4_Out_2[3];
        float _Multiply_D7292EF5_Out_2;
        Unity_Multiply_float(_Split_4EEEE0A1_R_1, -1, _Multiply_D7292EF5_Out_2);
        float _Add_7B6EC14B_Out_2;
        Unity_Add_float(_Split_D3A264AF_R_1, _Multiply_D7292EF5_Out_2, _Add_7B6EC14B_Out_2);
        float _Multiply_DDD63812_Out_2;
        Unity_Multiply_float(_Split_4EEEE0A1_G_2, -1, _Multiply_DDD63812_Out_2);
        float _Add_B2210D0B_Out_2;
        Unity_Add_float(_Split_D3A264AF_G_2, _Multiply_DDD63812_Out_2, _Add_B2210D0B_Out_2);
        float4 _Combine_AEABF859_RGBA_4;
        float3 _Combine_AEABF859_RGB_5;
        float2 _Combine_AEABF859_RG_6;
        Unity_Combine_float(_Add_7B6EC14B_Out_2, _Add_B2210D0B_Out_2, 0, 0, _Combine_AEABF859_RGBA_4, _Combine_AEABF859_RGB_5, _Combine_AEABF859_RG_6);
        float _Property_F0041F8A_Out_0 = _Width;
        float _Property_87F89F91_Out_0 = _Scale;
        float _Remap_ABF0C865_Out_3;
        Unity_Remap_float(_Property_87F89F91_Out_0, float2 (0, 1), float2 (0, 6), _Remap_ABF0C865_Out_3);
        float _Multiply_9A180FBA_Out_2;
        Unity_Multiply_float(_Property_F0041F8A_Out_0, _Remap_ABF0C865_Out_3, _Multiply_9A180FBA_Out_2);
        float _Property_2197B8FB_Out_0 = _Height;
        float _Multiply_C13B4254_Out_2;
        Unity_Multiply_float(_Property_2197B8FB_Out_0, _Remap_ABF0C865_Out_3, _Multiply_C13B4254_Out_2);
        float _Ellipse_58FCBC21_Out_4;
        Unity_Ellipse_float((_Combine_AEABF859_RGBA_4.xy), _Multiply_9A180FBA_Out_2, _Multiply_C13B4254_Out_2, _Ellipse_58FCBC21_Out_4);
        float4 _Multiply_C9F7BA28_Out_2;
        Unity_Multiply_float(_SampleTexture2D_B0F041DD_RGBA_0, (_Ellipse_58FCBC21_Out_4.xxxx), _Multiply_C9F7BA28_Out_2);

        return _Multiply_C9F7BA28_Out_2;
	}

		ENDHLSL

		SubShader

	{
		Pass
		{
			Name "SceneSwitch"

			ZWrite Off

			ZTest Always

			Blend Off

			Cull Off

			HLSLPROGRAM

#pragma fragment CustomPostProcess

#pragma vertex Vert

			ENDHLSL
		}
	}

	Fallback Off
}