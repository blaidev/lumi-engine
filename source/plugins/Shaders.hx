package plugins;

import flixel.FlxBasic;
import flixel.system.FlxAssets.FlxShader;

// creds to shadertoy for the shader
// creds to halfbuzz for helpin with excluding transparency

class NoiseShader extends FlxShader {
    @:glFragmentSource("
    #pragma header
    uniform float iTime;
float Noise21 (vec2 p, float ta, float tb) {
    return fract(sin(p.x*ta+p.y*tb)*5678.);
}
void main()
{
    vec2 uv = openfl_TextureCoordv.xy;
    float t = iTime+123.; // tweak the start moment
    float ta = t*.654321;
    float tb = t*(ta*.123456);
    
    float c = Noise21(uv, ta, tb);
    vec3 col = vec3(c);
    vec4 unmodifiedCol = flixel_texture2D(bitmap, openfl_TextureCoordv);
    if(unmodifiedCol.a == 0.0){
        gl_FragColor = unmodifiedCol;
    } else {
        gl_FragColor = vec4(col,1.);
    }
}
    ")

    public function new() {
        super();
        iTime.value = [0.0];
    }

    public function update(elapsed:Float) {
            iTime.value[0] += elapsed;
    }    
}