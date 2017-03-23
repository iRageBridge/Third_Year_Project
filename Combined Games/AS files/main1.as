import flash.utils.Timer;
import flash.media.Microphone;
import flash.events.Event;
import flash.geom.Point;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.events.AccelerometerEvent;
import flash.sensors.Accelerometer;
import flash.geom.Point;
import flash.events.TimerEvent;
import flash.events.TouchEvent;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.geom.ColorTransform;
import fl.motion.easing.Back;
import flash.net.SharedObject;

Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
var saveDataObject:SharedObject;
var currentScore:int;

var scoreTimer:Timer = new Timer(100);
var lives: int = 3;
var score: int;
scoreTimer.start();

stage.addEventListener(Event.ENTER_FRAME, gameScoreHandler);
function gameScoreHandler(event:Event):void{
	livesText.text = 'Lives: ' + lives;
	livesTextShadow.text = 'Lives: ' + lives;
}
init();
function init(){
	scoreTimer.addEventListener(TimerEvent.TIMER, scoreTimerHandler);
	stage.addEventListener(Event.ENTER_FRAME, saveData);
	saveDataObject = SharedObject.getLocal("test");
	if(saveDataObject.data.savedScore == null){
		trace("No saved data yet.");
		saveDataObject.data.savedScore = score;
	} 
	else {
		trace("Save data found.");
		loadData();
	}
}

function saveData(e:Event):void{
	if(lives <= 0){
		saveDataObject.data.savedScore = score;
		trace("Data Saved!");
		trace(saveDataObject.data.savedScore);
		saveDataObject.flush();
	}
}
	
function loadData():void{
	score = saveDataObject.data.score;
	trace("Data Loaded!");
	trace(score);
}

function scoreTimerHandler(event:TimerEvent):void{
	score++;
}

clouds.gotoAndStop(1);
