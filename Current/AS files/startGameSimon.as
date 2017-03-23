stage.addEventListener(TouchEvent.TOUCH_TAP, begin);

function begin(e:TouchEvent):void{
	if(e.target == startScreen.startGame){
		trace("hit");
		startScreen.x += 2000;
		gotoAndStop(2);
		stage.removeEventListener(TouchEvent.TOUCH_TAP, begin);
	}
	else if(e.target == startScreen.achievements){
		achievementScreen.x=12.95;
		achievementScreen.y=-29.85;
	}
	else if(e.target == achievementScreen.achievementBack){
		achievementScreen.x +=2000;
	}
}