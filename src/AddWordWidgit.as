package {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.events.Event;
	
	public class AddWordWidgit extends Widgit {
		private var pilotDes:TextField;
		private var wordsDes:TextField;
		private var status:TextField;
		private var statusDelay:int;
		
		private var pilotInput:InputField;
		private var wordsInput:InputField;
		
		private var submitButton:ButtonMain;
		private var finishButton:ButtonMain;
		
		public function AddWordWidgit() {
			var tf:TextFormat = Main.createDefaultTF();
			tf.size = 20;
			
			pilotDes = new TextField();
			pilotDes.selectable = false;
			pilotDes.embedFonts = true;
			pilotDes.defaultTextFormat = tf;
			pilotDes.x = 5;
			pilotDes.y = 45;
			pilotDes.text = "Pilot:";
			pilotDes.width = 50;
			pilotDes.height = 26;
			this.addChild(pilotDes);
			
			pilotInput = new InputField();
			pilotInput.restrict = "a-z ";
			pilotInput.x = 75;
			pilotInput.y = 48;
			pilotInput.width = 315;
			pilotInput.height = 20;
			this.addChild(pilotInput);
			
			wordsInput = new InputField();
			wordsInput.restrict = "a-z ,";
			wordsInput.x = 75;
			wordsInput.y = 83;
			wordsInput.width = 315;
			wordsInput.height = 120;
			wordsInput.wordWrap = true;
			this.addChild(wordsInput);
			
			wordsDes = new TextField();
			wordsDes.selectable = false;
			wordsDes.embedFonts = true;
			wordsDes.defaultTextFormat = tf;
			wordsDes.x = 5;
			wordsDes.y = 80;
			wordsDes.text = "Words:";
			wordsDes.width = 60;
			wordsDes.height = 26;
			this.addChild(wordsDes);
			
			var tf2:TextFormat = Main.createDefaultTF();
			tf2.align = TextFormatAlign.CENTER;
			tf2.size = 20;
			
			status = new TextField();
			status.selectable = false;
			status.embedFonts = true;
			status.defaultTextFormat = tf2;
			status.x = 5;
			status.y = 250;
			status.width = 390;
			status.height = 30;
			status.alpha = 0;
			this.addChild(status);
			statusDelay = 0;
			
			submitButton = new ButtonMain(submitAction);
			submitButton.setText("Submit");
			submitButton.x = 250;
			submitButton.y = 210;
			this.addChild(submitButton);
			
			finishButton = new ButtonMain(finishAction);
			finishButton.setText("Finish");
			finishButton.x = 125;
			finishButton.y = 210;
			this.addChild(finishButton);
		}
		
		private function submitAction(e:MouseEvent):void {
			if (pilotInput.text.length < 1) {
				writeStatus("Error: No Pilot Word");
				return;
			}
			if (wordsInput.text.length < 1) {
				writeStatus("Error: No Words List");
				return;
			}
			var success:String = "Success: Word Added";
			Main.fileManager.openFile(Main.fileManager.getFile(FileManager.FILE_WORDS));
			if (Main.fileManager.findParam(Main.fileManager.getFile(FileManager.FILE_WORDS), pilotInput.text) >= 0)
				success = "Success: Word Overridden";
			Main.fileManager.closeFile();
			if (Main.fileManager.writeWord(pilotInput.text, wordsInput.text)){
				writeStatus(success);
				pilotInput.text = "";
				wordsInput.text = "";
				Main.fileManager.reInit();
			}
			else
				writeStatus("Error: File Corruption");
		}
		
		private function finishAction(e:MouseEvent):void {
			Main.optionsBar.activateAddButton();
			Main.swapWidgits(Main.exerciseWidgit);
		}
		
		private function writeStatus(t:String):void {
			status.text = t;
			status.alpha = 1;
			statusDelay = 0;
			if(!this.hasEventListener(Event.ENTER_FRAME))
				this.addEventListener(Event.ENTER_FRAME, fadeStatusOut);
		}
		
		private function fadeStatusOut(e:Event):void {
			if(++statusDelay > 60){
				status.alpha -= .05;
				if (status.alpha <= 0) {
					status.alpha = 0;
					this.removeEventListener(Event.ENTER_FRAME, fadeStatusOut);
				}
			}
		}
	}
}