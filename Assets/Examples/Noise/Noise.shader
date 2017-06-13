Shader "Unlit/Noise" {
	Properties {
        _Phase ("Phase", Float) = 0
        _Scale ("Scale", Float) = 10
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

                #if defined(CELLULAR)
                v = 0.5 * (cellular(_Scale * i.uv + _Phase) + 1.0);
                #elif defined(CLASSIC)
                v = 0.5 * (cnoise(_Scale * i.uv + _Phase) + 1.0);
                #elif defined(PSRD)
                v = 0.5 * (srnoise(_Scale * i.uv, _Phase) + 1.0);
                #else
                v = 0.5 * (snoise(_Scale * i.uv + _Phase) + 1.0);
                #endif

                return v;
			}
			ENDCG
		}
	}
}
