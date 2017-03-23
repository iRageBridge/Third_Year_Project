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

var highScore:SharedObject;
highScore = SharedObject.getLocal("highScore");

var balloonAchievement: int;

var currentScore:int;
var scoreTimer:Timer = new Timer(100);
scoreTimer.start();
var lives: int = 3;
var score: int;


stage.addEventListener(Event.ENTER_FRAME, gameLivesHandler);
function gameLivesHandler(event:Event):void{
	//trace(saveDataObject.data.savedScore);
	if(highScore.data.savedScore != undefined){
		victoryScreen.highScore.text="High Score: " +highScore.data.savedScore;
		victoryScreen.highScoreShadow.text="High Score: " +highScore.data.savedScore;
		//clouds.startScreen.highScoreText.text = ''+saveDataObject.data.savedScore;
	}
	else{
		highScore.data.savedScore = 1;
	}
	livesText.text = 'Lives: ' + lives;
	livesTextShadow.text = 'Lives: ' + lives;
	if(balloonAchievement == 5){
		gotoAndStop(6);
	}
	if(lives <= 0){
		if(score > highScore.data.savedScore){
			highScore.data.savedScore = score;
			highScore.flush();
		}
	}
}
scoreTimer.addEventListener(TimerEvent.TIMER,gameScoreHandler);
function gameScoreHandler(event:TimerEvent):void{
	score++;
}

clouds.gotoAndStop(6);

