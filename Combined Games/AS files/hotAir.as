
import flash.utils.Timer;



var press : Boolean = false;
var move : Boolean = true;
var hotAirWin : Boolean = false;
var counter1: Number = 0;
var hotAir: HotAirB = new HotAirB();
var flame : Flame = new Flame();
var border : Rise = new Rise();
var randomGame6 : Number = Math.random()*8;
var hotAirTimer : Timer = new Timer(9000);
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
stage.addEventListener(MouseEvent.CLICK, onClick);

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
		hotAirWin = true;
		//trace("HA");
	}
	
	if(hotAirWin == true){
		if(stage.contains(flame)){
			stage.removeChild(flame);
		}
		if(stage.contains(hotAir)){
			stage.removeChild(hotAir);
		}
		if(stage.contains(border)){
			stage.removeChild(border);
		}
		gotoAndStop(randomGame6);
		if(randomGame6 == 7){
			randomGame6 --;
		}
	}
}

function onClick (Event:MouseEvent):void{
 	
	if(press == true){
		hotAir.scaleY += 0.01;
		hotAir.scaleX += 0.01;
		counter1 ++;
		trace("counter"+counter1);
	}
	
}