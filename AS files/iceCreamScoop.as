var myCone: CharCone = new CharCone();
myCone.x = 600;
myCone.y = 500;
stage.addChild(myCone);
var scoops: Array = new Array();
var stacks: Array = new Array();
var cream: Timer = new Timer(1500, 15);
var counterCone: Number = 0;
var stack: Number = 4;
var s: Number = 60;
var top: Point = new Point(0, -83.5);
var win: Boolean = false;
var collide: Boolean = false;
cream.start();
myCone.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
myCone.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
cream.addEventListener(TimerEvent.TIMER, createScoops);
var coneText: ScoopsText = new ScoopsText();
coneText.x = 650;
coneText.y = 176;
stage.addChild(coneText);

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
			//if(scoops[i].y >stage.stageHeight+scoops[i].height){
				//scoops.splice(scoops[i],1);
		//	}
		
		if (scoops[i] != null) {
			//trace(scoops[i]);
			if (myCone.hitTestPoint(scoops[i].x , scoops[i].y, true) /* || (scoops[i].hitTestPoint(scoops[i+1].y + top.y,scoops[i+1].x = top.x,true))*/ ) {
				scoops[i].gravity = 0;				
				//scoops[i].y = myCone.y - scoops[i].height;
				//scoops[i].x = myCone.x + scoops[i].width * 1.5;
				//counter++;
				trace(counter);
				trace(top.y);
				switch (counter) {
					case 0:
						scoops[i].y = myCone.y;
						counter++;
						//top.y +=s;
						//stack += 10;				
						break;

					case 1:
						scoops[i].y = myCone.y - stack;
						//top.y +=s-5;
						stack += s;
						counter++;
					break;

					case 2:				
						scoops[i].y = myCone.y - stack;
						//top.y -=stack;
						stack += s;
						counter++;
					
						break;

					case 3:						
						scoops[i].y = myCone.y - stack;
						//top.y -=stack;
						stack += s;
						counter++;
						break;

					case 4:
						scoops[i].y = myCone.y - stack;
						//top.y -=stack;
						stack += s;
						counter++;
						coneVictory();						
						
						break;

					case 5:
						win = true;
						
						break;
				}

				scoops[i].collide = true;
			} 
			else {
				collide = false;
			}

			if (scoops[i].collide == true) {
				//scoops[i].y = myCone.y - scoops[i].height;
				scoops[i].x = myCone.x;		
			}
		}
	}
}

stage.addEventListener(MouseEvent.CLICK, clicked);

function clicked(e:MouseEvent):void{	
		trace(e.target.name);	
}

function coneVictory():void{
	MovieClip(root).victoryScreen.x = 2203.8;
	MovieClip(root).victoryScreen.y = 388.55;
	if(stage.contains(myCone)){
		stage.removeChild(myCone);
	}
	for(var s: int = 0; s < scoops.length; s++){
		if(stage.contains(scoops[s])){
			scoops[s].alpha = 0;
		}
		cream.stop();
	}
	if(stage.contains(coneText)){
		stage.removeChild(coneText);
	}
	var iceCreamTimer: Timer = new Timer(2000);
	iceCreamTimer.addEventListener(TimerEvent.TIMER,iceCreamHandler);
	iceCreamTimer.start();
	function iceCreamHandler(event:TimerEvent):void{
		MovieClip(root).victoryScreen.x = 3600;
		gotoAndStop(5);
		iceCreamTimer.stop();
	}
}