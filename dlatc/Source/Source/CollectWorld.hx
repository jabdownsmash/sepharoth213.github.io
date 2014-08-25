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

class CollectWorld extends World {

    public var lineBackground:Sprite;

    public var columnStart:Float = 50;
    public var columnWidth:Float;
    public var maxColumns:Int;

    public var collectables:Array<SongObject>;
    public var obstacles:Array<SongObject>;

    public var collectableSprite:Tilesheet;
    public var obstacleSprite:Tilesheet;

    public var overworldTeleporter:SongObject;
    public var overworldTeleporterSprite:Tilesheet;

    public var collected:Int;

    public function new(main:Main)
    {
        bpm = 112;
        maxColumns = 5;
        song = Assets.getSound('assets/lvl1-base.ogg');
        song2 = Assets.getSound('assets/lvl1-add.ogg');
        loopBeats = 128;

        super(main);
        drawBackground(maxColumns,4);

        overworldTeleporterSprite = createSprite(0xDDDDDD,30,loopBeats*(1/bpm*60*1000)*objectBaseSpeed/4);
        overworldTeleporter = spawnObject(30,overworldTeleporterSprite,113,instance.screenWidth/2+100);

        collectableSprite = createSprite(0x11DD22,12,loopBeats*(1/bpm*60*1000)*objectBaseSpeed/4);
        obstacleSprite = createSprite(0xDD2211,20,loopBeats*(1/bpm*60*1000)*objectBaseSpeed/4);

        collectables = new Array<SongObject>();
        collectables.push(spawnObject(12,collectableSprite,10,150));
        collectables.push(spawnObject(12,collectableSprite,20,320));
        collectables.push(spawnObject(12,collectableSprite,20,460));
        collectables.push(spawnObject(12,collectableSprite,26,220));
        collectables.push(spawnObject(12,collectableSprite,26,150));
        collectables.push(spawnObject(12,collectableSprite,34,240));
        collectables.push(spawnObject(12,collectableSprite,38,350));
        collectables.push(spawnObject(12,collectableSprite,40,120));
        collectables.push(spawnObject(12,collectableSprite,40,110));
        collectables.push(spawnObject(12,collectableSprite,46,320));
        collectables.push(spawnObject(12,collectableSprite,50,350));
        collectables.push(spawnObject(12,collectableSprite,56,360));
        collectables.push(spawnObject(12,collectableSprite,62,210));
        collectables.push(spawnObject(12,collectableSprite,66,220));
        collectables.push(spawnObject(12,collectableSprite,76,250));
        collectables.push(spawnObject(12,collectableSprite,82,230));
        collectables.push(spawnObject(12,collectableSprite,90,350));
        collectables.push(spawnObject(12,collectableSprite,90,360));
        collectables.push(spawnObject(12,collectableSprite,96,210));
        collectables.push(spawnObject(12,collectableSprite,96,220));
        collectables.push(spawnObject(12,collectableSprite,96,250));
        collectables.push(spawnObject(12,collectableSprite,100,260));
        collectables.push(spawnObject(12,collectableSprite,104,360));
        collectables.push(spawnObject(12,collectableSprite,106,210));
        collectables.push(spawnObject(12,collectableSprite,106,160));
        collectables.push(spawnObject(12,collectableSprite,109,250));
        collectables.push(spawnObject(12,collectableSprite,109,360));
        resetCollectables();

        obstacles = new Array<SongObject>();
        obstacles.push(spawnObject(20,obstacleSprite,11,40));
        obstacles.push(spawnObject(20,obstacleSprite,14,280));
        obstacles.push(spawnObject(20,obstacleSprite,18,140));
        obstacles.push(spawnObject(20,obstacleSprite,20,40));
        obstacles.push(spawnObject(20,obstacleSprite,23,20));
        obstacles.push(spawnObject(20,obstacleSprite,23,140));
        obstacles.push(spawnObject(20,obstacleSprite,23,300));
        obstacles.push(spawnObject(20,obstacleSprite,49,110));
        obstacles.push(spawnObject(20,obstacleSprite,70,90));
        obstacles.push(spawnObject(20,obstacleSprite,15,120));
        obstacles.push(spawnObject(20,obstacleSprite,15,380));
        obstacles.push(spawnObject(20,obstacleSprite,15,200));

        start();
    }

    public function resetCollectables()
    {
        for(collectable in collectables)
        {
            collectable.visible = true;
            collected = 0;
        }
    }

    public function drawBackground(numColumns:Int,lineWidth:Float)
    {
        columnWidth = instance.screenWidth/maxColumns;
        lineBackground = new Sprite();
        lineBackground.graphics.beginFill(0x050507);
        for(i in -numColumns...numColumns * 2)
        {
            lineBackground.graphics.drawRect(columnStart + i*columnWidth - lineWidth/2,0,lineWidth,instance.screenHeight);
        }
        lineBackground.graphics.endFill();
        // instance.addChildAt(lineBackground, instance.getChildIndex(player));
    }

    public override function update(deltaTime:Float)
    {   
        super.update(deltaTime);
        lineBackground.x = songObjectXOffset*1.5;
        while(lineBackground.x > instance.screenWidth)
        {
            lineBackground.x -= columnWidth;
        }
        while(lineBackground.x < 0)
        {
            lineBackground.x += columnWidth;
        }
        collectableContainer.rotation += 3;
        for(collectable in collectables)
        {
            if(check(collectable) && collectable.visible)
            {
                collected += 1;
                collectable.visible = false;
            }
        }
        for(obstacle in obstacles)
        {
            if(check(obstacle))
            {
                resetCollectables();
            }
        }
        if(collected/collectables.length > .9)
        {
            if(!playing)
            {
                soundChannel2 = song2.play (soundChannel.position,-1);
                playing = true;
            }
        }
        else
        {
            if(soundChannel2 != null)
            {
                soundChannel2.stop();
            }
            playing = false;
        }
        if(check(overworldTeleporter) && collected/collectables.length > .9 )
        {
            soundChannel.stop();
            soundChannel2.stop();
            instance.collectWorld = true;
            instance.loadOverworld();
        }
        // soundChannel2.soundTransform.volume = 0;
        trace(collected/collectables.length);
        playerCollectable.scaleX = playerCollectable.scaleY = collected/collectables.length;
    }
}