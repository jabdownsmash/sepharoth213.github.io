function wrapText(ctx, text, x, y, maxWidth, lineHeight)
{
  var words = text.split(' ')
    , line = ''
    , lines = [];

  for(var n = 0, len = words.length; n < len; n++){
    var testLine = line + words[n] + ' '
      , metrics = ctx.measureText(testLine)
      , testWidth = metrics.width;

    if (testWidth > maxWidth) {
      lines.push({ text: line, x: x, y: y });
      line = words[n] + ' ';
      y += lineHeight;
    } else {
      line = testLine;
    }
  }

  lines.push({ source: text, text: line, x: x, y: y });
  return lines;
};

var Game = {
  fps: 60,
  width: 600,
  height: 480,
  data: [
  {response: "beneath the surface", options: ["click here to start"], optionPaths: [1]},
  {response: "what?", options: ["oh, nothing. i was just spacing out."], optionPaths: [2]},
  {response: "uh, alright. anyway, what do you want to do?", options: ["we could just stay here.", "let's go take a walk.", "i'm starving."], optionPaths: [3,4,5]},
  {response: "yeah, sounds good.", options: ["restart"], optionPaths: [0]},
  {response: "alright, let me grab my coat.", options: ["restart"], optionPaths: [0]},
  {response: "me too, but i don't have any money.", options: ["restart"], optionPaths: [0]},
  ]
};

var lineHeight = 20;
var lineSpacing = 30;
var optionWidth = 500;
var optionMargin = 50;
var optionColor = '#ddd';
var optionFont = '16px Arial';
var optionHeight = 16;
var optionBottomMargin = 20;
var textWidth = 300;
var textColor = '#ddd';
var textFont = '20px Arial';
var leftX = 100;
var rightX = 250;
var bottomMargin = 100;
var textLines = [];
var textOptions = [];
var currentIndex = 0;


Game.generateTextOptions = function(optionStrings) 
{
  var ctx = Game.canvas.getContext("2d");
  var options = [];
  for(var i = 0; i < optionStrings.length; i++)
  {
    ctx.font = optionFont;
    var option = { source: optionStrings[i], text: wrapText(ctx, optionStrings[i], i*optionWidth/optionStrings.length, 0, optionWidth/optionStrings.length, optionHeight)}
    options.push(option);
  }
  textOptions = options;
} 

Game.displayLines = function()
{
  var ctx = Game.canvas.getContext("2d");
  ctx.fillStyle = textColor;
  ctx.font = textFont;
  var baseline = Game.height - bottomMargin;
  for(var i = textLines.length - 1; i >= 0 && baseline > 0; i--)
  {
    var textLine = textLines[i];
    var drawX = leftX;
    if(textLine.right == true)
    {
      drawX = rightX;
    }
    var txt = textLine.text;
    var textHeight = txt.length*lineHeight;
    for (var j = 0; j < txt.length; j++){
      var item = txt[j];
      ctx.fillText(item.text, drawX, item.y+baseline-textHeight);
    }
    baseline -= textHeight + lineSpacing;
  }
}

Game.displayTextOptions = function()
{
  var ctx = Game.canvas.getContext("2d");
  ctx.fillStyle = optionColor;
  ctx.font = optionFont;
  var baseline = Game.height - optionBottomMargin;
  for(var i = 0; i < textOptions.length && baseline > 0; i++)
  {
    var textLine = textOptions[i];
    var txt = textLine.text;
    var textHeight = txt.length*lineHeight;
    for (var j = 0; j < txt.length; j++){
      var item = txt[j];
      ctx.fillText(item.text, item.x + optionMargin, item.y+baseline-optionHeight);
    }
  }
}

Game.appendLine = function(text, right)
{
  var ctx = Game.canvas.getContext("2d");
  ctx.fillStyle = textColor;
  ctx.font = textFont;
  var line = {text:wrapText(ctx, text, 0, 0, textWidth, lineHeight), right: right};
  textLines.push(line);
}

Game.start = function()
{
  Game.canvas = document.createElement("canvas");
  Game.canvas.width = Game.width;
  Game.canvas.height = Game.height;
  document.body.appendChild(Game.canvas);
  var ctx = Game.canvas.getContext("2d");
  ctx.fillStyle = textColor;
  ctx.font = textFont;
  Game.appendLine( "beneath the surface", true);
  var canvasPosition = {
      x: Game.canvas.offsetLeft,
      y: Game.canvas.offsetTop
  };
  Game.canvas.addEventListener('click', function(e) {
      var mouse = {
          x: e.pageX - canvasPosition.x,
          y: e.pageY - canvasPosition.y
      }
      Game.checkInput(mouse.x,mouse.y)
  }, false);
  Game.generateTextOptions(Game.data[currentIndex].options);
  setInterval(Game.run, 1000 / Game.fps);
};

Game.run = function()
{
  var ctx = Game.canvas.getContext("2d");

  ctx.fillStyle = '#111'
  ctx.fillRect(0, 0, Game.width, Game.height);
  Game.displayLines();
  Game.displayTextOptions();
};

Game.clearOptions = function()
{

}

Game.selectOption = function(index)
{
  Game.appendLine( textOptions[index].source, false);
  currentIndex = Game.data[currentIndex].optionPaths[index];
  Game.appendLine( Game.data[currentIndex].response, true);
  Game.generateTextOptions(Game.data[currentIndex].options);
}

Game.checkInput = function(x, y)
{
  if((y > Game.height - (optionBottomMargin + optionHeight*2)) && x > optionMargin && x < Game.width - optionMargin)
  {
    var optionIndex = Math.floor((x-optionMargin)/optionWidth*textOptions.length);
    Game.selectOption(optionIndex);
  }
}
