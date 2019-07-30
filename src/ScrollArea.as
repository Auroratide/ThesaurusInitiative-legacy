package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class ScrollArea extends Sprite {
		private var scroll:Rectangle;
		protected var thisMask:Sprite;
		
		protected var scrollBar:ScrollBarBase;
		public function ScrollArea(w:Number = 100, h:Number = 100) {
			scroll = new Rectangle(0, 0, w, h);
			this.scrollRect = scroll;
			this.cacheAsBitmap = true;
			
			// Defines scrollable area
			thisMask = new Sprite();
			thisMask.graphics.beginFill(0x00FF00,0);
			thisMask.graphics.drawRect(0, 0, w, h);
			this.addChild(thisMask);
				
			this.addEventListener(MouseEvent.MOUSE_WHEEL, scrollSelection);
		}
		
		private function scrollSelection(e:MouseEvent):void {
			var rect:Rectangle = e.currentTarget.scrollRect;
			rect.y -= 3*e.delta;  // Delta is direction, essentially
			if (rect.y > 20 * (this.numChildren - FileLister.PRIMITIVE_CHILDREN) - this.height) rect.y = 20 * (this.numChildren - FileLister.PRIMITIVE_CHILDREN) - this.height;
			if (rect.y < 0) rect.y = 0;
			e.currentTarget.scrollRect = rect;
		}
		
		public function getPosition():Number {
			return this.scrollRect.y;
		}
		
		public function setScrollBar(s:ScrollBarBase):void {
			scrollBar = s;
		}
	}
}