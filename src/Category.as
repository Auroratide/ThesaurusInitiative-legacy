package {
	public class Category {
		private var pilot:String;
		private var words:Vector.<String>;
		public function Category(str:String) {
			var a:Array = str.split(":");
			pilot = a[0];
			words = Vector.<String>(a[1].split(","));
		}
		
		public function pilotWord():String {    return pilot; }
		public function wordList():Vector.<String> {    return words; }
		
		public function randomWord():String {
			return words[Main.randInt(0, words.length - 1)];
		}
	}
}