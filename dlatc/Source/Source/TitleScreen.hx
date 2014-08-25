package;

import haxel.Core;
import haxel.KeyboardInput;
import haxel.Key;
import haxel.Time;
import openfl.display.Sprite;
import openfl.Assets;
import openfl.media.SoundChannel;
import haxel.MouseInput;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.media.Sound;
import haxe.Json;
import openfl.events.Event;
import openfl.display.Tilesheet;
import openfl.display.Bitmap;

class TitleScreen extends World {

    public var lineBackground:Sprite;

    public var columnStart:Float = 50;
    public var columnWidth:Float;
    public var maxColumns:Int;

    public var overworldTeleporter:SongObject;
    public var overworldTeleporterSprite:Tilesheet;

    public var collectWorldSong:Sound;
    public var avoidWorldSong:Sound;
    public var mazeWorldSong:Sound;

    public function new(main:Main)
    {
        bpm = 56;
        maxColumns = 5;
        song = Assets.getSound('assets/placeholder.ogg');
        song2 = Assets.getSound('assets/placeholder.ogg');

        loopBeats = 64;

        super(main);

        // overworldTeleporterSprite = createSprite(0xDDDDDD,30,loopBeats*(1/bpm*60*1000)*objectBaseSpeed/4);
        // overworldTeleporter = spawnObject(30,overworldTeleporterSprite,113,instance.screenWidth/2+100);

        start();

        playerCollectable.visible = false;  
        addChild(new Bitmap(Assets.getBitmapData("assets/title.png")));

    }

    public override function update(deltaTime:Float)
    {   
        super.update(deltaTime);

        if(KeyboardInput.check(Key.LEFT) || KeyboardInput.check(Key.RIGHT) || MouseInput.mouseDown)
        {
            soundChannel.stop();
            if(soundChannel2 != null)
            {
                soundChannel2.stop();
            }
            instance.loadOverworld();
        }
    }
}