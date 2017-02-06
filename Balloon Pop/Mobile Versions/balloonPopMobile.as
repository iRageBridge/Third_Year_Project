import flash.events.Event;
import flash.geom.Point;
import flash.events.MouseEvent;
import flash.utils.Timer;
import flash.events.TimerEvent;
import flash.events.TouchEvent;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.geom.ColorTransform;

Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;

var randomColor: int = Math.random()*5;
var startText: String;
var countDown: int = 20;
var counter: int = 0;
var selectedObject: DisplayObject;
var spawnBalloon : Timer = new Timer(5,30)
var gameCounter : Timer = new Timer(1000);
var balloons: Array = new Array;
var textField: TextField = new TextField();
var textField2: TextField = new TextField();

textField.x=250;
textField2.x=253;
textField.y=50;
textField2.y=53;
textField.defaultTextFormat = new TextFormat('OCR A Std',50);
textField2.defaultTextFormat = new TextFormat('OCR A Std',50);

gameCounter.start();
spawnBalloon.start();

stage.addChildAt(textField2,1);
stage.addChildAt(textField,2);

spawnBalloon.addEventListener(TimerEvent.TIMER,addBalloon);
gameCounter.addEventListener(TimerEvent.TIMER,gameCounterHandler);

switch (randomColor){
	case 0:
	startText = "red";
	break;

	case 1:
	startText = "green";
	break;

	case 2:
	startText = "blue";
	break;

	case 3:
	startText = "yellow";
	break;

	case 4:
	startText = "pink";
	break;
}

function addBalloon (event:TimerEvent): void{
	var direction:Boolean = Math.random()>.5 ? true:false;
	var colorArray:Array = new Array(0xFF4400, 0x00FF44, 0x4400FF, 0xFFFF00, 0xFFC0CB);
	var randomColorID:Number = Math.floor(Math.random()*colorArray.length);
	var myColor:ColorTransform = this.transform.colorTransform;
	var balloon: Balloon = new Balloon;
	
	textField.textColor = colorArray[randomColor];
	textField2.textColor = 0x000000;
	textField.width=stage.stageWidth;
	textField.text= "Pop the "+startText+" balloons";
	textField2.width=stage.stageWidth;
	textField2.text= "Pop the "+startText+" balloons";
	
	setChildIndex(gameOverScreen, 2);
	setChildIndex(victoryScreen,2);
	setChildIndex(clouds, 0);
	stage.addChildAt(balloon,1);
	balloon.y = Math.random()* stage.stageHeight;
	balloon.x = Math.random()* stage.stageWidth-balloon.width;
	balloon.addEventListener(Event.ENTER_FRAME, balloonMovement);
	balloon.addEventListener(TouchEvent.TOUCH_BEGIN, balloonHandler);
	myColor.color=colorArray[randomColorID];
	balloons.push(balloon);
	balloon.transform.colorTransform = myColor;
	
	if(direction == true){
		balloon.scaleX *=-1;
	}
	
	if(balloon.x < balloon.width){
		balloon.x = balloon.width;
	}
	
	if(randomColorID == randomColor){
		counter++;
	}
	
	function balloonMovement (event:Event) : void{
		balloon.y-=3;
		if(balloon.y <= 0){
			balloon.y = stage.stageHeight+balloon.height;
		}
	}
	
	function balloonHandler(event:TouchEvent):void{
		if(myColor.color==colorArray[randomColor]){
			balloon.gotoAndPlay(1);
			counter--;
			if(counter ==0){
				victory();
			}
		}
		else if(myColor.color!=colorArray[randomColor]){
			gameOver();
		}
	}
}

function gameCounterHandler(event:TimerEvent):void{
	countDown--;
	if(countDown == 0){
		gameOver();
	}
	textField3.defaultTextFormat = new TextFormat('OCR A Std',50);
	textField3.textColor = 0xFF0000;
	textField3.text= countDown.toString();
}

function gameOver():void{
	trace("Game Over");
	gameOverScreen.x = stage.stageWidth/2;
	gameOverScreen.y = stage.stageHeight/2;
	for(var i: int = 0; i < balloons.length; i++){
		if(contains(balloons[i])){
			stage.removeChild(balloons[i]);
		}
		textField.alpha=0;
		textField2.alpha=0;
	}
}

function victory():void{
	victoryScreen.x = stage.stageWidth/2;
	victoryScreen.y = 360;
	for(var i: int = 0; i < balloons.length; i++){
		stage.removeChild(balloons[i]);
		textField.alpha=0;
		textField2.alpha=0;
	}
}