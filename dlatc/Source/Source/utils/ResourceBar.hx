
package utils;
import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import openfl.Assets;

class ResourceBar extends Sprite
{

    public var barWidth:Float;
    public var barHeight:Float;

    // public var filledPercent:Float;
    public var background:Sprite;
    public var overlay:Sprite;
    public var bar:Sprite;

    public function new(w:Float, h:Float, color:Int)
    {
        super();
        barWidth = w;
        barHeight = h;
        background = new Sprite();
        background.graphics.beginFill(0x666666);
        background.graphics.drawRect(0,0,barWidth,barHeight);
        background.graphics.endFill();
        addChild(background);
        bar = new Sprite();
        bar.graphics.beginFill(color);
        bar.graphics.drawRect(0,0,barWidth,barHeight);
        bar.graphics.endFill();
        addChild(bar);
        overlay = new Sprite();
        overlay.graphics.lineStyle(0,0x000000);
        overlay.graphics.drawRect(0,0,barWidth,barHeight);
        addChild(overlay);

    }

    public function update(newPercent:Float)
    {
        // filledPercent = newPercent;
        bar.scaleX = newPercent;
    }
}
