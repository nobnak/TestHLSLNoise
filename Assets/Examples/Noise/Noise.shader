Shader "Unlit/Noise" {
	Properties {
        _Phase ("Phase", Float) = 0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		Cull Off

		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
            #include "Assets/Packages/hlsl-noise/noise2D.cginc"

            float _Phase;

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
                return 0.5 * (snoise(i.uv + _Phase) + 1.0);
			}
			ENDCG
		}
	}
}
