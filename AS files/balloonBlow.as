stage.addEventListener(Event.ENTER_FRAME, popCheckHandler);
var myMic: Microphone = Microphone.getMicrophone(-1);
myMic.addEventListener(SampleDataEvent.SAMPLE_DATA, micActivityHandler);
var myBalloon: BalloonBlow = new BalloonBlow();
myBalloon.x = 530;
myBalloon.y = 464;
stage.addChild(myBalloon);
var balloonText: BalloonBlowText = new BalloonBlowText();
balloonText.x = 650;
balloonText.y = 176;
stage.addChild(balloonText);

function micActivityHandler(micData:SampleDataEvent):void{
	var level:Number = myMic.activityLevel;
	//trace(level);
	if(level >= 20){
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
	trace(myBalloon.currentFrame);
	if(myBalloon.currentFrame == 75){
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
	myBalloon.gotoAndStop(1);
	MovieClip(root).victoryScreen.x = 2203.8;
	MovieClip(root).victoryScreen.y = 388.55;
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
		gotoAndStop(4);
		balloonBlowVictoryTimer.stop();
	}
}