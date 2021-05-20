Shader "Custom/Aberration"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        
        _c1R("c1R", float) = -0.15
		_c2R("c2R", float) = 0.05
        
        _c1G("c1G", float) = -0.15
		_c2G("c2G", float) = 0.05
        
        _c1B("c1B", float) = -0.15
		_c2B("c2B", float) = 0.05

    }
    SubShader
    { 
        Pass
        {
            Tags { "RenderType"="Opaque" }
            LOD 200
            
            CGPROGRAM
            #pragma vertex vert_img
            #pragma fragment frag
            #include "UnityCG.cginc"
 
            sampler2D _MainTex;
            float _c1R;
            float _c2R;
            float _c1G;
            float _c2G;
            float _c1B;
            float _c2B;

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            float2 dist(float2 uv, float _c1, float _c2)
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
           
            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = fixed4(1, 1, 1, 1);
 
                float2 uv_r = dist(i.uv, _c1R, _c2R);
                float2 uv_g = dist(i.uv, _c1B, _c2B);
                float2 uv_b = dist(i.uv, _c1G, _c2G);
 
                col.r = tex2D(_MainTex, uv_r).r;
                col.g = tex2D(_MainTex, uv_g).g;
                col.b = tex2D(_MainTex, uv_b).b;
 
                return col;
            }
            ENDCG
        }
    }
}