var planeText: TiltPlaneText = new TiltPlaneText();
var plane: Plane = new Plane();
var myChar: Char = new Char();
var planeGameOver: Boolean = false;
var planeGameWon : Boolean = false;
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
var countdown : Timer = new Timer(4000, 1);
var gameLost : Timer = new Timer(3000);
var accelerometer: Accelerometer = new Accelerometer();

stage.addChild(plane);
stage.addChild(myChar);
stage.addChild(planeText);
stage.addEventListener(Event.ENTER_FRAME, spin);
stage.addEventListener(Event.ENTER_FRAME, slide);
stage.addEventListener(KeyboardEvent.KEY_DOWN, test);
countdown.addEventListener(TimerEvent.TIMER_COMPLETE, youWin);
accelerometer.addEventListener(AccelerometerEvent.UPDATE, accUpdateHandler);

myChar.x = 567;
myChar.y = 286;
plane.x = 600;
plane.y = 486;
planeText.x = 627;
planeText.y = 150;

countdown.start();
gameLost.start();

function youWin (event:TimerEvent):void{
	if(stage.contains(plane)){
		stage.removeChild(plane);
	}
	if(stage.contains(myChar)){
		stage.removeChild(myChar);		
	}
	if(stage.contains(planeText)){
		stage.removeChild(planeText);
	}
	planeGameWon = true;
		
	if(planeGameWon == true && planeGameOver == false){
		MovieClip(root).victoryScreen.x = 2203.8;
		MovieClip(root).victoryScreen.y = 388.55;
		var gameWon : Timer = new Timer(2000);
		gameWon.addEventListener(TimerEvent.TIMER_COMPLETE, nextGame);
		gameWon.start();
		function nextGame(won:TimerEvent): void{
			gotoAndStop(2);
			MovieClip(root).victoryScreen.x = 3640;
		}
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
		planeOver();
		stage.removeEventListener(Event.ENTER_FRAME, slide);
	}
}

function planeOver():void{
	MovieClip(root).victoryScreen.x = 2203.8;
	MovieClip(root).victoryScreen.y = 388.5;
	if(stage.contains(plane)){
		stage.removeChild(plane);
	}
	if(stage.contains(myChar)){
		stage.removeChild(myChar);		
	}
	if(stage.contains(planeText)){
		stage.removeChild(planeText);
	}
	var planeLossTimer: Timer = new Timer(2000);
	planeLossTimer.addEventListener(TimerEvent.TIMER,planeLossHandler);
	planeLossTimer.start();
	function planeLossHandler(event:TimerEvent): void{
		MovieClip(root).victoryScreen.x = 3600;
		gotoAndStop(2);
		planeLossTimer.stop()
	}
	countdown.stop();
	gameLost.stop();
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
	//if(event.accelerationX >=0.5){
		myChar.x += event.accelerationX * 20;
		//trace("AccX="+ event.accelerationX);
	//}
	myChar.x -= event.accelerationZ * 20;
}