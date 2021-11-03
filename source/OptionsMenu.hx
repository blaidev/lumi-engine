package;

import flixel.FlxState;
import flixel.addons.ui.FlxButtonPlus;
import flixel.ui.FlxButton;
import Controls.Control;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;

class OptionsMenu extends MusicBeatState {
	private var buttons:FlxTypedGroup<FlxButtonPlus>;
	private static var callbacks:Array<Bool->String> = [];
	private static var buttonNames:Array<String> = ['dfjk', 'down', 'ghost', 'splash'];
	
	var bg:FlxSprite;

	var saveMap:Map<String, Dynamic>;

	public function new() {
		super();
		FlxG.mouse.visible = true;
		FlxG.mouse.enabled = true;
		callbacks = [DFJK, downScroll, ghostTapping, noteSplash];


		buttons = new FlxTypedGroup<FlxButtonPlus>();

		saveMap = [
			"dfjk" => FlxG.save.data.dfjk,
			"downscroll" => FlxG.save.data.downscroll,
			"ghost tapping" => FlxG.save.data.ghost,
			"note splashes" => FlxG.save.data.notesplash
		];

		bg = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		bg.color = FlxColor.GREEN;
		add(bg);
		add(buttons);

		for (i in 0...callbacks.length) {
			if (buttonNames[i] == 'dfjk')
				buttons.add(new FlxButtonPlus(40, (i * 80) + 60, () -> {
				DFJK(true);
				buttons.members[0].text = DFJK(false);
				saveMap.set("dfjk", FlxG.save.data.dfjk);
			}, 'lol', 200, 50));
			if (buttonNames[i] == 'down')
				buttons.add(new FlxButtonPlus(40, (i * 80) + 60, () -> {
				downScroll(true);
				buttons.members[1].text = downScroll(false);
				saveMap.set("notesplash", FlxG.save.data.notesplash);
			}, 'lol', 200, 50));
			if (buttonNames[i] == 'ghost')
				buttons.add(new FlxButtonPlus(40, (i * 80) + 60, () -> {
				ghostTapping(true);
				buttons.members[2].text = ghostTapping(false);
				saveMap.set("ghost tapping", FlxG.save.data.ghost);
			}, 'lol', 200, 50));
			if (buttonNames[i] == 'splash')
				buttons.add(new FlxButtonPlus(40, (i * 80) + 60, () -> {
				noteSplash(true);
				buttons.members[3].text = noteSplash(false);
				saveMap.set("notesplash", FlxG.save.data.notesplash);
			}, 'lol', 200, 50));
		}

		buttons.members[0].text = DFJK(false);
		buttons.members[1].text = downScroll(false);
		buttons.members[2].text = ghostTapping(false);
		buttons.members[3].text = noteSplash(false);

		var bruh = ["dfjk", "downscroll", "ghost tapping", "note splashes"];
	}

	public override function update(elapsed:Float) {
		super.update(elapsed);
		Globals.menuSongTime = FlxG.sound.music.time;

		if (controls.BACK || controls.ACCEPT) {
			trace(saveMap);
			save();
			FlxG.switchState(new MainMenuState());
		}
	}

	function DFJK(?saving:Bool=true) {
		if (saving)
			FlxG.save.data.dfjk = !FlxG.save.data.dfjk;
		save();
		return FlxG.save.data.dfjk ? "DFJK On" : "DFJK Off";
	}

	function downScroll(?saving:Bool=true) {
		if (saving)
			FlxG.save.data.downscroll = !FlxG.save.data.downscroll;
		save();
		return FlxG.save.data.downscroll ? "Downscroll On" : "Downscroll Off";
	}

	function ghostTapping(?saving:Bool=true) {
		if (saving)
			FlxG.save.data.ghost = !FlxG.save.data.ghost;
		save();
		return FlxG.save.data.ghost ? "Ghost Tapping On" : "Ghost Tapping Off";
	}

	function noteSplash(?saving:Bool=true) {
		if (saving)
			FlxG.save.data.notesplash = !FlxG.save.data.notesplash;
		save();
		return FlxG.save.data.notesplash ? "Note Splashes On" : "Note Splashes Off";
	}

	function save() {
		FlxG.save.flush();
	}
}

class OptionButton extends FlxButtonPlus {

	private var callback:Bool->String;

	public function new(x:Float, y:Float, text:String, width:Float, height:Float, callback:Bool->String) {
		super(x, y, text);
		this.width = width;
		this.height = height;
		this.callback = callback;
		updateHitbox();
	}

	function call(?saving:Bool) {
		callback(saving);
	}
}