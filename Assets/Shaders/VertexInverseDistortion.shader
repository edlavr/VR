// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/Distortion3" {
	Properties
	{
		_Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
		_c1("c1", float) = -0.33
		_c2("c2", float) = 0.1
	}
	SubShader
	{
		pass
		{
			Tags {"RenderType"="Opaque"}
			LOD 200
			
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			float _c1;
			float _c2;

			sampler2D _MainTex;
			fixed4 _MainTex_ST;

			struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

			float2 dist(float2 uv)
			{
                uv = uv * 2 - 1;
                float theta = atan(abs(uv.y)/abs(uv.x));
                float radius = sqrt(pow(uv.x, 2) + pow(uv.y, 2));
                radius = radius + _c1 * pow(radius, 3) + _c2 * pow(radius, 5);
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

			v2f vert(appdata_full v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
				o.uv = dist(o.uv);
				return o;
			}
			
			
			fixed4 frag(v2f i) :COLOR
			{
				return tex2D(_MainTex, i.uv);
			}
			
			ENDCG
		}

	}
	
}