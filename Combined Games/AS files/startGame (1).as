import flash.events.TouchEvent;
import flash.utils.Timer;
import flash.events.Event;

stage.addEventListener(TouchEvent.TOUCH_TAP, begin);
stage.addEventListener(Event.ENTER_FRAME, intro);
var random : int = Math.random()*3;
var startG : Boolean = false;

trace("ran"+random);

function intro(ev:Event):void{
	if( startG == true && random ==0){
		trace(startG);
		if(stage.contains(loopda)){
			stage.removeChild(loopda);
			gotoAndStop(1);
		}
	}
	if(startG == true && random == 1){
		for(var m: int = 0; m < scoops1.length; m++){
			if(stage.contains(scoops1[m])){
				trace(startG);
				scoops1[m].alpha = 0;
				gotoAndStop(1);
			}
		}
	}
	if(startG == true && random == 2){
		for(var i: int = 0; i < balloons1.length; i++){
			if(stage.contains(balloons1[i])){
				trace(startG);
				stage.removeChild(balloons1[i]);
				gotoAndStop(1);
			}
		}
	}
}

function begin(e:TouchEvent):void{
	if(e.target == startScreen.startGame){
		if(e.target == startScreen.startGame){
			trace("hit");
			startScreen.x += 2000;
			stage.removeEventListener(TouchEvent.TOUCH_TAP, begin);
		}
		else if(e.target == startScreen.achievements){
			achievementScreen.x=12.95;
			achievementScreen.y=-29.85;
		}
		else if(e.target == achievementScreen.achievementBack){
			achievementScreen.x +=2000;
		}
		startG = true;
	}
}

trace("ran"+random);
	
var loopda : loop = new loop();
if(random ==0){	
	stage.addChild(loopda);
	loopda.x = -100;
	loopda.y = 50;
}

var scoops1: Array = new Array();
if(random == 1){	
	var cream1: Timer = new Timer(1500, 15);
	cream1.start();
	cream1.addEventListener(TimerEvent.TIMER,createScoops1);
	function createScoops1(tim: TimerEvent): void {
		var myScoop1: Scoop = new Scoop();
		var colorArray: Array = new Array(0xc2f2d0, 0xc2f2d0, 0x6b3e26, 0xfdf5c9, 0xffc5d9);
		var randomColorID: Number = Math.floor(Math.random() * colorArray.length);
		var myColor: ColorTransform = transform.colorTransform;

		myColor.color = colorArray[randomColorID];
		scoops1.push(myScoop1);
		myScoop1.x = Math.random() * (stage.stageWidth);
		stage.addChild(myScoop1);
		myScoop1.transform.colorTransform = myColor;		
	}
}

var balloons1: Array = new Array;
if(random == 2){
	var spawnBalloon1 : Timer = new Timer(5,30);
	spawnBalloon1.start();
	spawnBalloon1.addEventListener(TimerEvent.TIMER,addBalloon1);
	function addBalloon1 (event:TimerEvent): void{
		var balloon1: Balloon = new Balloon;
		var direction:Boolean = Math.random()>.5 ? true:false;

		stage.addChildAt(balloon1,1);
		balloon1.y = Math.random()* stage.stageHeight;
		balloon1.x = Math.random()* stage.stageWidth-balloon1.width;
		balloon1.addEventListener(Event.ENTER_FRAME, balloonMovement1);
		balloons1.push(balloon1);
		if(direction == true){
			balloon1.scaleX *=-1;
		}
		
		if(balloon1.x < balloon1.width){
			balloon1.x = balloon1.width;
		}
	
		function balloonMovement1 (event:Event) : void{
			balloon1.y-=3;
			if(balloon1.y <= 0){
				balloon1.y = stage.stageHeight+balloon1.height;
			}
		}
	}
}