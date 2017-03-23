trace("Start maze");
MovieClip(root).scoreTimer.start();
var accSensor:Accelerometer = new Accelerometer();
var myBall: Ball = new Ball();
var prevX:int;
var prevY:int;
var accelX:Number;
var accelY:Number;
var sides:Array = new Array();
var maze: Maze = new Maze();
var mazeCountdown: int = 30;
var mazeGameTimer: Timer = new Timer(1000);
var randomGame5: int = Math.random()*7;
if(randomGame5 == 0 || randomGame5 == 1){
	trace("Frame 1 trigger");
	randomGame5 = 2;
}
trace(randomGame5);
mazeGameTimer.start();
maze.x = stage.stageWidth/2;
maze.y = stage.stageHeight/2;
sides.push(maze.m1,maze.m2,maze.m3,maze.m4,maze.m5,maze.m6,maze.m7,maze.m8,maze.m9);
accSensor.setRequestedUpdateInterval(50);
myBall.x = 0;
myBall.y = -348;
if(randomGame5 == 6){
	randomGame5++;
}
if(MovieClip(root).lives > 0){
	stage.addChild(maze);
	addChild(myBall);
}

mazeGameTimer.addEventListener(TimerEvent.TIMER,gameTimerHandler);
accSensor.addEventListener(AccelerometerEvent.UPDATE, accUpdate);

function gameTimerHandler(event:TimerEvent):void{
	mazeCountdown--;
	if(mazeCountdown == 0){
		mazeGameTimer.stop();
		MovieClip(root).lives --;
		trace("Game over maze");
		if(MovieClip(root).lives == 0){
			MovieClip(root).gameOver.gameOverText.text = 'Score: ' + MovieClip(root).score;
			MovieClip(root).gameOver.gameOverTextShadow.text = 'Score: ' + MovieClip(root).score;
			MovieClip(root).scoreTimer.stop();
			MovieClip(root).victoryScreen.scoreText.text = 'Score: ' + MovieClip(root).score;
			MovieClip(root).victoryScreen.scoreTextShadow.text = 'Score: ' + MovieClip(root).score;
			MovieClip(root).gameOver.x = 640;
			MovieClip(root).gameOver.y = 360;
			mazeVictory();
			MovieClip(root).victoryScreen.x = 3700;
		}
		else{
			mazeVictory();
			mazeGameTimer.stop();
		}
	}
}
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
		
	for(var j: int = 0; j < sides.length; j++){
		if (myBall.hitTestObject(sides[j])){
			myBall.x=prevX;
			myBall.y=prevY;
		}
	}
	prevX=myBall.x;
	prevY=myBall.y;
}

function mazeVictory():void{
	mazeGameTimer.stop();
	trace("victory maze");
	MovieClip(root).scoreTimer.stop();
	MovieClip(root).victoryScreen.scoreText.text = 'Score: ' + MovieClip(root).score;
	MovieClip(root).victoryScreen.scoreTextShadow.text = 'Score: ' + MovieClip(root).score;
	MovieClip(root).victoryScreen.x = 1985.2;
	MovieClip(root).victoryScreen.y = 349;
	if(contains(myBall)){
		removeChild(myBall);
	}
	if(stage.contains(maze)){
		stage.removeChild(maze);
	}
	var mazeTimer: Timer = new Timer(2000);
	accSensor.removeEventListener(AccelerometerEvent.UPDATE, accUpdate);
	mazeTimer.addEventListener(TimerEvent.TIMER,mazeHandler);
	mazeTimer.start();
	function mazeHandler(event:TimerEvent):void{
		MovieClip(root).victoryScreen.x = 3600;
		if(MovieClip(root).lives > 0){
			gotoAndStop(randomGame5);
		}
		mazeTimer.stop();
	}
}