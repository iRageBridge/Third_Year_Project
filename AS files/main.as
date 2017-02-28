import flash.utils.Timer;
import flash.media.Microphone;
import flash.events.Event;
import flash.geom.Point;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.events.AccelerometerEvent;
import flash.sensors.Accelerometer;
import flash.geom.Point;
import flash.events.TimerEvent;
import flash.events.TouchEvent;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.geom.ColorTransform;
import fl.motion.easing.Back;

Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;

var lives: int = 3;
clouds.gotoAndStop(1);