import flash.events.Event;
import flash.geom.Point;
import flash.events.MouseEvent;
import flash.utils.Timer;
import flash.events.TimerEvent;
import flash.events.TouchEvent;
import flash.text.TextField;
import flash.text.TextFormat;

Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;

var randomColor: int = Math.random()*5;
var startText: String;
var countDown: int = 10;

if(randomColor == 0){
	startText = "red";
}

else if(randomColor == 1){
	startText = "green";
}

else if(randomColor == 2){
	startText = "blue";
}

else if(randomColor == 3){
	startText = "yellow";
}

else{
	startText = "pink";
}

var counter: int = 0;
var selectedObject: DisplayObject;
var spawnBalloon : Timer = new Timer(5,30)
var gameCounter : Timer = new Timer(1000);
gameCounter.start();
spawnBalloon.start();
var balloons: Array = new Array;
spawnBalloon.addEventListener(TimerEvent.TIMER,addBalloon);
gameCounter.addEventListener(TimerEvent.TIMER,gameCounterHandler);

function gameCounterHandler(event:TimerEvent):void{
	countDown--;
	if(countDown == 0){
		trace("game over");
	}
}

function addBalloon (event:TimerEvent): void{
	var direction:Boolean = Math.random()>.5 ? true:false;
	var colorArray:Array = new Array(0xFF4400, 0x00FF44, 0x4400FF, 0xFFFF00, 0xFFC0CB);
	var randomColorID:Number = Math.floor(Math.random()*colorArray.length);
	var myColor:ColorTransform = this.transform.colorTransform;
	var textField: TextField = new TextField();
	var textField2: TextField = new TextField();
	var balloon: Balloon = new Balloon;
	
	textField.x=250;
	textField2.x=253;
	textField.y=100;
	textField2.y=103;
	textField.defaultTextFormat = new TextFormat('OCR A Std',50);
	textField2.defaultTextFormat = new TextFormat('OCR A Std',50);
	textField.textColor = colorArray[randomColor];
	textField2.textColor = 0x000000;
	
	textField.width=stage.stageWidth;
	textField.text= "Pop the "+startText+" balloons";
	textField2.width=stage.stageWidth;
	textField2.text= "Pop the "+startText+" balloons";
	
	stage.addChild(balloon);
	stage.addChild(textField2);
	stage.addChild(textField);
	
	if(direction == true){
		balloon.scaleX *=-1;
	}
	balloon.y = Math.random()* stage.stageHeight;
	balloon.x = Math.random()* stage.stageWidth-balloon.width;
	if(balloon.x < balloon.width){
		balloon.x = balloon.width;
	}
	myColor.color=colorArray[randomColorID];
	if(randomColorID == randomColor){
		counter++;
	}
	
	balloon.transform.colorTransform = myColor;
	
	balloons.push(balloon);
	balloon.addEventListener(Event.ENTER_FRAME, balloonMovement);

	function balloonMovement (event:Event) : void{
		balloon.y-=3;
		if(balloon.y <= 0){
			balloon.y = stage.stageHeight;
		}
	}
	balloon.addEventListener(TouchEvent.TOUCH_BEGIN, balloonHandler);
	function balloonHandler(event:TouchEvent):void{
		if(myColor.color==colorArray[randomColor]){
			balloon.gotoAndPlay(1);
			counter--;
			if(counter ==0){
				trace("Victory!!");
			}
		}
		else if(myColor.color!=colorArray[randomColor]){
			trace("LOSER!!");
		}
	}
}



