package {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class FileLister extends ScrollArea {
		public static const PRIMITIVE_CHILDREN:int = 1;
		
		private var directory:File;
		private var files:Array;
		
		public function FileLister() {
			super(300, 120);
			directory = File.applicationStorageDirectory.resolvePath("data");
			files = directory.getDirectoryListing();
		}
		
		public function listFiles():void {
			clearList();
			files = directory.getDirectoryListing();
			for (var i:int = 0; i < files.length; ++i) {
				if (files[i].extension == "txt") {
					var b:ButtonText = new ButtonText(Main.preferencesWidgit.listAction);
					b.y = 20 * (this.numChildren - PRIMITIVE_CHILDREN);
					b.setWidth(273);
					b.setText(files[i].name.substring(0, files[i].name.length - 4));
					this.addChild(b);
				}
			}
			thisMask.height = 20 * (this.numChildren - 1);
			scrollBar.setMaxY(20 * (this.numChildren - FileLister.PRIMITIVE_CHILDREN) - this.height);
		}
		
		private function clearList():void {
			while (this.numChildren > PRIMITIVE_CHILDREN) // Only go to 2, otherwise you remove the mask that allows scrolling
				this.removeChildAt(this.numChildren - 1);
		}
	}
}