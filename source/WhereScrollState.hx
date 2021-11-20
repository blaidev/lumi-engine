package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class WhereScrollState extends MusicBeatState {

    // prolly gonn be scrapped lmfoa

    var strumLine:FlxSprite;
    var isSaving = false;
    
    public function new() {
        super();
    }

    var makeSure:Int = 0;
    var resetMakeSureTimer:Float = 0;

    public override function create() {
        super.create();

        if (FlxG.save.data.strumLineY != null)
            strumLine = new FlxSprite(0, FlxG.save.data.strumLineY).makeGraphic(0, 10);
        else strumLine = new FlxSprite(0, 50).makeGraphic(0, 10);
    }

    var dummyBg:FlxSprite;

    public override function update(elapsed:Float) {
        super.update(elapsed);

        if (strumLine.isOnScreen() && !isSaving)
            strumLine.y = FlxG.mouse.getPosition().y;

        save();

        if (controls.BACK) {
            switchTo(new MainMenuState());
        }

        resetMakeSureTimer += elapsed;

        if (controls.ACCEPT) {
            makeSure++;
            resetMakeSureTimer = 0;
        }

        if (controls.ACCEPT && resetMakeSureTimer < 3 && makeSure > 1) {
            save();
        }

        if (resetMakeSureTimer > 3) {
            makeSure = 0;
        }
    }

    public function save() {
        if (isSaving)
            FlxG.save.data.strumLineY = strumLine.y;
    }
}