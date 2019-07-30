package {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class ScrollBarBase extends Sprite {
		protected var backImage:Bitmap;
		protected var scrollIcon:Bitmap;
		protected var scrollRoller:ButtonImage;
		
		protected var rollerMin:Number;
		
		protected var maxY:Number;
		
		protected var area:ScrollArea;
		public function ScrollBarBase(a:ScrollArea) {
			area = a;
			area.setScrollBar(this);
			maxY = 1;
			this.addEventListener(Event.ENTER_FRAME, updateRoller);
		}
		
		private function updateRoller(e:Event):void {
			var delta:Number = (this.height - 2*rollerMin - scrollRoller.height) / maxY;
			scrollRoller.y = rollerMin + delta * area.getPosition();
		}
		
		public function setMaxY(n:Number):void {
			maxY = n;
			if (maxY <= 0) maxY = 1;
		}
	}
}