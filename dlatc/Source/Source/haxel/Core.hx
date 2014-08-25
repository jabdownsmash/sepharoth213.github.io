
package haxel;

import flash.display.Sprite;
import flash.display.BitmapData;
import flash.display.Bitmap;

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//
//                                                                          //
//   Because of the nature of this project, please PLEASE test any change   //
//   on HTML5, Flash, AND native. Any changes made for compatibility or     //
//   optimization ABSOLUTELY NEED to be fully documented: reasons, effects  //
//   and changes made. -Aaron                                               //
//                                                                          //
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//


class Core extends Sprite
{
    public static var instance:Core;
    // public static var viewport:Sprite;
    // public static var viewportBitmapData:BitmapData;
    public static var screenBitmapData:BitmapData;
    public static var screenScale:Float = 4;

    public function new()
    {
        stage.scaleMode = openfl.display.StageScaleMode.NO_SCALE;
        stage.quality = openfl.display.StageQuality.LOW;
        super();
        instance = this;
        // Screen.init();
        KeyboardInput.init();
        MouseInput.init();
        // TouchInput.init();
        Time.init();
        // screenScale = Std.int(Math.min(stage.stageWidth,stage.stageHeight)/200);
        // viewport = new Sprite();
        // viewport.scaleX = screenScale;
        // viewport.scaleY = screenScale;
        // viewportBitmapData = new BitmapData(200,200);
        // screenBitmapData = new BitmapData(stage.stageWidth,stage.stageHeight);
        // addChild(new Bitmap(screenBitmapData));
        // addChild(viewport);


}

    public function clearChildren()
    {
        while (numChildren > 0)
        {
            removeChildAt(0);
        }
    }

    public static function updateFrame()
    {
        KeyboardInput.update();
        MouseInput.update();
        // TouchInput.update();
    }

    public static function updatePostFrame()
    {
        // viewportBitmapData.draw(viewport);
        // screenBitmapData.draw(viewportBitmapData,haxel.Utils.generateTransformMatrix(0,0,0,0,screenScale,screenScale));
    }
}
