package funk;

import lime.utils.Assets;
import flixel.math.FlxMath;
import flixel.FlxG;
import Math;
import hscript.Interp;
import hscript.Parser;
import hscript.Expr;
import hscript.Checker;

class Funk {

    private var parser:Parser;
    private var interp:Interp;
    private var checker:Checker;

    private var code:String;
    private var codeToRun:Expr;
    


    public function new(source:String) {
        code = source;

        parser = new Parser();
        interp = new Interp();
        checker = new Checker();

        parser.allowJSON = true;
        parser.allowTypes = true;
        parser.allowMetadata = true;

        checker.allowAsync = true;
        checker.allowGlobalsDefine = true;
        checker.allowUntypedMeta = true;

        shareVars();
    }

    public function setRawSource(string:String) {
        this.code = string;
        codeToRun = parser.parseString(code);
    } 

    public function runCode() {
        interp.execute(parser.parseString(code));
    };

    public function shareVars() {
        interp.variables.set("curSong", PlayState.SONG.song);
        interp.variables.set("bf", PlayState.boyfriend);
        interp.variables.set("dad", PlayState.dad);
        interp.variables.set("gf", PlayState.gf);
        interp.variables.set("notes", PlayState.notes);
        interp.variables.set("unspawnNotes", PlayState.unspawnNotes);
        interp.variables.set("strumLine", PlayState.strumLine);
        interp.variables.set("strumLineNotes", PlayState.strumLineNotes);
        interp.variables.set("playerStrums", PlayState.playerStrums);
        interp.variables.set("camFollow", PlayState.camFollow);
        interp.variables.set("curBeat", PlayState.currentBeat);
        interp.variables.set("curStep", PlayState.currentStep);
        interp.variables.set("FlxG", FlxG);
        interp.variables.set("FlxMath", FlxMath);
        interp.variables.set("Character", Character);
        interp.variables.set("Boyfriend", Boyfriend);
        interp.variables.set("Note", Note);
        interp.variables.set("Paths", Paths);
        interp.variables.set("Assets", Assets);
        interp.variables.set("combo", PlayState.combo);
        interp.variables.set("Math", Math);
    }
}