package {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.events.Event;
	
	public class PreferencesWidgit extends Widgit {
		private var fileToUseDes:TextField;
		private var fileToUseInput:InputField;
		
		private var fileListDes:TextField;
		private var fileList:FileLister;
		private var scrollBar:ScrollBarMain;
		
		private var submitButton:ButtonMain;
		private var finishButton:ButtonMain;
		
		private var status:TextField;
		private var statusDelay:int;
		
		public function PreferencesWidgit() {
			var tf:TextFormat = Main.createDefaultTF();
			tf.size = 16;
			
			fileToUseDes = new TextField();
			fileToUseDes.selectable = false;
			fileToUseDes.embedFonts = true;
			fileToUseDes.defaultTextFormat = tf;
			fileToUseDes.x = 10;
			fileToUseDes.y = 40;
			fileToUseDes.width = 380;
			fileToUseDes.height = 20;
			fileToUseDes.text = "File To Use:";
			this.addChild(fileToUseDes);
			
			fileToUseInput = new InputField();
			fileToUseInput.restrict = "a-zA-Z0-9_";
			fileToUseInput.maxChars = 31;
			fileToUseInput.x = 96;
			fileToUseInput.y = 40;
			fileToUseInput.width = 294;
			fileToUseInput.height = 20;
			fileToUseInput.text = Main.fileManager.wordsFileName();
			this.addChild(fileToUseInput);
			
			fileListDes = new TextField();
			fileListDes.selectable = false;
			fileListDes.embedFonts = true;
			fileListDes.defaultTextFormat = tf;
			fileListDes.x = 10;
			fileListDes.y = 80;
			fileListDes.width = 380;
			fileListDes.height = 20;
			fileListDes.text = "File Listing:";
			this.addChild(fileListDes);
			
			fileList = new FileLister();
			fileList.x = 90;
			fileList.y = 82;
			this.addChild(fileList);
			
			scrollBar = new ScrollBarMain(fileList);
			scrollBar.x = 370;
			scrollBar.y = 82;
			this.addChild(scrollBar);
			
			submitButton = new ButtonMain(submitAction);
			submitButton.setText("Submit");
			submitButton.x = 220;
			submitButton.y = 210;
			this.addChild(submitButton);
			
			finishButton = new ButtonMain(finishAction);
			finishButton.setText("Finish");
			finishButton.x = 90;
			finishButton.y = 210;
			this.addChild(finishButton);
			
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
		}
		
		private function submitAction(e:MouseEvent):void {
			if (fileToUseInput.text.length < 1) {
				writeStatus("Error: No File Given");
				return;
			}
			if (fileToUseInput.text.charAt(0) == "_") {
				// Reserved for special use if needed
				writeStatus("Error: '_' can't be first character");
				return;
			}
			if (Main.fileManager.writeParam(Main.fileManager.getFile(FileManager.FILE_PREFERENCES), "file", fileToUseInput.text)) {
				writeStatus("Success: File Set");
				Main.fileManager.reInit();
			}
			else
				writeStatus("Error: File Corruption");
		}
		
		private function finishAction(e:MouseEvent):void {
			Main.optionsBar.activatePrefsButton();
			Main.swapWidgits(Main.exerciseWidgit);
		}
		
		public function writeStatus(t:String):void {
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
		
		public function resetFileNameBox():void {
			fileToUseInput.text = Main.fileManager.wordsFileName();
		}
		
		public function listAction(e:MouseEvent):void {
			fileToUseInput.text = e.currentTarget.getText();
			writeStatus("Press Submit to confirm");
		}
		public function displayFileList():void {
			fileList.listFiles();
		}
	}
}