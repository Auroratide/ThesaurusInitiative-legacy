package {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class WelcomeWidgit extends Widgit {
		private var title:TextField;
		private var author:TextField;
		private var versionInfo:TextField;
		private var version:TextField;
		private var beginButton:ButtonMain;
		
		public function WelcomeWidgit() {
			var tf:TextFormat = Main.createDefaultTF();
			tf.align = TextFormatAlign.CENTER;
			tf.size = 28;
			
			title = new TextField();
			title.selectable = false;
			title.embedFonts = true;
			title.defaultTextFormat = tf;
			title.x = 5;
			title.y = 60;
			title.width = 390;
			title.height = 35;
			title.text = "The Thesaurus Initiative";
			this.addChild(title);
			
			var tf2:TextFormat = Main.createDefaultTF();
			tf2.align = TextFormatAlign.CENTER;
			tf2.size = 16;
			
			author = new TextField();
			author.selectable = false;
			author.embedFonts = true;
			author.defaultTextFormat = tf2;
			author.x = 5;
			author.y = 100;
			author.width = 390;
			author.height = 30;
			author.text = "By Timothy Foster";
			this.addChild(author);
			
			var tf3:TextFormat = Main.createDefaultTF();
			tf3.align = TextFormatAlign.RIGHT;
			tf3.size = 12;
			
			version = new TextField();
			version.selectable = false;
			version.embedFonts = true;
			version.defaultTextFormat = tf3;
			version.x = 5;
			version.y = 280;
			version.width = 390;
			version.height = 20;
			version.text = Main.VERSION;
			version.alpha = .5;
			this.addChild(version);
			
			versionInfo = new TextField();
			versionInfo.selectable = false;
			versionInfo.embedFonts = true;
			versionInfo.defaultTextFormat = tf2;
			versionInfo.x = 5;
			versionInfo.y = 130;
			versionInfo.width = 390;
			versionInfo.height = 30;
			versionInfo.text = "Pre-Release Version";
			this.addChild(versionInfo);
			
			beginButton = new ButtonMain(beginAction);
			beginButton.x = 155;
			beginButton.y = 195;
			beginButton.setText("Begin");
			this.addChild(beginButton);
		}
		
		private function beginAction(e:MouseEvent):void {
			Main.swapWidgits(Main.exerciseWidgit);
		}
	}
}