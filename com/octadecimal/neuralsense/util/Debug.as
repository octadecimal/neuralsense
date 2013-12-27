package com.octadecimal.neuralsense.util
{
	//import flash.desktop.NativeApplication;
	//import flash.display.NativeWindow;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import nl.demonsters.debugger.MonsterDebugger;
	
	/**
	 * Various utility methods for printing formatted debug messages to the output buffer.
	 */
	public class Debug
	{
		// Offset
		private static const INDENT_LENGTH:uint = 28;
		
		// Colors
		private static const COLOR_DATA:uint = 0x999999;
		private static const COLOR_PRINT:uint = 0x444444;
		private static const COLOR_INFO:uint = 0x17AC02;
		private static const COLOR_WARN:uint = 0xCD692E;
		private static const COLOR_ERROR:uint = 0xFF0000;
		
		
		/**
		 * Data output.
		 */
		public static function data(origin:Object, msg:String):void
		{
			trace("2: " + Strings.objectMessage(origin, msg, INDENT_LENGTH, "    "));
			MonsterDebugger.trace(Strings.fromObject(origin), msg, COLOR_DATA);
		}
		
		/**
		 * Print output.
		 */
		public static function print(origin:Object, msg:String):void
		{
			trace("0: " + Strings.objectMessage(origin, msg, INDENT_LENGTH, "  > "));
			MonsterDebugger.trace(Strings.fromObject(origin), msg, COLOR_PRINT);
		}
		
		/**
		 * Info output.
		 */
		public static function info(origin:Object, msg:String):void
		{
			trace("1: "+Strings.objectMessage(origin, msg, INDENT_LENGTH, " >> "));
			MonsterDebugger.trace(Strings.fromObject(origin), msg, COLOR_INFO);
		}
		
		/**
		 * Warn output.
		 */
		public static function warn(origin:Object, msg:String):void
		{
			trace("3: "+Strings.objectMessage(origin, msg, INDENT_LENGTH, "  ! WARNING: "));
			MonsterDebugger.trace(Strings.fromObject(origin), msg, COLOR_WARN);
		}
		
		/**
		 * Error output.
		 */
		public static function error(origin:Object, msg:String):void
		{
			trace("4: "+Strings.objectMessage(origin, msg, INDENT_LENGTH, " !!! ERROR: "));
			MonsterDebugger.trace(Strings.fromObject(origin), msg, COLOR_ERROR);
		}
		
		
		/**
		 * Line output.
		 */
		public static function line():void
		{
			trace("0: -----------------------------   ------------------------------------------------------------------");
		}
		
		/**
		 * Double line output.
		 */
		public static function dline():void
		{
			trace("0: =============================   ==================================================================");
		}
		
		
		/**
		 * Auto-closes the window after the specified timeout.
		 * @param	timeout	Timeout in milliseconds before closing.
		 */
		public static function autoClose(timeout:Number = 1000):void
		{
			//var timer:Timer = new Timer(timeout);
			//timer.addEventListener(TimerEvent.TIMER, function doClose():void {
				//NativeWindow(NativeApplication.nativeApplication.openedWindows[0]).close();
			//});
			//timer.start();
		}
	}

}