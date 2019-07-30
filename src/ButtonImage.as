package {
	import flash.display.Bitmap;
	public class ButtonImage extends ButtonBase {
		private var icon:Bitmap;
		
		public function ButtonImage(i:Bitmap, func:Function, active:Boolean = true) {
			super(func, active);
			icon = i;
			this.addChild(icon);
		}
	}
}