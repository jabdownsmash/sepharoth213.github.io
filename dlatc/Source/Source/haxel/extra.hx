
// var fileString = Assets.getText('assets/config.cfg');
// var fileObject = haxe.Json.parse(fileString);

// var spritesheet:Spritesheet = BitmapImporter.create( bitmapData, 3, 9, 56, 80);
// spritesheet.addBehavior( new BehaviorData("idle", [3, 4, 5], false, 15) );
// var animated:AnimatedSprite = new AnimatedSprite(spritesheet, true)
// addChild( animated );
// animated.showBehavior("stand");


// animated.update(delta);

// tf = new TextField();
// tf.type = TextFieldType.DYNAMIC;
// ...

// var font:Font = Assets.getFont("fonts/" + fontFileName + ".ttf");
// var textFormat:TexFromat = new TextFormat();
// textFormat.font = font.fontName; // The font name doesn't always match the font file name.
// ... //more textfomat formating 
// ...
// tf.defaultTextFormat = textFormat;




// public class Ball extends MovieClip {

//     private static var spriteSheet:BitmapData; // first, why storing a Bitmap if you don't need it be moving?
//     private static var spriteArray:Vector.<BitmapData>; // This will store split spritesheet

//     private var bitmap:Bitmap; // this will be displaying proper frame
//     private var currentFrame:int; // what frame are you displaying
//     public static function initialize():void {
//         // loading static assets should better be made in a static function
//         if (!spriteSheet) {
//            var loader:Loader = new Loader();
//            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
//            loader.load(new URLRequest("Ball.png"));
//         }
//     }

//     public function Ball() {
//         bitmap=new Bitmap(); // null bitmap is displayed
//         addChild(bitmap);
//         currentFrame=0;
//         addEventListener(Event.ENTER_FRAME, onFrameLoop,null,0,true); // weak listener
//         // to not hog memory if you'd create and remove balls
//     }
//     private function onFrameLoop(e:Event)
//     {
//         switchFrame();
//     }

//     private function switchFrame()
//     {
//         if (!spriteArray) return; // oops, not initialized
//         currentFrame++;
//         if (currentFrame>=spriteArray.length) currentFrame=0;
//         bitmap.bitmapData=spriteArray[currentFrame]; // voila. Now this particular Ball
//         // will display the proper BitmapData out of sliced sprite sheet.
//     }

//     private static function onLoadComplete(e:Event)
//     {
//         var loaderInfo:LoaderInfo = e.target as LoaderInfo;
//         spriteSheet = (loaderInfo.content as Bitmap).bitmapData; // store the bitmapdata
//         // now cut the loaded sprite sheet apart
//         var i:int=Math.floor(spritesheet.width/50); // how many frames are in there
//         var r:Rectangle=new Rectangle(0,0,50,50);
//         var p:Point=new Point(); // why making N identical points? Just make one
//         spriteArray=new Vector.<BitmapData>();
//         for (var j:int=0;j<i;j++) {
//             var bd:BitmapData=new BitmapData(50,50);
//             r.x=50*j; // update rectangle to cut next frame
//             bd.copyPixels(spriteSheet,r,p); // cut the frame in a new BitmapData
//             spriteArray.push(bd); // store the frame
//         }
//         // once this is complete, your sprite sheet is ready
//     }
// }
