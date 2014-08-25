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

class Overworld extends World {

    public var lineBackground:Sprite;

    public var columnStart:Float = 50;
    public var columnWidth:Float;
    public var maxColumns:Int;

    public var collectWorldTeleporter:SongObject;
    public var avoidWorldTeleporter:SongObject;
    public var mazeWorldTeleporter:SongObject;

    public var collectWorldTeleporterSprite:Tilesheet;
    public var avoidWorldTeleporterSprite:Tilesheet;
    public var mazeWorldTeleporterSprite:Tilesheet;

    public var collectWorldSong:Sound;
    public var avoidWorldSong:Sound;
    public var mazeWorldSong:Sound;

    public var soundChannel3:SoundChannel;
    public var soundChannel4:SoundChannel;
    public var soundChannel5:SoundChannel;

    public function new(main:Main)
    {
        bpm = 56;
        maxColumns = 5;
        song = Assets.getSound('assets/overworld-base.ogg');
        song2 = Assets.getSound('assets/placeholder.ogg');

        collectWorldSong = Assets.getSound('assets/lvl1-add.ogg');
        avoidWorldSong = Assets.getSound('assets/lvl2-add.ogg');
        mazeWorldSong = Assets.getSound('assets/lvl3-add.ogg');

        loopBeats = 64;

        super(main);

        collectWorldTeleporterSprite = createSprite(0x11DD22,30,loopBeats*(1/bpm*60*1000)*objectBaseSpeed/4);
        avoidWorldTeleporterSprite = createSprite(0x11DD22,30,loopBeats*(1/bpm*60*1000)*objectBaseSpeed/4);
        mazeWorldTeleporterSprite = createSprite(0x11DD22,30,loopBeats*(1/bpm*60*1000)*objectBaseSpeed/4);

        if(!instance.collectWorld)
        {
            collectWorldTeleporter = spawnObject(30,collectWorldTeleporterSprite,10,instance.screenWidth/2+100);
        }
        else
        {
            collectWorldTeleporter = spawnObject(30,collectWorldTeleporterSprite,40,instance.screenWidth/2+50);
        }
        if(!instance.avoidWorld)
        {
            avoidWorldTeleporter = spawnObject(30,avoidWorldTeleporterSprite,20,instance.screenWidth/2+100);
        }
        else
        {
            avoidWorldTeleporter = spawnObject(30,avoidWorldTeleporterSprite,40,instance.screenWidth/2-50);
        }
        if(!instance.mazeWorld)
        {
            mazeWorldTeleporter = spawnObject(30,mazeWorldTeleporterSprite,30,instance.screenWidth/2+100);
        }
        else
        {
            mazeWorldTeleporter = spawnObject(30,mazeWorldTeleporterSprite,42,instance.screenWidth/2);
        }
        instance.addChildAt(collectWorldTeleporter,instance.getChildIndex(player));
        instance.addChildAt(avoidWorldTeleporter,instance.getChildIndex(player));
        instance.addChildAt(mazeWorldTeleporter,instance.getChildIndex(player));

        start();

        playerCollectable.visible = false;
    }

    public override function start()
    {
        super.start();
        if(instance.collectWorld)
        {
            soundChannel3 = collectWorldSong.play();
        }
        if(instance.avoidWorld)
        {
            soundChannel4 = avoidWorldSong.play();
        }
        if(instance.mazeWorld)
        {
            soundChannel5 = mazeWorldSong.play();
        }
    }

    public override function update(deltaTime:Float)
    {   
        super.update(deltaTime);
        if(check(collectWorldTeleporter) && !instance.collectWorld)
        {
            soundChannel.stop();
            if(soundChannel2 != null)
            {
                soundChannel2.stop();
            }
            if(soundChannel3 != null)
            {
                soundChannel3.stop();
            }
            if(soundChannel4 != null)
            {
                soundChannel4.stop();
            }
            if(soundChannel5 != null)
            {
                soundChannel5.stop();
            }
            instance.loadCollectWorld();
        }
        if(check(avoidWorldTeleporter) && !instance.avoidWorld)
        {
            soundChannel.stop();
            if(soundChannel2 != null)
            {
                soundChannel2.stop();
            }
            if(soundChannel3 != null)
            {
                soundChannel3.stop();
            }
            if(soundChannel4 != null)
            {
                soundChannel4.stop();
            }
            if(soundChannel5 != null)
            {
                soundChannel5.stop();
            }
            instance.loadAvoidWorld();
        }
        if(check(mazeWorldTeleporter) && !instance.mazeWorld)
        {
            soundChannel.stop();
            if(soundChannel2 != null)
            {
                soundChannel2.stop();
            }
            if(soundChannel3 != null)
            {
                soundChannel3.stop();
            }
            if(soundChannel4 != null)
            {
                soundChannel4.stop();
            }
            if(soundChannel5 != null)
            {
                soundChannel5.stop();
            }
            instance.loadMazeWorld();
        }
    }
}