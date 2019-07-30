package {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.desktop.NativeApplication;
	
	public class OptionsBar extends Sprite {
		private var addButton:ButtonMain;
		private var prefButton:ButtonMain;
		private var aboutButton:ButtonMain;
		private var quitButton:ButtonMain;
		public function OptionsBar() {
			addButton = new ButtonMain(activateAdd);
			addButton.x = 5;
			addButton.y = 5;
			addButton.setText("Add Word");
			this.addChild(addButton);
			
			prefButton = new ButtonMain(activatePref);
			prefButton.x = 105;
			prefButton.y = 5;
			// prefButton.setText("Preferences");
			prefButton.setText("Choose File"); // Since the only preference is file so far
			this.addChild(prefButton);
			
			aboutButton = new ButtonMain(activateAbout);
			aboutButton.x = 205;
			aboutButton.y = 5;
			aboutButton.setText("About");
			this.addChild(aboutButton);
			
			quitButton = new ButtonMain(activateQuit);
			quitButton.x = 305;
			quitButton.y = 5;
			quitButton.setText("Exit");
			this.addChild(quitButton);
		}
		
		private function activateAdd(e:MouseEvent):void {
			addButton.deactivate();
			prefButton.activate();
			aboutButton.activate();
			Main.swapWidgits(Main.addWordWidgit);
		}
		private function activatePref(e:MouseEvent):void {
			prefButton.deactivate();
			addButton.activate();
			aboutButton.activate();
			Main.preferencesWidgit.resetFileNameBox();
			Main.preferencesWidgit.displayFileList();
			Main.swapWidgits(Main.preferencesWidgit);
		}
		private function activateAbout(e:MouseEvent):void {
			aboutButton.deactivate();
			addButton.activate();
			prefButton.activate();
			Main.swapWidgits(Main.aboutWidgit);
		}
		public static function activateQuit(e:MouseEvent):void {
			NativeApplication.nativeApplication.exit();
		}
		
		public function activateAddButton():void {
			addButton.activate();
		}
		
		public function activatePrefsButton():void {
			prefButton.activate();
		}
		
		public function activateAboutButton():void {
			aboutButton.activate();
		}
	}
}