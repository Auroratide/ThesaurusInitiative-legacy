package {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	public class Background extends Sprite {
		[Embed(source = "../lib/background.png")]
		private var BackgroundImage:Class;
		private var backgroundImage:Bitmap = new BackgroundImage();
		
		public function Background() {
			this.addChild(backgroundImage);
		}
	}
}