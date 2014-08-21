package 
{
	import flash.desktop.NativeApplication;
	import flash.display.NativeWindow;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.InvokeEvent;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * @author Rhuno
	 */
	public class Main extends Sprite 
	{
		private const DEF_WIDTH:int = 320;
		private const DEF_HEIGHT:int = 240;
		
		private var cWidth:int;
		private var cHeight:int;
		private var c:Camera;
		private var video:Video;
		private var window:NativeWindow;
		private var text:TextField;
		
		public function Main():void 
		{
			NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, onInvoke);	
		}
		
		private function onInvoke(e:InvokeEvent):void 
		{
			window 	= NativeApplication.nativeApplication.activeWindow;
			cWidth	= DEF_WIDTH;
			cHeight	= DEF_HEIGHT;
			
			// get the command line arguments
			for each(var s:String in e.arguments)			
			{
				if (s.indexOf("w=") >= 0)
				{
					cWidth = parseInt(s.substr(2, s.length));
				}
				
				if (s.indexOf("h=") >= 0)
				{
					cHeight = parseInt(s.substr(2, s.length));
				}
			}
			
			// check to make sure we got valid width and height values
			if (isNaN(cWidth) || cWidth == 0 || isNaN(cHeight) || cHeight == 0)
			{
				cWidth 	= DEF_WIDTH;
				cHeight = DEF_HEIGHT;
			}
			
			// set size and scale properties
			stage.scaleMode 		= StageScaleMode.NO_SCALE;
			stage.align				= StageAlign.TOP_LEFT;
			window.width			= cWidth;
			window.height			= cHeight;
			window.alwaysInFront	= true;
			stage.stageWidth 		= cWidth;
			stage.stageHeight 		= cHeight;
			
			init();
		}
		
		private function init():void
		{	
			c		= Camera.getCamera();
			
			if (c)
			{
				c.setMode(cWidth, cHeight, 24);
				c.setQuality(0, 70);
				video = new Video(cWidth, cHeight);
				video.attachCamera(c);				
				addChild(video);
			}			
			else
			{
				var tf:TextFormat;
				
				tf				= new TextFormat("Arial", 28, 0xcc0000, true);
				tf.align		= TextFormatAlign.CENTER;
				text			= new TextField();
				text.multiline	= true;
				text.width		= cWidth;
				text.height		= cHeight;
				text.text		= "Camera\nNot Found";
				text.setTextFormat(tf);
				addChild(text);
			}
		}
	}
	
}