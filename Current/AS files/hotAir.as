var press : Boolean = false;
var move : Boolean = true;
var hotAirWin : Boolean = false;
var counter1: Number = 0;
var hotAir: HotAirB = new HotAirB();
var flame : Flame = new Flame();
var border : Rise = new Rise();
var randomGame6 : int = Math.random()*7;
if(randomGame6 == 0 || randomGame6 == 1){
	trace("Frame 1 trigger");
	randomGame6 = 2;
}
if(randomGame6 == 7){
	randomGame6++;
}
trace(randomGame6);
var hotAirTimer : Timer = new Timer(900);
var hotAirLose: int = 9;
hotAirTimer.start();

hotAir.x = 640;
hotAir.y = 350;

flame.x = 60;
flame.y = 610;

border.x = 60;
border.y = 600;  

stage.addChild(hotAir);
stage.addChild(flame);
stage.addChild(border);

stage.addEventListener(Event.ENTER_FRAME, hotAirStart);
stage.addEventListener(TouchEvent.TOUCH_TAP, onTap);
hotAirTimer.addEventListener(TimerEvent.TIMER, hotAirHandler);

function hotAirHandler(Event:TimerEvent):void{
	trace(hotAirLose);
	
	hotAirLose --;
	if(hotAirLose ==0){
		MovieClip(root).lives --;
		if(MovieClip(root).lives == 0){
			MovieClip(root).scoreTimer.stop();
			MovieClip(root).victoryScreen.scoreText.text = 'Score: ' + MovieClip(root).score;
			MovieClip(root).victoryScreen.scoreTextShadow.text = 'Score: ' + MovieClip(root).score;
			MovieClip(root).gameOver.x = 640;
			MovieClip(root).gameOver.y = 360;
			//victory();
			//MovieClip(root).victoryScreen.x = 3700;

			//stage.removeEventListener(Event.ENTER_FRAME, hotAirStart);
			hotAirTimer.stop();
			var hotAirVictory : Timer = new Timer(2000);
			if(stage.contains(flame)){
				stage.removeChild(flame);
			}
			if(stage.contains(hotAir)){
				stage.removeChild(hotAir);
			}
			if(stage.contains(border)){
				stage.removeChild(border);
			}

			//gotoAndStop(7);
		}
				
		else{	
			hotAirWon();
			hotAirTimer.stop();
		}
		hotAirTimer.stop();
		hotAirTimer.removeEventListener(TimerEvent.TIMER, hotAirHandler);
	}	
}

function hotAirStart(e:Event):void{
	if(flame.x >= 1210){
		move = false;
	}
	
	if(flame.x <= 60){
		move = true;
	}
	
	if(move == true){
		flame.x += 30;
	}
	
	else{
		flame.x -= 30;
	}
	
 
	if(flame.x > 560 && flame.x < 720){
		
		press = true;
	}
	
	else{
		press = false;
	}
	
	if(counter1 >= 3){
		//trace("you win");
		hotAirWon();
		//trace("HA");
	}
}

function onTap (Event:TouchEvent):void{
	if(press == true){
		hotAir.scaleY += 0.01;
		hotAir.scaleX += 0.01;
		counter1 ++;
		trace("counter"+counter1);
	}
}

if(randomGame6 == 6){
	randomGame6 --;
}

function hotAirWon(){
	stage.removeEventListener(TouchEvent.TOUCH_TAP, onTap);
	stage.removeEventListener(Event.ENTER_FRAME, hotAirStart);
	hotAirTimer.stop();
	var hotAirVictory : Timer = new Timer(2000);
	if(stage.contains(flame)){
		stage.removeChild(flame);
	}
	if(stage.contains(hotAir)){
		stage.removeChild(hotAir);
	}
	if(stage.contains(border)){
		stage.removeChild(border);
	}
	hotAirVictory.start();
	//trace("start");
	MovieClip(root).scoreTimer.stop();
	MovieClip(root).victoryScreen.scoreText.text = 'Score: ' + MovieClip(root).score;
	MovieClip(root).victoryScreen.scoreTextShadow.text = 'Score: ' + MovieClip(root).score;
	MovieClip(root).victoryScreen.x = 1985.2;
	MovieClip(root).victoryScreen.y = 349;
	hotAirVictory.addEventListener(TimerEvent.TIMER, victoryHandler);
	var nextGame: int = 2;
	function victoryHandler(ev:TimerEvent):void{
		nextGame--;
		if(nextGame == 0){	
			hotAirVictory.stop();
			if(MovieClip(root).lives > 0){
				MovieClip(root).victoryScreen.x = 3600;
				gotoAndStop(randomGame6);
			}
		}
	}
}
	
	
