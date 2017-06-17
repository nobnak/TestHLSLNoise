Shader "Unlit/Noise" {
	Properties {
        _Phase ("Phase", Float) = 0
        _Scale ("Scale", Float) = 10
        _Speed ("Speed", Float) = 1
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		Cull Off

		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
            #pragma multi_compile ___ CELLULAR CLASSIC PSRD
			
			#include "UnityCG.cginc"
            #include "Assets/Packages/hlsl-noise/all.cginc"

            float _Phase;
            float _Scale;
            float _Speed;

			struct appdata {
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f {
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata v) {
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target {
                float v;
                float2 offset = float2(_Phase, _Speed * _Time.y);
                float2 uv = _Scale * float2(i.uv + offset);

                #if defined(CELLULAR)
                v = 0.5 * (cellular(uv) + 1.0);
                #elif defined(CLASSIC)
                v = 0.5 * (cnoise(uv) + 1.0);
                #elif defined(PSRD)
                v = 0.5 * (srnoise(uv, 0.0) + 1.0);
                #else
                v = 0.5 * (snoise(uv) + 1.0);
                #endif

                return v;
			}
			ENDCG
		}
	}
}
