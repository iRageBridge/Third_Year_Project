import flash.events.Event;
import flash.geom.Point;
import flash.events.MouseEvent;
import flash.utils.Timer;
import flash.events.TimerEvent;
import flash.events.AccelerometerEvent;
import flash.sensors.Accelerometer;

var plane: Plane = new Plane();
		var myChar: Char = new Char()
		var planeGameOver: Boolean = false;
		var planeGameWon : Boolean = false;
		myChar.x = 567;
		myChar.y = 186;
		plane.x = 600;
		plane.y = 386;
		addChild(plane);
		addChild(myChar);
	    
		
		
		
		
		var countdown : Timer = new Timer(1000000, 1)
		countdown.addEventListener(TimerEvent.TIMER_COMPLETE, youWin);
		countdown.start();

		var tilt : Boolean = new Boolean;
		var contactR : Boolean = false;
		var contactL : Boolean = false;
		var planeRotation: Number = 0.4;
		//var rotateRight: Number = 20;
		var leftBump : Point = new Point(-17,27);
		var rightBump : Point = new Point(17,27);
		var leftBump1 : Point = new Point(-27,17);
		var rightBump1 : Point = new Point(27,17);
		//var sideR : Point = new Point(29,12);
		//var sideL : Point = new Point(-29,12);
		var gravity :Number = 9.8;
		var friction : Number = 13;


      
		function youWin (event:TimerEvent):void{
			if(contains(plane)){
			removeChild(plane);
			}
			
			if(contains(myChar)){
			removeChild(myChar);		
			}
			//trace("youWin");
			//planeGameOver = true;
			/*
		    if(planeGameOver == true){
				gameOverScreen.x = stage.stageWidth/2;
				removeChild(plane);
				removeChild(myChar);
				planeGameWon = false;
				var gameLost : Timer = new Timer(3000);
			gameLost.addEventListener(TimerEvent.TIMER_COMPLETE, newGame);
			gameLost.start();
			
			function newGame(lost:TimerEvent): void{
				gameOverScreen.x = stage.stageWidth + gameOverScreen;
				randomGameGenorator();
			}
				
			}*/	
			
			//else{
			planeGameWon = true;
			
			if(planeGameWon == true && planeGameOver == false){
				victoryScreen.x = stage.stageWidth/2;
			var gameWon : Timer = new Timer(2000);
			gameWon.addEventListener(TimerEvent.TIMER_COMPLETE, nextGame);
			gameWon.start();
			//trace(gameWon);
			function nextGame(won:TimerEvent): void{
				victoryScreen.x = stage.stageWidth/2 + victoryScreen;
				randomGameGenorator();
			}
			}
		}
		
		//}

		stage.addEventListener(Event.ENTER_FRAME, spin);

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
				//trace("f");
			}

			if(plane.rotation <=-30 ){
				tilt = true;
				//trace("t");
			}
		}
	
		stage.addEventListener(Event.ENTER_FRAME, slide);
		function slide (ev:Event):void{
			//trace(randomGame);
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
				myChar.y -= gravity*0.2;
				//trace("right");
			}
			
			if(contactL){
				myChar.y -= gravity*0.2;
				//trace("left");
			}
			
			if(contactL < contactR){
				myChar.x -=friction;
				//trace("L<R");
			}
		
			if(contactL > contactR){
				myChar.x +=friction;
				//trace("L>R");
			}
			/*
			if(plane.tWing.hitTestPoint(myChar.x + sideL.x , myChar.y + sideL.y,true)){
				contactL = true;
			}
		
			
			if(plane.tWing.hitTestPoint(myChar.x + sideR.x , myChar.y + sideR.y,true)){
				contactR = true;
			}	
			
			
			if(myChar.y + leftBump.y > myChar.y + rightBump.y){
				myChar.x += friction;
			}
			
			trace(">" + myChar.y + leftBump.y);
			trace("<" + myChar.y + rightBump.y);
		
			
			if(myChar.y + leftBump.y < myChar.y + rightBump.y){
				myChar.x -= friction;
			}
		*/
		
			//myChar.rotation = plane.rotation;
		
			if(myChar.y > stage.stageHeight *0.8){
				planeGameOver = true;
			}
			
			 if(planeGameOver == true){
				gameOverScreen.x = stage.stageWidth/2;
				 if(contains(plane)){
			removeChild(plane);
			}
			
			if(contains(myChar)){
			removeChild(myChar);		
			}
				planeGameWon = false;
				var gameLost : Timer = new Timer(3000);
			gameLost.addEventListener(TimerEvent.TIMER_COMPLETE, newGame);
			gameLost.start();
			
			function newGame(lost:TimerEvent): void{
				gameOverScreen.x = stage.stageWidth + gameOverScreen;
				randomGameGenorator();
			}	
			
		}
	}

		stage.addEventListener(KeyboardEvent.KEY_DOWN, test);

		function test (event:KeyboardEvent):void{
			if(event.keyCode == 37){
				myChar.x -= 18;
			}
			
			if(event.keyCode == 39){
				myChar.x += 18;
			}
		}	
		var accelerometer: Accelerometer = new Accelerometer();

		accelerometer.addEventListener(AccelerometerEvent.UPDATE, accUpdateHandler);

		function accUpdateHandler(event:AccelerometerEvent):void{
			
			//if(event.accelerationX >=0.5){
				myChar.x += event.accelerationX * 15;
				//trace("AccX="+ event.accelerationX);
			  //}
			myChar.x -= event.accelerationZ * 15;
		}