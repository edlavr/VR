// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/Distortion" {
	Properties
	{
		_Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
		_c1("c1", float) = -0.15
		_c2("c2", float) = 0.05
	}
    SubShader
    {
        Pass
        {
            CGPROGRAM
            // use "vert" function as the vertex shader
            #pragma vertex vert
            // use "frag" function as the pixel (fragment) shader
            #pragma fragment frag

            
            float _c1;
            float _c2;

            
            // vertex shader inputs
            struct appdata
            {
                float4 vertex : POSITION; // vertex position
                float2 uv : TEXCOORD0; // texture coordinate
            };

            // vertex shader outputs ("vertex to fragment")
            struct v2f
            {
                float2 uv : TEXCOORD0; // texture coordinate
                float4 vertex : SV_POSITION; // clip space position
            };

            // vertex shader
            v2f vert (appdata v)
            {
                v2f o;
                // transform position to clip space
                // (multiply with model*view*projection matrix)
                o.vertex = UnityObjectToClipPos(v.vertex);
                // just pass the texture coordinate
                o.uv = v.uv;
                return o;
            }
            
            float2 dist(float2 uv)
			{
                uv = uv * 2 - 1;
                float theta = atan(abs(uv.y)/abs(uv.x));
                float radius = sqrt(pow(uv.x, 2) + pow(uv.y, 2));
                float f = (_c1 * pow(radius, 2)) + (_c2 * pow(radius, 4)) + (pow(_c1,2) * pow(radius, 4)) + (pow(_c2,2) * pow(radius, 8)) + (2 * _c1 *_c2 * pow(radius, 6));
                f = radius / (1 + (4 * _c1 * pow(radius, 2)) + (6 * _c2 * pow(radius, 4)));

				radius = f;
                
                if (uv.x >= 0 && uv.y >= 0)
                {
                    uv.x = radius * cos(theta);
                    uv.y = radius * sin(theta);
                }
                else if (uv.x < 0 && uv.y >= 0)
                {
                    uv.x = radius * -cos(theta);
                    uv.y = radius * sin(theta);
                }
                else if (uv.x >= 0 && uv.y < 0)
                {
                    uv.x = radius * cos(theta);
                    uv.y = radius * -sin(theta);
                }
                else if (uv.x < 0 && uv.y < 0)
                {
                    uv.x = radius * -cos(theta);
                    uv.y = radius * -sin(theta);
                }

                return uv / 2 + 0.5;
			}
            
            // texture we will sample
            sampler2D _MainTex;
            
            // pixel shader; returns low precision ("fixed4" type)
            // color ("SV_Target" semantic)
            fixed4 frag (v2f i) : SV_Target
            {
                // sample texture and return it
                fixed4 col = tex2D(_MainTex, dist(i.uv));
                return col;
            }
            ENDCG
        }
    }
}



