trace("Start plane");
MovieClip(root).scoreTimer.start();
var planeText: TiltPlaneText = new TiltPlaneText();
var planeCounter: int = 10;
var plane: Plane = new Plane();
var myChar: Char = new Char();
var tilt : Boolean = new Boolean;
var contactR : Boolean = false;
var contactL : Boolean = false;
var planeRotation: Number = 0.4;
var leftBump : Point = new Point(-11,20);
var rightBump : Point = new Point(11,20);
var leftBump1 : Point = new Point(-24,14);
var rightBump1 : Point = new Point(24,14);
var gravity :Number = 7;
var friction : Number = 8;
var randomGame1: int = Math.random()*5;
var countdown : Timer = new Timer(1000);
var accelerometer: Accelerometer = new Accelerometer();
if(randomGame1 == 0 || randomGame1 == 1){
	randomGame1+=4;
}
if(MovieClip(root).lives > 0){
	stage.addChild(plane);
	stage.addChild(myChar);
	stage.addChild(planeText);
}
stage.addEventListener(Event.ENTER_FRAME, spin);
stage.addEventListener(Event.ENTER_FRAME, slide);
stage.addEventListener(KeyboardEvent.KEY_DOWN, test);
countdown.addEventListener(TimerEvent.TIMER, timeUpVictory);
accelerometer.addEventListener(AccelerometerEvent.UPDATE, accUpdateHandler);

myChar.x = 567;
myChar.y = 286;
plane.x = 600;
plane.y = 486;
planeText.x = 627;
planeText.y = 150;

countdown.start();

function timeUpVictory(event:TimerEvent):void{
	planeCounter--;
	if(planeCounter == 0){
		MovieClip(root).scoreTimer.stop();
		MovieClip(root).victoryScreen.scoreText.text = 'Score: ' + MovieClip(root).score;
		MovieClip(root).victoryScreen.scoreTextShadow.text = 'Score: ' + MovieClip(root).score;
		MovieClip(root).victoryScreen.x = 1985.2;
		MovieClip(root).victoryScreen.y = 349;
		if(stage.contains(plane) && stage.contains(myChar) && stage.contains(planeText)){
			stage.removeChild(plane);
			stage.removeChild(myChar);
			stage.removeChild(planeText);
			gravity = 0;
		}
		var gameWon : Timer = new Timer(2000);
		gameWon.addEventListener(TimerEvent.TIMER, nextGame);
		gameWon.start();
		function nextGame(won:TimerEvent): void{
			trace("victory plane");
			MovieClip(root).victoryScreen.x = 3640;
			if(MovieClip(root).lives > 0){
				gotoAndStop(randomGame1);
			}
			gameWon.stop();
		}
		countdown.stop();
	}
}

function spin (e:Event):void{
	plane.propeller.rotation+=30;
	if(tilt == true){
		plane.rotation += planeRotation;
	}
	if(tilt == false){
		plane.rotation -= planeRotation;
	}	
	if(plane.rotation >=30){
		tilt = false;
	}
	if(plane.rotation <=-30 ){
		tilt = true;
	}
}
	
function slide (ev:Event):void{
	if(contactL==false && contactR == false){
		myChar.y += gravity;
	}
	if(plane.tWing.hitTestPoint(myChar.x + leftBump.x , myChar.y + leftBump.y,true)){
		contactL = true;
	}
	else{
		contactL = false;
	}
	if(plane.tWing.hitTestPoint(myChar.x + rightBump.x , myChar.y + rightBump.y,true)){
		contactR = true;
	}
	else{
		contactR = false;
	}
	if(plane.tWing.hitTestPoint(myChar.x + rightBump1.x , myChar.y + rightBump1.y,true)){
		contactR = true;
	}
	if(plane.tWing.hitTestPoint(myChar.x + leftBump1.x , myChar.y + leftBump1.y,true)){
		contactL = true;
	}
	if(plane.tWing.hitTestPoint(myChar.x + rightBump1.x + 3 , myChar.y + rightBump1.y+ 3,true)){
		contactR = true;
	}
	if(plane.tWing.hitTestPoint(myChar.x + leftBump1.x + 3, myChar.y + leftBump1.y+3,true)){
		contactL = true;
	}
	if(plane.tWing.hitTestPoint(myChar.x + rightBump1.x -3, myChar.y + rightBump1.y-3,true)){
		contactR = true;
	}
	if(plane.tWing.hitTestPoint(myChar.x + leftBump1.x-3 , myChar.y + leftBump1.y-3,true)){
		contactL = true;
	}
	if(contactR){
		myChar.y -= planeRotation;
		myChar.y -= gravity;
	}
	if(contactL){
		myChar.y -= planeRotation;
		myChar.y -= gravity;
	}
	myChar.rotation = plane.rotation;
	
	if(contactL < contactR){
		myChar.x -=friction;
		myChar.myWheel.rotation -= 15;
	}
	if(contactL > contactR){
		myChar.x +=friction;
		myChar.myWheel.rotation += 15;
	}
	if(myChar.y > stage.stageHeight *0.8){
		MovieClip(root).lives --;
		trace("Game over plane fall");
		if(MovieClip(root).lives == 0){
			MovieClip(root).scoreTimer.stop();
			MovieClip(root).gameOver.gameOverText.text = 'Score: ' + MovieClip(root).score;
			MovieClip(root).gameOver.gameOverTextShadow.text = 'Score: ' + MovieClip(root).score;
			MovieClip(root).gameOver.x = 640;
			MovieClip(root).gameOver.y = 360;
			planeOver();
			MovieClip(root).victoryScreen.x = 3700;
		}
		planeOver();
		countdown.stop();
		stage.removeEventListener(Event.ENTER_FRAME, slide);
	}
}

function planeOver():void{
	MovieClip(root).scoreTimer.stop();
	MovieClip(root).victoryScreen.scoreText.text = 'Score: ' + MovieClip(root).score;
	MovieClip(root).victoryScreen.scoreTextShadow.text = 'Score: ' + MovieClip(root).score;
	MovieClip(root).victoryScreen.x = 1985.2;
	MovieClip(root).victoryScreen.y = 349;
	if(stage.contains(plane) && stage.contains(myChar) && stage.contains(planeText)){
		stage.removeChild(plane);
		stage.removeChild(myChar);
		stage.removeChild(planeText);
		gravity = 0;
	}
	var planeLossTimer: Timer = new Timer(2000);
	planeLossTimer.addEventListener(TimerEvent.TIMER,planeLossHandler);
	planeLossTimer.start();
	function planeLossHandler(event:TimerEvent): void{
		MovieClip(root).victoryScreen.x = 3600;
		if(MovieClip(root).lives > 0){
			gotoAndStop(randomGame1);
		}
		planeLossTimer.stop()
	}
	countdown.stop();
}

function test (event:KeyboardEvent):void{
	if(event.keyCode == 37){
		myChar.x -= friction -2;
	}
			
	if(event.keyCode == 39){
		myChar.x += friction +2;
	}
}	

function accUpdateHandler(event:AccelerometerEvent):void{
	myChar.x -= event.accelerationX * 20;
	myChar.x += event.accelerationZ * 20;
}