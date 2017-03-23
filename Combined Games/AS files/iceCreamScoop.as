trace("Start scoop");
MovieClip(root).scoreTimer.start();
var myCone: CharCone = new CharCone();
var scoopTimer: Timer = new Timer(1000);
var scoopCounter: int = 20;
var counterCone: Number = 0;
var coneText: ScoopsText = new ScoopsText();
var scoops: Array = new Array();
var stacks: Array = new Array();
var cream: Timer = new Timer(1500, 15);
var stack: Number = 4;
var s: Number = 60;
var top: Point = new Point(0, -70);
var top1: Point = new Point();
var last:Point = new Point();
var win: Boolean = false;
var collide: Boolean = false;
var first:Boolean = false;
var second:Boolean = false;
var third:Boolean = false;
var fourth:Boolean = false;
var randomGame4: int = Math.random()*5;
var scoopsText: ScoopsText = new ScoopsText();
scoopsText.x =615;
scoopsText.y = 174;
myCone.x = 600;
myCone.y = 500;
coneText.x = 650;
coneText.y = 176;
cream.start();
scoopTimer.start();
cream.start();
scoopTimer.addEventListener(TimerEvent.TIMER, scoopCounterHandler);
myCone.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
myCone.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
cream.addEventListener(TimerEvent.TIMER, createScoops);

stage.addChild(myCone);
stage.addChild(scoopsText);
if(randomGame4 == 4){
	randomGame4++;
}
function scoopCounterHandler(Event: TimerEvent):void{
	scoopCounter--;
	if(scoopCounter == 0){
		trace("Game over scoop");
		MovieClip(root).lives --;
		if(MovieClip(root).lives == 0){
			MovieClip(root).gameOver.gameOverText.text = 'Score: ' + MovieClip(root).score;
			MovieClip(root).gameOver.gameOverTextShadow.text = 'Score: ' + MovieClip(root).score;
			MovieClip(root).scoreTimer.stop();
			MovieClip(root).victoryScreen.scoreText.text = 'Score: ' + MovieClip(root).score;
			MovieClip(root).victoryScreen.scoreTextShadow.text = 'Score: ' + MovieClip(root).score;
			MovieClip(root).gameOver.x = 640;
			MovieClip(root).gameOver.y = 360;
			coneVictory();
			MovieClip(root).victoryScreen.x = 3700;
		}
		else{
			coneVictory();
			scoopTimer.stop();
		}
	}
}

function createScoops(tim: TimerEvent): void {
	var myScoop: Scoop = new Scoop();
	var colorArray: Array = new Array(0xc2f2d0, 0xc2f2d0, 0x6b3e26, 0xfdf5c9, 0xffc5d9);
	var randomColorID: Number = Math.floor(Math.random() * colorArray.length);
	var myColor: ColorTransform = this.transform.colorTransform;

	myColor.color = colorArray[randomColorID];
	scoops.push(myScoop);
	myScoop.x = Math.random() * (stage.stageWidth);
	stage.addChild(myScoop);
	myScoop.transform.colorTransform = myColor;
}

function onTouchBegin(e: TouchEvent) {
	var ypos: Number = e.currentTarget.y;
	var xpos: Number = e.currentTarget.x;
	e.target.startTouchDrag(e.touchPointID, false, new Rectangle(-xpos, ypos, stage.stageWidth * 2, 0));
}

function onTouchEnd(e: TouchEvent) {
	e.target.stopTouchDrag(e.touchPointID);
}

stage.addEventListener(Event.ENTER_FRAME, Fscoop);
function Fscoop(ev: Event): void {
	for (var i: int = 0; i <= scoops.length; i++) {
		if (scoops[i] != null) {
			if(scoops[i].y > stage.stageHeight){
				scoops[i].gravity = 0;					
			}
			if (myCone.hitTestPoint(scoops[i].x , scoops[i].y, true)) {
				scoops[i].gravity = 0;	
				scoops[i].x = myCone.x;
				scoops[i].first = true;
				collide = true;
			} 
			
			if(scoops[i].first == true){
				scoops[i].x = myCone.x;
			}
			
			if(scoops[i].second == true){
				scoops[i].x = myCone.x;
			}
			
			if(scoops[i].third == true){
				scoops[i].x = myCone.x;
			}
			
			if(scoops[i].fourth == true){
				scoops[i].x = myCone.x;
				coneVictory();
				scoopTimer.stop();
			}

			if (collide == true) {
				if(scoops[i].hitTestPoint(myCone.x +top.x, myCone.y + top.y,true)){
					scoops[i].gravity = 0;	
					scoops[i].second = true;
					second = true;
					top1.x = 0;
					top1.y = -130;
				}
				
				else if(scoops[i].hitTestPoint(myCone.x +top1.x, myCone.y + top1.y,true) && second == true ){
					scoops[i].gravity = 0;	
					scoops[i].third = true;
					last.x = 0;
					last.y = -200;
					third = true;
				}
				
				else if(scoops[i].hitTestPoint(myCone.x + last.x, myCone.y + last.y,true) && third == true){
					scoops[i].gravity = 0;	
					scoops[i].fourth = true;
				}
			}
		}
	}
}

function coneVictory():void{
	trace("victory scoop");
	stage.removeEventListener(Event.ENTER_FRAME, Fscoop);
	scoopTimer.removeEventListener(TimerEvent.TIMER, scoopCounterHandler);
	MovieClip(root).scoreTimer.stop();
	MovieClip(root).victoryScreen.scoreText.text = 'Score: ' + MovieClip(root).score;
	MovieClip(root).victoryScreen.scoreTextShadow.text = 'Score: ' + MovieClip(root).score;
	MovieClip(root).victoryScreen.x = 1985.2;
	MovieClip(root).victoryScreen.y = 349;
	if(stage.contains(myCone)){
		stage.removeChild(myCone);
	}
	for(var s: int = 0; s < scoops.length; s++){
		if(stage.contains(scoops[s])){
			scoops[s].alpha = 0;
		}
		cream.stop();
	}
	if(stage.contains(scoopsText)){
		stage.removeChild(scoopsText);
	}
	var iceCreamTimer: Timer = new Timer(2000);
	iceCreamTimer.addEventListener(TimerEvent.TIMER,iceCreamHandler);
	iceCreamTimer.start();
	function iceCreamHandler(event:TimerEvent):void{
		MovieClip(root).victoryScreen.x = 3600;
		if(MovieClip(root).lives > 0){
			gotoAndStop(randomGame4);
		}
		iceCreamTimer.stop();
	}
}