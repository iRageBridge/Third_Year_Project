trace("Start blow");
MovieClip(root).scoreTimer.start();
var myMic: Microphone = Microphone.getMicrophone(-1);
var myBalloon: BalloonBlow = new BalloonBlow();
var blowCounter:int = 30;
var balloonText: BalloonBlowText = new BalloonBlowText();
var blowTimer:Timer = new Timer(1000);
var randomGame3: int = Math.random()*5;
blowTimer.start();
myBalloon.x = 530;
myBalloon.y = 464;
balloonText.x = 650;
balloonText.y = 176;

blowTimer.addEventListener(TimerEvent.TIMER, blowTimerHandler);
myMic.addEventListener(SampleDataEvent.SAMPLE_DATA, micActivityHandler);
if(randomGame3 == 3){
	randomGame3++;
}
if(MovieClip(root).lives > 0){
	stage.addChild(myBalloon);
	stage.addChild(balloonText);
}
stage.addEventListener(Event.ENTER_FRAME, popCheckHandler);

function blowTimerHandler(Event:TimerEvent):void{
	blowCounter--;
	if(blowCounter == 0){
		trace("Game over blow");
		MovieClip(root).lives--;
		if(MovieClip(root).lives == 0){
			MovieClip(root).scoreTimer.stop();
			MovieClip(root).gameOverScreen.gameOver.text = 'Score: ' + MovieClip(root).score;
			MovieClip(root).gameOverScreen.gameOverShadow.text = 'Score: ' + MovieClip(root).score;
			MovieClip(root).victoryScreen.scoreText.text = 'Score: ' + MovieClip(root).score;
			MovieClip(root).victoryScreen.scoreTextShadow.text = 'Score: ' + MovieClip(root).score;
			MovieClip(root).gameOver.x = 640;
			MovieClip(root).gameOver.y = 360;
			blowVictory();
			MovieClip(root).victoryScreen.x = 3700;
		}
		else{
			blowVictory();
			blowTimer.stop();
		}
		blowTimer.stop();
		blowTimer.removeEventListener(TimerEvent.TIMER, blowTimerHandler);
	}
}

function micActivityHandler(micData:SampleDataEvent):void{
	var level:Number = myMic.activityLevel;
	if(level >= 10){
		if (myBalloon.hasEventListener(Event.ENTER_FRAME)){
			myBalloon.removeEventListener(Event.ENTER_FRAME,deflate);
		}
		myBalloon.addEventListener(Event.ENTER_FRAME,inflate);
	}
	else if(level < 20){
		if (myBalloon.hasEventListener(Event.ENTER_FRAME)){
			myBalloon.removeEventListener(Event.ENTER_FRAME,inflate);
		}
		myBalloon.addEventListener(Event.ENTER_FRAME,deflate);
	}
}

function popCheckHandler(e:Event):void{
	if(myBalloon.currentFrame == 75){
		trace("victory blow");
		blowTimer.removeEventListener(TimerEvent.TIMER, blowTimerHandler);
		stage.removeEventListener(Event.ENTER_FRAME, popCheckHandler);
		var mySound:Sound = new Recording(); 
		mySound.play();
		blowVictory();
	}
}

function inflate(e:Event):void{
    stopPlayReverse();
    myBalloon.play();
}

function deflate(e:Event):void{
    this.addEventListener(Event.ENTER_FRAME, playReverse, false, 0, true);
}

function playReverse(e:Event):void{
    if (myBalloon.currentFrame == 1){
        stopPlayReverse();
    } 
	else {
        myBalloon.prevFrame();
    }
}

function stopPlayReverse():void{
    if (this.hasEventListener(Event.ENTER_FRAME)){
        this.removeEventListener(Event.ENTER_FRAME, playReverse);
    }
}

function blowVictory():void{
	stage.removeEventListener(Event.ENTER_FRAME, popCheckHandler);
	myBalloon.gotoAndStop(1);
	MovieClip(root).scoreTimer.stop();
	MovieClip(root).victoryScreen.scoreText.text = 'Score: ' + MovieClip(root).score;
	MovieClip(root).victoryScreen.scoreTextShadow.text = 'Score: ' + MovieClip(root).score;
	MovieClip(root).victoryScreen.x = 1985.2;
	MovieClip(root).victoryScreen.y = 349;
	if(stage.contains(myBalloon)){
		stage.removeChild(myBalloon);
	}
	if(stage.contains(balloonText)){
		stage.removeChild(balloonText);
	}
	var balloonBlowVictoryTimer: Timer = new Timer(2000);
	balloonBlowVictoryTimer.addEventListener(TimerEvent.TIMER,balloonBlowVictoryHandler);
	balloonBlowVictoryTimer.start();
	function balloonBlowVictoryHandler(event:TimerEvent):void{
		MovieClip(root).victoryScreen.x = 3600;
		if(MovieClip(root).lives > 0){
			gotoAndStop(randomGame3);
		}
		balloonBlowVictoryTimer.stop();
	}
}