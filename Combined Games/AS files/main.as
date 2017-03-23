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
var scoreTimer:Timer = new Timer(100);
var lives: int = 3;
var score: int;
trace(score);
scoreTimer.start();
scoreTimer.addEventListener(TimerEvent.TIMER, scoreTimerHandler);
stage.addEventListener(Event.ENTER_FRAME, gameScoreHandler);

function gameScoreHandler(event:Event):void{
	livesText.text = 'Lives: ' + lives;
	livesTextShadow.text = 'Lives: ' + lives;
	//if(lives ==0) {
		//saveData();
	//}
}
function scoreTimerHandler(event:TimerEvent):void{
	score++;
}

clouds.gotoAndStop(1);
