package {
	import flash.display.Sprite;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.TextSnapshot;
	
	/**
	 * ...
	 * @author Ardeol
	 */
	public class Main extends Sprite {
		public static const VERSION:String = "0.13.0706";
		public static const CHARSET:String = "us-ascii";
		
		[Embed(source = "../lib/GARA.TTF",
			   fontName = "GaramondEmbed",
			   mimeType = "application/x-font",
			   embedAsCFF = "false")]
		public var GaramondEmbed:Class;
		
		public static var background:Background;
		
		public static var optionsBar:OptionsBar;
		public static var exerciseWidgit:ExerciseWidgit;
		public static var addWordWidgit:AddWordWidgit;
		public static var welcomeWidgit:WelcomeWidgit;
		public static var preferencesWidgit:PreferencesWidgit;
		public static var aboutWidgit:AboutWidgit;
		public static var fileManager:FileManager;
		
		public static var currentWidgit:Widgit;
		
		public function Main():void {
			background = new Background();
			stage.addChild(background);
			
			fileManager = new FileManager();
			
			optionsBar = new OptionsBar();
			stage.addChild(optionsBar);
			
			exerciseWidgit = new ExerciseWidgit();
			exerciseWidgit.alpha = 0;
			exerciseWidgit.x = -500;
			stage.addChild(exerciseWidgit);
			
			addWordWidgit = new AddWordWidgit();
			addWordWidgit.alpha = 0;
			addWordWidgit.x = -500;
			stage.addChild(addWordWidgit);
			
			preferencesWidgit = new PreferencesWidgit();
			preferencesWidgit.alpha = 0;
			preferencesWidgit.x = -500;
			stage.addChild(preferencesWidgit);
			
			aboutWidgit = new AboutWidgit();
			aboutWidgit.alpha = 0;
			aboutWidgit.x = -500;
			stage.addChild(aboutWidgit);
			
			welcomeWidgit = new WelcomeWidgit();
			stage.addChild(welcomeWidgit);
			
			currentWidgit = welcomeWidgit;
			
			exerciseWidgit.poseWord();
		}
		
		public static function createDefaultTF():TextFormat {
			var tf:TextFormat = new TextFormat();
			tf.font = "GaramondEmbed";
			tf.size = 14;
			//tf.align = TextFormatAlign.CENTER;
			return tf;
		}
		
		public static function swapWidgits(newWidgit:Widgit):void {
			currentWidgit.fadeOut();
			newWidgit.fadeIn();
			currentWidgit = newWidgit;
		}
		
		/*  Useful functions
		========================================*/
		public static function sortRandom(a:*, b:*):Number {
			return Math.random() - Math.random();
		}
		public static function randInt(low:int, high:int):int {
			return Math.floor(Math.random() * (high - low + 1)) + low;
		}
	}
}