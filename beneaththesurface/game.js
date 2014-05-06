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
  height: 480
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

Game.start = function()
{
  Game.canvas = document.createElement("canvas");
  Game.canvas.width = Game.width;
  Game.canvas.height = Game.height;
  document.body.appendChild(Game.canvas);
  var ctx = Game.canvas.getContext("2d");
  ctx.fillStyle = textColor;
  ctx.font = textFont;
  var blah = {text:wrapText(ctx, "look at this game isn't it so cool", 0, 0, textWidth, lineHeight), right: false};
  var blah2 = {text:wrapText(ctx, "yeah check out the white text on the black background", 0, 0, textWidth, lineHeight), right: true};
  var blah3 = {text:wrapText(ctx, "so super artsy fuck", 0, 0, textWidth, lineHeight), right: false};
  textLines.push(blah);
  textLines.push(blah2);
  textLines.push(blah3);
  setInterval(Game.run, 1000 / Game.fps);
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
  Game.generateTextOptions(["arsientarst aienstiat", "ywfubytuaw wyufty wfulbt wyuft ywuft", "wyufbhtyauwhft qywuhft wyfuh uf f"])
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

Game.checkInput = function(x, y)
{
  if(y > optionBottomMargin - optionHeight && x > optionMargin && x < Game.width - optionMargin)
  {
    var ctx = Game.canvas.getContext("2d");
    var optionIndex = Math.floor((x-optionMargin)/optionWidth*textOptions.length);
    var blah = {text:wrapText(ctx, textOptions[optionIndex].source, 0, 0, textWidth, lineHeight), right: false};
    textLines.push(blah);
  }
}
