package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	public class ExerciseWidgit extends Widgit {
		/*  Elements
		=====================================*/
		private var inputWords:InputField;
		private var theWord:TextField;
		
		private var hintButton:ButtonMain;
		private var revealButton:ButtonMain;
		private var nextButton:ButtonMain;
		
		private var tracker:WordTracker;
		
		private var categories:Vector.<Category>;
		private var currentWord:int;
		
		private var hintLevel:int;
		
		/*  Constructor
		=====================================*/
		public function ExerciseWidgit() {
			// Input Field
			inputWords = new InputField();
			inputWords.x = 10;
			inputWords.y = 80;
			inputWords.width = 380;
			inputWords.height = 120;
			inputWords.wordWrap = true;
			inputWords.restrict = "a-z ,?";
			this.addChild(inputWords);
			
			// Posed Word
			theWord = new TextField();
			var tf:TextFormat = Main.createDefaultTF();
			tf.bold = true;
			tf.size = 20;
			theWord.embedFonts = true;
			theWord.defaultTextFormat = tf;
			theWord.x = 5;
			theWord.y = 45;
			theWord.width = 390;
			theWord.height = 24;
			theWord.selectable = false;
			this.addChild(theWord);
			
			// The Buttons
			hintButton = new ButtonMain(hintAction);
			revealButton = new ButtonMain(revealAction);
			nextButton = new ButtonMain(nextAction);
			hintButton.x = 40;
			hintButton.y = 210;
			revealButton.x = 155;
			revealButton.y = 210;
			nextButton.x = 270;
			nextButton.y = 210;
			hintButton.setText("Hint");
			revealButton.setText("Reveal Words");
			nextButton.setText("Next Word");
			this.addChild(hintButton);
			this.addChild(revealButton);
			this.addChild(nextButton);
			
			tracker = new WordTracker();
			tracker.x = 10;
			tracker.y = 250;
			this.addChild(tracker);
			
			hintLevel = 0;
			
			createCategories();
			// categories.sort(Main.sortRandom);
			// currentWord = 0;
		}
		
		/*  Access Functions
		===================================*/
		// Finds the number of words in categories[currentWord]
		public function numberOfCurrentWords():int {
			if (categories.length < 1)
				return 0;
			return categories[currentWord].wordList().length;
		}
		public function input():String {    return inputWords.text; }
		public function inputVector():Vector.<String> {
			var text:String = FileManager.stripSpaces(inputWords.text);
			return Vector.<String>(text.split(","));
		}
		public function currentCategory():Category {
			if (categories.length < 1)
				return new Category(":!"); // '!' cannot be typed
			return categories[currentWord];
		}
		
		public function createCategories():void {
			var catTemp:Vector.<Category> = new Vector.<Category>();
			for (var i:int = 0; i < Main.fileManager.numberOfCategories(); ++i) {
				catTemp.push(new Category(Main.fileManager.getCategory(i)));
			}
			categories = catTemp.slice();
			categories.sort(Main.sortRandom);
			currentWord = 0;
		}
		
		// Displays the currentWord to guess
		public function poseWord():void {
			inputWords.text = "";
			if (categories.length < 1) {
				theWord.text = "The current file has no words";
				hintButton.deactivate();
				revealButton.deactivate();
			}
			else{
				theWord.text = categories[currentWord].randomWord() + " (" + categories[currentWord].pilotWord() + ")";
				if (!hintButton.isButtonActive()) {
					hintButton.activate();
					revealButton.activate(); // They're paired
				}
			}
			tracker.resetWords();
			nextButton.deactivate();
		}
		public function finishWord():void {
			if(categories.length > 0)
				nextButton.activate();
		}
		
		private function hintAction(e:MouseEvent):void {
			++hintLevel;
			var str:String = "";
			var curList:Vector.<String> = inputVector();
			for (var i:int = 0; i < currentCategory().wordList().length; ++i) {
				var curWord:String = currentCategory().wordList()[i];
				if (curList.indexOf(curWord) >= 0) {
					str += curWord + ", ";
					continue;
				}
				var temp:String = curWord.substr(0, hintLevel);
				if (temp != curWord) temp += "?";
				str += temp + ", ";
			}
			inputWords.text = str;
		}
		private function revealAction(e:MouseEvent):void {
			var str:String = "";
			for (var i:int = 0; i < currentCategory().wordList().length; ++i)
				str += currentCategory().wordList()[i] + ", ";
			inputWords.text = str;
		}
		private function nextAction(e:MouseEvent):void {
			++currentWord;
			hintLevel = 0;
			if (currentWord + 1 > categories.length) currentWord = 0;
			poseWord();
		}
	}
}