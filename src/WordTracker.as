package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class WordTracker extends Sprite {
		private var field:TextField;
		private var totalWords:int;
		private var currentWords:int;
		
		public function WordTracker() {
			var tf:TextFormat = Main.createDefaultTF();
			tf.align = TextFormatAlign.CENTER;
			tf.size = 20;
			field = new TextField();
			field.embedFonts = true;
			field.defaultTextFormat = tf;
			field.width = 380;
			field.height = 30;
			field.selectable = false;
			this.addChild(field);
			this.addEventListener(Event.ENTER_FRAME, updateCount);
		}
		
		public function resetWords():void {
			totalWords = Main.exerciseWidgit.numberOfCurrentWords();
			currentWords = 0;
			updateText();
		}
		
		public function updateText():void {
			field.text = currentWords.toString() + " / " + totalWords.toString();
		}
		
		private function updateCount(e:Event):void {
			var curList:Vector.<String> = Main.exerciseWidgit.inputVector();
			var count:int = 0;
			for (var i:int = 0; i < curList.length; ++i) {
				if (Main.exerciseWidgit.currentCategory().wordList().indexOf(curList[i]) >= 0)
					++count;
			}
			currentWords = count;
			if (currentWords == totalWords) Main.exerciseWidgit.finishWord();
			updateText();
		}
	}
}