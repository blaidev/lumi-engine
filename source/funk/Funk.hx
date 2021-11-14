package funk;

import flixel.FlxBasic;
import lime.utils.Assets;
import flixel.math.FlxMath;
import flixel.FlxG;
import Math;
import hscript.Interp;
import hscript.Parser;
import hscript.Expr;
import hscript.Checker;

/**
 * Class that adds support to HScript modding.
 */
class Funk extends FlxBasic {

    private var parser:Parser;
    public var interp:Interp;
    private var checker:Checker;

    private var code:String;
    private var codeToRun:Expr;
    


    /**
     * A "plugin" that allows to run HScript code to mod the game without recompilation. or download of any libraries as
     * @param source Code in a string format to input HScript code in.
     */
    public function new(source:String) {

        super();

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


    /**
     * Input new HScript code through the source code in `PlayState` or anywhere else, rather than text files
     * @param string The new code being inputted 
     */
    public function setRawSource(string:String) {
        this.code = string;
        codeToRun = parser.parseString(code);
    } 

    /**
     * Executes HScript code
     */
    public function runCode() {
        interp.execute(codeToRun);
    };

    /**
     * Allows for variables in `PlayState` to be modified or read through the HScript code without needing the original source code
     */
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
        interp.variables.set("camFollow", PlayState.camFollow);
        interp.variables.set("curStage", PlayState.curStage);
        interp.variables.set("curLevel", PlayState.curLevel);
        interp.variables.set("curDifficulty", PlayState.curDifficulty);
        interp.variables.set("SONG", PlayState.SONG);
        interp.variables.set("isStoryMode", PlayState.isStoryMode);
        interp.variables.set("storyWeek", PlayState.storyWeek);
        interp.variables.set("storyPlaylist", PlayState.storyPlaylist);
        interp.variables.set("storyDifficulty", PlayState.storyDifficulty);
        
        interp.variables.set("StaticArrow", StaticArrow);
        interp.variables.set("Alphabet", Alphabet);
        interp.variables.set("DialogueBox", DialogueBox);
        interp.variables.set("FlxG", FlxG);
        interp.variables.set("FlxMath", FlxMath);
        interp.variables.set("Character", Character);
        interp.variables.set("Boyfriend", Boyfriend);
        interp.variables.set("Note", Note);
        interp.variables.set("Paths", Paths);
        interp.variables.set("Assets", Assets);
        interp.variables.set("Math", Math);
        interp.variables.set("Xml", Xml);
        interp.variables.set("StringTools", StringTools);
        interp.variables.set("CoolUtil", CoolUtil);  
    }

}