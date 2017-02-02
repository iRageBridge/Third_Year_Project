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
spawnBalloon.start();
var balloons: Array = new Array;
spawnBalloon.addEventListener(TimerEvent.TIMER, addBalloon);

function addBalloon (event:TimerEvent): void{
	var direction:Boolean = Math.random()>.5 ? true:false;
	var colorArray:Array = new Array(0xFF4400, 0x00FF44, 0x4400FF, 0xFFFF00, 0xFFC0CB);
	var randomColorID:Number = Math.floor(Math.random()*colorArray.length);
	var myColor:ColorTransform = this.transform.colorTransform;
	var textField: TextField = new TextField();
	textField.width=stage.stageWidth;
	textField.text= "Pop the "+startText+" balloons";
	var balloon: Balloon = new Balloon;
	
	stage.addChild(balloon);
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
		trace(counter);
	}
	
	balloon.transform.colorTransform = myColor;
	textField.textColor = colorArray[randomColor];
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



