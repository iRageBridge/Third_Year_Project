﻿import flash.events.Event;
import flash.geom.Point;
import flash.events.MouseEvent;
import flash.utils.Timer;
import flash.events.TimerEvent;
import flash.events.AccelerometerEvent;
import flash.sensors.Accelerometer;

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
	
	if(tilt == true)
	{
		plane.rotation += planeRotation;
	}
	
	if(tilt == false)
	{
		plane.rotation -= planeRotation;
	}
	
	if(plane.rotation >=30)
	{
		tilt = false;
		//trace("f");
	}

	if(plane.rotation <=-30 )
	{
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
		trace("L<R");
	}
	
	if(contactL > contactR){
		myChar.x +=10;
		trace("L>R");
	}
	
	myChar.rotation = plane.rotation;
	
	if(myChar.y > stage.stageHeight *0.8){
		trace("You lose");
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
	
	//if(event.accelerationX >=0.5)
	//{
		myChar.x += event.accelerationX * 15;
		//trace("AccX="+ event.accelerationX);
	//}
		myChar.x -= event.accelerationZ * 15;
	
}