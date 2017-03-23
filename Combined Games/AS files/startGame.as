import flash.events.TouchEvent;
import flash.utils.Timer;

stage.addEventListener(TouchEvent.TOUCH_TAP, begin);
stage.addEventListener(Event.ENTER_FRAME, loops);
var fly : Timer = new Timer(5000);


fly.addEventListener(TimerEvent.TIMER,startFly);

function begin(e:TouchEvent):void{
	
	if(e.target == startGame){
		gotoAndStop(1);
	}
}

function loops(event:Event):void{
	
	loopda.stop();
}

function startFly(Ev:TimerEvent):void{
	trace("start");
	loopda.play();
	
}


