package {
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class ScrollBarMain extends ScrollBarBase {
		[Embed(source = "../lib/scrollBack.png")]
		private var BackImage:Class;
		
		[Embed(source = "../lib/scrollBall.png")]
		private var ScrollIcon:Class;
		
		public function ScrollBarMain(a:ScrollArea) {
			super(a);
			backImage = new BackImage();
			scrollIcon = new ScrollIcon();
			this.addChild(backImage);
			// this.addChild(scrollIcon);
			rollerMin = 3;
			
			scrollRoller = new ButtonImage(scrollIcon, temp);
			scrollRoller.x = 2;
			scrollRoller.y = rollerMin;
			this.addChild(scrollRoller);
		}
		
		private function temp(e:MouseEvent):void {
			// ...
		}
	}
}