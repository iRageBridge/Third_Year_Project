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
import flash.text.engine.TabAlignment;
clouds.stop();
Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;

var highScore:SharedObject;
var ach1: SharedObject;

ach1 = SharedObject.getLocal("ach1");
highScore = SharedObject.getLocal("highScore");

var scoreTimer:Timer = new Timer(100);
scoreTimer.start();
var lives: int = 1;
var score: int;
var balloonAchievement: int;

stage.addEventListener(Event.ENTER_FRAME, gameLivesHandler);
function gameLivesHandler(event:Event):void{
	if(highScore.data.savedScore != undefined){
		victoryScreen.highScore.text="High Score: " +highScore.data.savedScore;
		victoryScreen.highScoreShadow.text="High Score: " +highScore.data.savedScore;
	}
	else{
		highScore.data.savedScore = 1;
	}
	
	/*if(ach1.data.achievementOne != undefined){
		trace(ach1.data.achievementOne);
	}*/
	//else{
		ach1.data.achievementOne =1;
	//}
	balloonAchievement = ach1.data.achievementOne;
	livesText.text = 'Lives: ' + lives;
	livesTextShadow.text = 'Lives: ' + lives;

	if(lives <= 0){
		if(score > highScore.data.savedScore){
			highScore.data.savedScore = score;
			highScore.flush();
		}
		ach1.data.achievementOne = balloonAchievement;
		ach1.flush();
		score = 0;
	}
}
scoreTimer.addEventListener(TimerEvent.TIMER,gameScoreHandler);
function gameScoreHandler(event:TimerEvent):void{
	score++;
}





stage.addEventListener(TouchEvent.TOUCH_TAP, begin);
stage.addEventListener(Event.ENTER_FRAME, intro);
var random : int = Math.random()*2;
var startG : Boolean = false;
var flyB : Boolean = false;
var scoops1: Array = new Array();
setChildIndex(startScreen,1);
startHighScore.text = "High Score: " +highScore.data.savedScore;
startHighScore2.text = "High Score: " +highScore.data.savedScore;
function intro(ev:Event):void{
	if(highScore.data.savedScore >= 1000){
		achievementScreen.lock3.alpha=0;
	}
	if(highScore.data.savedScore >= 10000){
		achievementScreen.lock5.alpha=0;
	}
	if( startG == true && random ==0){
		if(stage.contains(loopda)){
			stage.removeChild(loopda);
			clouds.gotoAndStop(7);
		}
	}

	if(startG == true && random == 1){
		if(stage.contains(hotAir1)){
			stage.removeChild(hotAir1);
			clouds.gotoAndStop(7);
		}
	}
}

function begin(e:TouchEvent):void{
	if(e.target == startScreen.startGame){
		startHighScore2.x+=2000;;
		startHighScore.x +=2000;
		cloudsText.x+=2000;
		cloudsText2.x+=2000;
		startScreen.x += 2000;
		startG = true;
		//stage.removeEventListener(TouchEvent.TOUCH_TAP, begin);
	}
	if(e.target == startScreen.achievements){
		achievementScreen.x=627.95;
		achievementScreen.y=350.75;
	}
	if(e.target == achievementScreen.achievementBack){
		achievementScreen.x +=2000;
	}
	if(e.target == gameOver.playAgain){
		startG = true;
		lives = 3;
		gameOver.x+=2000;
		trace("Play again");
		gotoAndPlay(1);
	}
	if(e.target == gameOver.mainMenu){
		startG = true;
		lives = 3;
		gameOver.x+=2000;
		trace("Main Menu");
		startHighScore2.x-=2000;;
		startHighScore.x -=2000;;
		cloudsText.x-=2000;
		cloudsText2.x-=2000;
		startScreen.x -= 2000;
	}
	if(e.target == homeButton){
		lives = 3;
		startHighScore2.x-=2000;;
		startHighScore.x -=2000;;
		cloudsText.x-=2000;
		cloudsText2.x-=2000;
		startScreen.x -= 2000;
	}
}
	
var loopda : loop = new loop();
if(random ==0){
	stage.addChildAt(loopda,0);
	loopda.x = 600;
	loopda.y = 430;
}

if(random == 1){
	stage.addEventListener(Event.ENTER_FRAME, up);
	var hotAir1: HotAirB = new HotAirB();
	hotAir1.x = 640;
	hotAir1.y = 800;
	stage.addChildAt(hotAir1,0);
	flyB = true;
	function up (event:Event):void{
		hotAir1.y -= 15;
	}
}


