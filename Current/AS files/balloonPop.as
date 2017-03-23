trace("Start pop");
MovieClip(root).scoreTimer.start();
var randomGame:int =  Math.random()*2;
var randomColor: int = Math.random()*5;
var startText: String;
var countDown: int = 15;
var counter: int = 0;
var selectedObject: DisplayObject;
var spawnBalloon : Timer = new Timer(5,30);
var gameCounter : Timer = new Timer(1000);
var balloons: Array = new Array;
var textField: TextField = new TextField();
var textField2: TextField = new TextField();
var randomGame2: int = Math.random()*7;
if(randomGame2 == 0 || randomGame2 == 1){
	trace("Frame 1 trigger");
	randomGame2 = 2;
}
trace(randomGame2);
textField.x=200;
textField2.x=203;
textField.y=50;
textField2.y=53;
textField.defaultTextFormat = new TextFormat('OCR A Std',60);
textField2.defaultTextFormat = new TextFormat('OCR A Std',60);
gameCounter.start();
spawnBalloon.start();
if(randomGame2 == 3){
	randomGame2++;
}
if(MovieClip(root).lives > 0){
	stage.addChildAt(textField2,1);
	stage.addChildAt(textField,2);
}

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
	var myColor:ColorTransform = this.transform.colorTransform;
	var balloon: Balloon = new Balloon;
	if(MovieClip(root).lives > 0){
		stage.addChildAt(balloon,1);
	}
	textField.textColor = colorArray[randomColor];
	textField2.textColor = 0x000000;
	textField.width=stage.stageWidth;
	textField.text= "Pop the "+startText+" balloons";
	textField2.width=stage.stageWidth;
	textField2.text= "Pop the "+startText+" balloons";
	balloon.y = Math.random()* stage.stageHeight;
	balloon.x = Math.random()* stage.stageWidth-balloon.width;
	balloon.addEventListener(Event.ENTER_FRAME, balloonMovement);
	balloon.addEventListener(TouchEvent.TOUCH_BEGIN, balloonHandler);
	myColor.color=colorArray[randomColorID];
	balloons.push(balloon);
	balloon.transform.colorTransform = myColor;
	
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
		if(myColor.color==colorArray[randomColor]){
			MovieClip(root).balloonAchievement++;
			balloon.gotoAndPlay(1);
			var mySound:Sound = new Recording(); 
			mySound.play();
			counter--;
			if(counter ==0){
				trace("victory pop");
				victory();
			}
		}
		else if(myColor.color!=colorArray[randomColor]){
			MovieClip(root).lives--;
			trace("Game over pop wrong color");
			if(MovieClip(root).lives == 0){
				MovieClip(root).scoreTimer.stop();
				MovieClip(root).victoryScreen.scoreText.text = 'Score: ' + MovieClip(root).score;
				MovieClip(root).victoryScreen.scoreTextShadow.text = 'Score: ' + MovieClip(root).score;
				MovieClip(root).gameOver.x = 640;
				MovieClip(root).gameOver.y = 360;
				victory();
				MovieClip(root).victoryScreen.x = 3700;
			}
			else{
				victory();
				gameCounter.stop();
			}
		}
	}
}

function gameCounterHandler(event:TimerEvent):void{
	countDown--;
	if(countDown == 0){
		trace("Game over pop timer");
		MovieClip(root).lives--;
		if(MovieClip(root).lives == 0){
			MovieClip(root).scoreTimer.stop();
			MovieClip(root).gameOver.gameOverText.text = 'Score: ' + MovieClip(root).score;
			MovieClip(root).gameOver.gameOverTextShadow.text = 'Score: ' + MovieClip(root).score;
			MovieClip(root).victoryScreen.scoreText.text = 'Score: ' + MovieClip(root).score;
			MovieClip(root).victoryScreen.scoreTextShadow.text = 'Score: ' + MovieClip(root).score;
			MovieClip(root).gameOver.x = 640;
			MovieClip(root).gameOver.y = 360;
			victory();
			MovieClip(root).victoryScreen.x = 3700;
		}
		else{
			victory();
			gameCounter.stop();
		}
	}
}

function victory():void{
	MovieClip(root).scoreTimer.stop();
	MovieClip(root).victoryScreen.scoreText.text = 'Score: ' + MovieClip(root).score;
	MovieClip(root).victoryScreen.scoreTextShadow.text = 'Score: ' + MovieClip(root).score;
	MovieClip(root).victoryScreen.x = 1985.2;
	MovieClip(root).victoryScreen.y = 349;
	for(var i: int = 0; i < balloons.length; i++){
		if(stage.contains(balloons[i])){
			stage.removeChild(balloons[i]);
		}
		textField.alpha=0;
		textField2.alpha=0;
	}
	var balloonVictoryTimer: Timer = new Timer(2000);
	balloonVictoryTimer.addEventListener(TimerEvent.TIMER,balloonVictoryHandler);
	balloonVictoryTimer.start();
	function balloonVictoryHandler(event:TimerEvent):void{
		MovieClip(root).victoryScreen.x = 3600;
		if(MovieClip(root).lives > 0){
			gotoAndStop(randomGame2);
		}
		balloonVictoryTimer.stop();
	}
	gameCounter.stop();
	spawnBalloon.stop();
}