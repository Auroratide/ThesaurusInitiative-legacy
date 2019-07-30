package {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class AboutWidgit extends Widgit {
		private var mainDes:TextField;
		private var instructions:TextField;
		private var finishButton:ButtonMain;
		
		public function AboutWidgit() {
			var tfTitle:TextFormat = Main.createDefaultTF();
			tfTitle.align = TextFormatAlign.CENTER;
			tfTitle.size = 18;
			
			mainDes = new TextField();
			mainDes.selectable = false;
			mainDes.embedFonts = true;
			mainDes.defaultTextFormat = tfTitle;
			mainDes.x = 10;
			mainDes.y = 40;
			mainDes.width = 380;
			mainDes.wordWrap = true;
			mainDes.text = "The Thesaurus Initiative is a tool meant to help you develop a stronger vocabulary";
			this.addChild(mainDes);
			
			var tf:TextFormat = Main.createDefaultTF();
			
			instructions = new TextField();
			instructions.selectable = false;
			instructions.embedFonts = true;
			instructions.defaultTextFormat = tf;
			instructions.x = 5;
			instructions.y = 90;
			instructions.width = 390;
			instructions.height = 250;
			instructions.wordWrap = true;
			instructions.text = "The program will present a word and its base meaning for which you must provide every synonym recorded in the file via a comma-separated list of words.\n\nPressing \"Hint\" will begin showing the letters of every word incrementally.\n\nPressing \"Reveal\" will unveil the words.\n\nYou may add your own words to the file by using the \"Add Word\" button.";
			this.addChild(instructions);
			
			finishButton = new ButtonMain(finishAction);
			finishButton.x = 155;
			finishButton.y = 270;
			finishButton.setText("Finish");
			this.addChild(finishButton);
		}
		
		private function finishAction(e:MouseEvent):void {
			Main.optionsBar.activateAboutButton();
			Main.swapWidgits(Main.exerciseWidgit);
		}
	}
}