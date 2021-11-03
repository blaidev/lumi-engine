package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class StaticArrow extends FlxSprite{
    
    public var tex:String;
    private var directions = ['LEFT', 'DOWN', 'UP', 'RIGHT'];

    public function new(?tex:String) {
        super();
        this.y = PlayState.strumLine.y;
        handleGraphics();        
    }

    public function manage(i:Int) {
        switch (PlayState.curStage) {
            case 'school' | 'schoolEvil':
                animatePixels(i);
            default:
                animateDefaults(i);
        }
    }

    function animateDefaults(i:Int) {
        animation.addByPrefix('green', 'arrowUP');
        animation.addByPrefix('blue', 'arrowDOWN');
        animation.addByPrefix('purple', 'arrowLEFT');
        animation.addByPrefix('red', 'arrowRIGHT');

        antialiasing = true;
        setGraphicSize(Std.int(width * 0.7));

        

        var d:String = directions[i];

        x += Note.swagWidth * i;
        animation.addByPrefix('static', 'arrow$d');
        animation.addByPrefix('pressed', '${d.toLowerCase()} press', 24, false);
        animation.addByPrefix('confirm', '${d.toLowerCase()} confirm', 24, false);
    }

    function animatePixels(i:Int) {
        animation.add('green', [6]);
        animation.add('red', [7]);
        animation.add('blue', [5]);
        animation.add('purplel', [4]);

        setGraphicSize(Std.int(width * PlayState.daPixelZoom));
        updateHitbox();
        antialiasing = false;

        x += Note.swagWidth * i;
        animation.add('static', [0+i]);
        animation.add('pressed', [4+i, 8+i], 12, false);
        animation.add('confirm', [12+i, 16+i], 12, false);
    }

    private function handleGraphics() {
        switch (PlayState.curStage) {
            case 'school' | 'schoolEvil':
                loadGraphic(Paths.image('weeb/pixelUI/arrows-pixels'), true, 17, 17);
            default:
                frames = Paths.getSparrowAtlas('NOTE_assets');    
        }        
    }
}