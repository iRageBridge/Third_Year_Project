import flash.events.TouchEvent;
import flash.utils.Timer;
import flash.events.Event;

stage.addEventListener(TouchEvent.TOUCH_TAP, begin);
stage.addEventListener(Event.ENTER_FRAME, intro);
//var fly : Timer = new Timer(5000);
var random : int = Math.random()*3;
//var random : int = 3;
var startG : Boolean = false;
var flyB : Boolean = false;



trace("ran"+random);



//fly.addEventListener(TimerEvent.TIMER,startFly);

function intro(ev:Event):void{
	//trace(startG);
	
	if( startG == true && random ==0){
		//trace(startG);
		if(stage.contains(loopda)){
		stage.removeChild(loopda);
		gotoAndStop(2);
		}
	}
	
	if(startG == true && random == 1){
	for(var m: int = 0; m < scoops1.length; m++){
		if(stage.contains(scoops1[m])){
			//trace(startG);
			scoops1[m].alpha = 0;
			gotoAndStop(2);
		}
	}
}
	/*
	if(startG == true && random == 2){
	for(var i: int = 0; i < balloons1.length; i++){
		if(stage.contains(balloons1[i])){
			//trace(startG);
			stage.removeChild(balloons1[i]);
			gotoAndStop(2);
		}
}
}*/

	if(startG == true && random == 2){
		if(stage.contains(hotAir1)){
			stage.removeChild(hotAir1);
			gotoAndStop(2);
		}
	}
	
	
	
}

function begin(e:TouchEvent):void{
	
	
		if(e.target == startScreen.startGame){
		trace("hit");
		startScreen.x += 2000;
		startG = true;
		//gotoAndStop(2);
		stage.removeEventListener(TouchEvent.TOUCH_TAP, begin);
	}
		else if(e.target == startScreen.achievements){
		achievementScreen.x=12.95;
		achievementScreen.y=-29.85;
	}
	else if(e.target == achievementScreen.achievementBack){
		achievementScreen.x +=2000;
	}
		
	}
	




	trace("ran"+random);
	
var loopda : loop = new loop();
if(random ==0){
	
	stage.addChild(loopda);
	loopda.x = 0;
	loopda.y = 430;
	
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
/*
var balloons1: Array = new Array;
if(random == 2){
	
	var spawnBalloon1 : Timer = new Timer(5,30);
	spawnBalloon1.start();
	spawnBalloon1.addEventListener(TimerEvent.TIMER,addBalloon1);
	function addBalloon1 (event:TimerEvent): void{
		var balloon1: Balloon = new Balloon;
	var direction:Boolean = Math.random()>.5 ? true:false;
	//var colorArray:Array = new Array(0xFF4400, 0x00FF44, 0x4400FF, 0xFFFF00, 0xFFC0CB);
	//var randomColorID:Number = Math.floor(Math.random()*colorArray.length);
	//var myColor:ColorTransform = this.transform.colorTransform;
	
	
	stage.addChildAt(balloon1,1);
		
    balloon1.y = Math.random()* stage.stageHeight;
	balloon1.x = Math.random()* stage.stageWidth-balloon1.width;
	balloon1.addEventListener(Event.ENTER_FRAME, balloonMovement1);
	//myColor.color=colorArray[randomColorID];
	balloons1.push(balloon1);
	//balloon1.transform.colorTransform = myColor;
	
	if(direction == true){
		balloon1.scaleX *=-1;
	}
	
	if(balloon1.x < balloon1.width){
		balloon1.x = balloon1.width;
	}
	
	//if(randomColorID == randomColor){
	//	counter++;
	//}
	
	function balloonMovement1 (event:Event) : void{
		balloon1.y-=3;
		if(balloon1.y <= 0){
			balloon1.y = stage.stageHeight+balloon1.height;
		}
}

}

}*/

if(random == 2){
	stage.addEventListener(Event.ENTER_FRAME, up);
	var hotAir1: HotAirB = new HotAirB();
	hotAir1.x = 640;
	hotAir1.y = 800;
	stage.addChild(hotAir1);
	//trace("X"+hotAir1.x+"Y" + hotAir1.y)
	flyB = true;
	
	function up (event:Event):void{
		hotAir1.y -= 15;
	}
	
}