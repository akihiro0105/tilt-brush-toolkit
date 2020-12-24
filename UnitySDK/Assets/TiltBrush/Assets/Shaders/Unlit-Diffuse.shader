// Copyright 2017 Google Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// Unlit shader. Simplest possible textured shader.
// - no lighting
// - no lightmap support
// - no per-material color

Shader "Unlit/Diffuse" {
	Properties{
	  _Color("Color", Color) = (1,1,1,1)
	}

		SubShader{
		  Tags { "RenderType" = "Opaque" }
		  LOD 100
		  Blend One One, Zero One


		  Pass {
			CGPROGRAM
			  #pragma vertex vert
			  #pragma fragment frag

			  #include "UnityCG.cginc"

			  struct appdata_t {
			UNITY_VERTEX_INPUT_INSTANCE_ID
				float4 vertex : POSITION;
			  };

			  struct v2f {
				  UNITY_VERTEX_INPUT_INSTANCE_ID
					  UNITY_VERTEX_OUTPUT_STEREO
				float4 vertex : SV_POSITION;
			  };

			  uniform float4 _Color;

			  v2f vert(appdata_t v)
			  {
				v2f o;

				UNITY_INITIALIZE_OUTPUT(v2f, o);
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			  }

			  fixed4 frag(v2f i) : SV_Target
			  {
				  UNITY_SETUP_INSTANCE_ID(i);

				_Color.rgb *= _Color.a;
				return _Color;
			  }
			ENDCG
		  }
	}

}
