package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class ButtonText extends ButtonBase {
		private var text:TextField;
		
		public function ButtonText(func:Function, active:Boolean = true) {
			super(func, active);
			var tf:TextFormat = Main.createDefaultTF();
			
			text = new TextField();
			text.selectable = false;
			text.embedFonts = true;
			text.defaultTextFormat = tf;
			text.height = 18;
			// text.border = true;
			this.addChild(text);
			this.addEventListener(MouseEvent.MOUSE_OVER, detectHoverIn);
		}
		
		public function setText(t:String):void {
			text.text = t;
		}
		public function getText():String {
			return text.text;
		}
		public function setWidth(w:Number):void {
			text.width = w;
		}
		
		/*  Hover Functions
		======================================*/
		private function detectHoverIn(e:MouseEvent):void {
			this.removeEventListener(Event.ENTER_FRAME, hoverOut);
			this.addEventListener(MouseEvent.MOUSE_OUT, detectHoverOut);
			this.addEventListener(Event.ENTER_FRAME, hoverIn);
			this.removeEventListener(MouseEvent.MOUSE_OVER, detectHoverIn);
		}
		
		private function hoverIn(e:Event):void {
			++text.x;
			if (text.x >= 7) {
				text.x = 7;
				this.removeEventListener(Event.ENTER_FRAME, hoverIn);
			}
		}
		
		private function detectHoverOut(e:MouseEvent):void {
			this.removeEventListener(Event.ENTER_FRAME, hoverIn);
			this.addEventListener(MouseEvent.MOUSE_OVER, detectHoverIn);
			this.addEventListener(Event.ENTER_FRAME, hoverOut);
			this.removeEventListener(MouseEvent.MOUSE_OUT, detectHoverOut);
		}
		
		private function hoverOut(e:Event):void {
			--text.x;
			if (text.x <= 0) {
				text.x = 0;
				this.removeEventListener(Event.ENTER_FRAME, hoverOut);
			}
		}
	}
}