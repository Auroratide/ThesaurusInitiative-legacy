package {
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Widgit extends Sprite {
		public function Widgit() { }
		
		public function fadeIn():void {
			this.x = 0;
			this.addEventListener(Event.ENTER_FRAME, fadeInFrame);
		}
		public function fadeOut():void {
			this.addEventListener(Event.ENTER_FRAME, fadeOutFrame);
		}
		private function fadeOutFrame(e:Event):void {
			this.alpha -= .1;
			if (this.alpha <= 0) {
				this.alpha = 0;
				this.removeEventListener(Event.ENTER_FRAME, fadeOutFrame);
				this.x = -500;
			}
		}
		private function fadeInFrame(e:Event):void {
			this.alpha += .1;
			if (this.alpha >= 1) {
				this.alpha = 1;
				this.removeEventListener(Event.ENTER_FRAME, fadeInFrame);
			}
		}
	}
}