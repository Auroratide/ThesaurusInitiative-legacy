package {
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.events.Event;
	public class ButtonMain extends ButtonBase {
		[Embed(source = "../lib/buttonBack.png")]
		private var ButtonMainImage:Class;
		private var buttonMainImage:Bitmap = new ButtonMainImage();
		
		[Embed(source = "../lib/buttonBackHover.png")]
		private var ButtonMainHover:Class;
		private var buttonMainHover:Bitmap = new ButtonMainHover();
		
		private var textfield:TextField;
		private var tf:TextFormat;
		public function ButtonMain(func:Function, active:Boolean = true) {
			super(func, active);
			buttonMainHover.alpha = 0;
			this.addChild(buttonMainHover);
			this.addChild(buttonMainImage);
			textfield = new TextField();
			tf = Main.createDefaultTF();
			tf.align = TextFormatAlign.CENTER;
			textfield.embedFonts = true;
			textfield.selectable = false;
			textfield.width = 90;
			textfield.height = 20;
			this.width = 90;
			this.height = 20;
			textfield.defaultTextFormat = tf;
			this.addChild(textfield);
		}
		
		public function setText(t:String):void {
			textfield.text = t;
		}
		
		override public function deactivate():void {
			super.deactivate();
			this.addEventListener(Event.ENTER_FRAME, fadeButtonOut);
			this.addEventListener(Event.ENTER_FRAME, hoverOut);
			this.removeEventListener(MouseEvent.MOUSE_OVER, detectHoverIn);
			this.removeEventListener(MouseEvent.MOUSE_OUT, detectHoverOut);
		}
		
		override public function activate():void {
			super.activate();
			this.addEventListener(Event.ENTER_FRAME, fadeButtonIn);
			this.addEventListener(MouseEvent.MOUSE_OVER, detectHoverIn);
		}
		
		private function fadeButtonOut(e:Event):void {
			this.alpha -= .1;
			if (this.alpha <= .30) {
				this.alpha = .30;
				this.removeEventListener(Event.ENTER_FRAME, fadeButtonOut);
			}
		}
		
		private function fadeButtonIn(e:Event):void {
			this.alpha += .1;
			if (this.alpha >= 1) {
				this.alpha = 1;
				this.removeEventListener(Event.ENTER_FRAME, fadeButtonIn);
			}
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
			buttonMainHover.alpha += .1;
			if (buttonMainHover.alpha >= .8) {
				buttonMainHover.alpha = .8;
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
			buttonMainHover.alpha -= .1;
			if (buttonMainHover.alpha <= 0) {
				buttonMainHover.alpha = 0;
				this.removeEventListener(Event.ENTER_FRAME, hoverOut);
			}
		}
	}
}