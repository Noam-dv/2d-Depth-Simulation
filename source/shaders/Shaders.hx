package shaders;

import flixel.system.FlxAssets.FlxShader;
import shaders.FlxRuntimeShader;

class Shaders
{
	public static function downscale():FlxRuntimeShader
	{
		return new FlxRuntimeShader("
        #pragma header

		vec2 uv = openfl_TextureCoordv.xy;
		vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
		vec2 iResolution = openfl_TextureSize;
		uniform float iTime;
		#define iChannel0 bitmap
		#define texture flixel_texture2D
		#define fragColor gl_FragColor
		#define mainImage main

        uniform float rx;
        uniform float ry;

        vec4 rgbToYUV(vec4 rgba) {
            return rgba * mat4(
                0.299, 0.587, 0.114, 0.0,
                -0.169, -0.331, 0.5, 0.5,
                0.5, -0.419, -0.091, 0.5,
                0.0, 0.0, 0.0, 1.0
            );
        }

        vec4 yuvToRGB(vec4 yuva) {
            return yuva * mat4(
                1.014, 0.0239, 1.4017, -0.7128,
                0.9929, -0.3564, -0.7142, 0.5353,
                1.0, 1.7722, 0.001, -0.8866,
                0.0, 1.7722, 0.0, 1.0
            );
        }

        void mainImage() {
            vec2 uv = fragCoord / iResolution.xy;

            vec4 final = vec4(0.0);
            float steps = 0.0;

            float w = iResolution.x;
            float h = iResolution.y;
            float randomFactor = rx + fract(sin(dot(fragCoord.xy, vec2(12.9898, 78.233) + iTime)) * 43758.5453) * (ry - rx);
            float block = max(1.0, 64.0 * randomFactor);
            vec2 st = vec2(w / block, h / block);

            final = rgbToYUV(texture(iChannel0, vec2(floor(uv.x * st.x) / st.x, floor(uv.y * st.y) / st.y)));

            vec4 yuv = rgbToYUV(texture(iChannel0, uv));

            fragColor = yuvToRGB(final);
        }
        ");

	}
}
