import flash.events.Event;
import flash.geom.Point;
import flash.events.MouseEvent;
import flash.utils.Timer;
import flash.events.TimerEvent;
import flash.events.AccelerometerEvent;
import flash.sensors.Accelerometer;
import flash.events.TouchEvent;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.geom.ColorTransform;

Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;

function randomGameGenorator(){
	var randomGame: int = Math.random()*2;
	if(randomGame == 0){
		var randomColor: int = Math.random()*5;
		var startText: String;
		var countDown: int = 20;
		var counter: int = 0;
		var selectedObject: DisplayObject;
		var spawnBalloon : Timer = new Timer(5,30)
		var gameCounter : Timer = new Timer(1000);
		var balloons: Array = new Array;
		var textField: TextField = new TextField();
		var textField2: TextField = new TextField();

		textField.x=250;
		textField2.x=253;
		textField.y=50;
		textField2.y=53;
		textField.defaultTextFormat = new TextFormat('OCR A Std',50);
		textField2.defaultTextFormat = new TextFormat('OCR A Std',50);

		gameCounter.start();
		spawnBalloon.start();

		stage.addChildAt(textField2,1);
		stage.addChildAt(textField,2);

		spawnBalloon.addEventListener(TimerEvent.TIMER,addBalloon);
		gameCounter.addEventListener(TimerEvent.TIMER,gameCounterHandler);

		switch (randomColor){
			case 0:
			startText = "red";
			break;

			case 1:
			startText = "green";
			break;

			case 2:
			startText = "blue";
			break;

			case 3:
			startText = "yellow";
			break;

			case 4:
			startText = "pink";
			break;
		}

		function addBalloon (event:TimerEvent): void{
			var direction:Boolean = Math.random()>.5 ? true:false;
			var colorArray:Array = new Array(0xFF4400, 0x00FF44, 0x4400FF, 0xFFFF00, 0xFFC0CB);
			var randomColorID:Number = Math.floor(Math.random()*colorArray.length);
			//var myColor:ColorTransform = this.transform.colorTransform;
			var balloon: Balloon = new Balloon;
			
			textField.textColor = colorArray[randomColor];
			textField2.textColor = 0x000000;
			textField.width=stage.stageWidth;
			textField.text= "Pop the "+startText+" balloons";
			textField2.width=stage.stageWidth;
			textField2.text= "Pop the "+startText+" balloons";
			
			setChildIndex(gameOverScreen, 2);
			setChildIndex(victoryScreen,2);
			setChildIndex(clouds, 0);
			stage.addChildAt(balloon,1);
			balloon.y = Math.random()* stage.stageHeight;
			balloon.x = Math.random()* stage.stageWidth-balloon.width;
			balloon.addEventListener(Event.ENTER_FRAME, balloonMovement);
			balloon.addEventListener(TouchEvent.TOUCH_BEGIN, balloonHandler);
			//myColor.color=colorArray[randomColorID];
			balloons.push(balloon);
			//balloon.transform.colorTransform = myColor;
			
			if(direction == true){
				balloon.scaleX *=-1;
			}
			
			if(balloon.x < balloon.width){
				balloon.x = balloon.width;
			}
			
			if(randomColorID == randomColor){
				counter++;
			}
			
			function balloonMovement (event:Event) : void{
				balloon.y-=3;
				if(balloon.y <= 0){
					balloon.y = stage.stageHeight+balloon.height;
				}
			}
			
			function balloonHandler(event:TouchEvent):void{
				//if(myColor.color==colorArray[randomColor]){
					balloon.gotoAndPlay(1);
					counter--;
					if(counter ==0){
						victory();
					}
				//}
				//else if(myColor.color!=colorArray[randomColor]){
					//gameOver();
				//}
			}
		}

		function gameCounterHandler(event:TimerEvent):void{
			countDown--;
			if(countDown == 0){
				gameOver();
			}
			textField3.defaultTextFormat = new TextFormat('OCR A Std',50);
			textField3.textColor = 0xFF0000;
			textField3.text= countDown.toString();
		}

		function gameOver():void{
			gameOverScreen.x = stage.stageWidth/2;
			gameOverScreen.y = stage.stageHeight/2;
			for(var i: int = 0; i < balloons.length; i++){
				stage.removeChild(balloons[i]);
				textField.alpha=0;
				textField2.alpha=0;
			}
		}

		function victory():void{
			victoryScreen.x = stage.stageWidth/2;
			victoryScreen.y = 380.1;
			for(var i: int = 0; i < balloons.length; i++){
				balloons[i].alpha=0;
				textField.alpha=0;
				textField2.alpha=0;
			}
		}
	}
	else{
		var plane: Plane = new Plane();
		var myChar: Char = new Char()
		var planeGameOver: Boolean = false;
		myChar.x = 567;
		myChar.y = 186;
		plane.x = 600;
		plane.y = 386;
		addChild(plane);
		addChild(myChar);
		var countdown : Timer = new Timer(8000, 1)
		countdown.addEventListener(TimerEvent.TIMER_COMPLETE, youWin);
		countdown.start();

		var tilt : Boolean = new Boolean;
		var contactR : Boolean = false;
		var contactL : Boolean = false;
		var planeRotation: Number = 0.4;
		//var rotateRight: Number = 20;
		var leftBump : Point = new Point(-32,32);
		var rightBump : Point = new Point(32,32);
		var gravity :Number = 9.8;
		var friction : Number = 0.8;

		function youWin (event:TimerEvent):void{
			trace("youWin");
		}

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
			if(contactL==false && contactR == false){
				myChar.y += gravity;
			}
		
			if(plane.tWing.hitTestPoint(myChar.x + leftBump.x , myChar.y + leftBump.y,true)){
				contactL = true;
			}
			else{
				contactL = false;
			}
			if(contactL){
				myChar.y -= gravity*1.5;
				//trace("left");
			}
			
			if(plane.tWing.hitTestPoint(myChar.x + rightBump.x , myChar.y + rightBump.y,true)){
				contactR = true;
			}
		
			else{
				contactR = false;
			}
		
			if(contactR){
				myChar.y -= gravity*1.5;
				//trace("right");
			}
			
			if(contactL < contactR){
				myChar.x -=10;
				//trace("L<R");
			}
		
			if(contactL > contactR){
				myChar.x +=10;
				//trace("L>R");
			}
		
			myChar.rotation = plane.rotation;
		
			if(myChar.y > stage.stageHeight *0.8){
				planeGameOver = true;
			}
			if(planeGameOver == true){
				randomGameGenorator();
			}
		}	
		stage.addEventListener(KeyboardEvent.KEY_DOWN, test);

		function test (event:KeyboardEvent):void{
			if(event.keyCode == 37){
				myChar.x -= 8;
			}
			
			if(event.keyCode == 39){
				myChar.x += 8;
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
	}
}
randomGameGenorator();