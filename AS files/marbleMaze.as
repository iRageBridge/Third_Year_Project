var accSensor:Accelerometer = new Accelerometer();
var myBall: Ball = new Ball();
var prevX:int;
var prevY:int;
var i:int;
var accelX:Number;
var accelY:Number;
var sides:Array = new Array();
var maze: Maze = new Maze();
maze.x = stage.stageWidth/2;
maze.y = stage.stageHeight/2;
stage.addChild(maze);
for(var k: int = 0; k < 9; k++){
	sides.push(maze.getChildAt(k));
}
accSensor.setRequestedUpdateInterval(50);
myBall.x = -150;
myBall.y = -348;
addChild(myBall);

accSensor.addEventListener(AccelerometerEvent.UPDATE, accUpdate);
function accUpdate(e:AccelerometerEvent){
	myBall.x -= (e.accelerationX *50);
	myBall.y += (e.accelerationY *50);
	
	if(myBall.x < -615){
		myBall.x = -615;
	}
	if(myBall.x > 661){
		myBall.x = 661;
	}
	if(myBall.y < -370){
		myBall.y = -370;
	}
	if(myBall.y > 408){
		mazeVictory();
	}
	
	for (var i: int =1; i< numChildren; i++) {
		for(var j: int = 0; j < sides.length; j++){
			if (myBall.hitTestObject(sides[j])){
				myBall.x=prevX;
				myBall.y=prevY;
			}
		}
		prevX=myBall.x;
		prevY=myBall.y;
	}
}

/*var mP:Sprite=new Sprite();
addChild(mP);
for (i=1; i<=9; i++) {
	mP.addChild(this["m"+i]);
}*/

function mazeVictory():void{
	MovieClip(root).victoryScreen.x = 2203.8;
	MovieClip(root).victoryScreen.y = 388.55;
	if(contains(myBall)){
		removeChild(myBall);
	}
	for(var i: int = 0; i < sides.length; i++){
		sides[i].alpha = 0;
	}

	var mazeTimer: Timer = new Timer(2000);
	mazeTimer.addEventListener(TimerEvent.TIMER,mazeHandler);
	mazeTimer.start();
	function mazeHandler(event:TimerEvent):void{
		MovieClip(root).victoryScreen.x = 3600;
		gotoAndStop(1);
		mazeTimer.stop();
	}
}