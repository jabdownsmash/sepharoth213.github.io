var Background = {
  fps: 20,
  width: 1280,
  height: 480
};

Background._onEachFrame = (function() {
  var requestAnimationFrame = window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame;

  if (requestAnimationFrame) {
   return function(cb) {
      var _cb = function() { cb(); requestAnimationFrame(_cb); }
      _cb();
    };
  } else {
    return function(cb) {
      setInterval(cb, 1000 / Background.fps);
    }
  }
})();

Background.start = function() {
  //console.log(location.hash); <-- lol
  // Background.canvas = document.createElement("canvas");
  // Background.canvas.width = Background.width;
  // Background.canvas.height = Background.height;
  // var ctx = document.getCSSCanvasContext("2d", "mybackground", 2000, 2000);

  // // ctx.rotate(Math.random() * 2 * Mathz.PI);
  // ctx.fillStyle = "rgb(200,0,0)";
  // ctx.fillRect (10, 10, 55, 50);

  // ctx.fillStyle = "rgba(0, 0, 200, 0.5)";
  // ctx.fillRect (30, 30, 55, 50);
  // Background.context = Background.canvas.getContext("2d");
  // Background.context.fillStyle = 'yellow';
  // document.body.appendChild(Background.canvas);

  // Background.context.fillStyle = '#ffeeee'
  // Background.context.fillRect(0, 0, Background.width, Background.height);
  // Background.context.fillStyle = 'rgb(255,255,0)';
  // Background.context.fillRect(600, 60, 40, 90);

// document.body.style.background = "url(" + Background.canvas + ")";

  // Background._onEachFrame(Background.run);
  setInterval(Background.run, 1000 / Background.fps);
};

Background.run = function() {
  var ctx = document.getCSSCanvasContext("2d", "mybackground", 2000, 2000);
  // ctx.rotate( * 2 * Math.PI);
  ctx.fillStyle = '#ffeeee'
  ctx.fillRect(0, 0, Background.width, Background.height);

  ctx.fillStyle = "#ee2200";
  ctx.fillRect (Math.random()*100, 10, 55, 50);

  ctx.fillStyle = "rgba(0, 0, 200, 0.5)";
  ctx.fillRect (30, 30, 55, 50);
  var boxWidth = 30;
  for(var i = 0; i < 2000; i += boxWidth)
  {
    for(var j = 0; j < 2000; j += boxWidth)
    {
      ctx.fillStyle = '#'+Math.floor(Math.random()*16777215).toString(16);
      ctx.fillRect (i, j, boxWidth, boxWidth);
    }
  }
  // var loops = 0,
  //     skipTicks = 1000 / Background.fps,
  //     maxFrameSkip = 10,
  //     nextBackgroundTick = (new Date).getTime(),
  //     lastBackgroundTick;
  // return function() {
  //   loops = 0;

  //   while ((new Date).getTime() > nextBackgroundTick) {
  //     Background.update();
  //     nextBackgroundTick += skipTicks;
  //     loops++;
  //   }
  //   if (loops) Background.draw();
  // }
};

// Background.draw = function() {
// };

// Background.update = function() {

// };
