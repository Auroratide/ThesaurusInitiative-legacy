package {
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	public class FileManager {
		public static const START_CATEGORY:uint = 62; // '>'
		public static const END_CATEGORY:uint = 59; // ';'
		public static const LIST_BEGIN:uint = 58; // ':'
		public static const WORD_SEPARATOR:uint = 44; // ','
		public static const DEFAULT_FILE_NAME:String = "Default_Dictionary";
		public static const FILE_WORDS:int = 1;
		public static const FILE_PREFERENCES:int = 2;
		private var home:File;
		private var wordsFile:File;
		private var prefsFile:File;
		private var numOfCategories:int;
		private var stream:FileStream;
		
		public function FileManager() {
			home = File.applicationStorageDirectory;
			prefsFile = home.resolvePath("preferences.txt");
			stream = new FileStream();
			if (!prefsFile.exists) createPrefFile();
			
			wordsFile = home.resolvePath("data/" + wordsFileName() + ".txt");
			confirmWordsFile();
			numOfCategories = countCategoriesInFile();
		}
		
		public function numberOfCategories():int {    return numOfCategories; }
		public function getFile(fileType:int):File {
			if (fileType == FILE_PREFERENCES)
				return prefsFile;
			return wordsFile;
		}
		public function openFile(file:File, openMode:String = FileMode.READ):void {
			try {
				stream.open(file, openMode);
			}
			catch (err:Error) {
				trace("ERROR in FileManager openFile: " + err.message);
			}
		}
		public function closeFile():void {
			stream.close();
		}
		
		// Retreives the nth category, indexed at 0
		public function getCategory(n:int):String {
			try{
				stream.open(wordsFile, FileMode.READ);
				var str:String = "";
				var currentCat:int = -1;
				while (n > currentCat) {
					while (stream.readUnsignedByte() != START_CATEGORY) { }
					++currentCat;
				}
				var b:uint = stream.readUnsignedByte();
				while (b != END_CATEGORY) {
					str += String.fromCharCode(b);
					b = stream.readUnsignedByte();
				}
				stream.close();
				return str;
			}
			catch (err:Error) {
				trace("ERROR in FileManager getCategory: End of File");
			}
			return "";
		}
		
		private function countCategoriesInFile():int {
			stream.open(wordsFile, FileMode.READ);
			var count:int = 0;
			while (stream.bytesAvailable > 1) {
				if (stream.readUnsignedByte() == START_CATEGORY) ++count;
			}
			stream.close();
			return count;
		}
		
		public static function stripSpaces(text:String):String {
			var i:int = 0;
			while (i < text.length) {
				if (text.charAt(i) == "," && i < text.length && text.charAt(i + 1) == " ")
					text = text.substring(0, i + 1) + text.substring(i + 2);
				++i;
			}
			return text;
		}
		
		public function writeWord(pilot:String, words:String):Boolean {
			/*
			try {
				stream.open(wordsFile, FileMode.APPEND);
				stream.writeByte(START_CATEGORY);
				for (var i:int = 0; i < pilot.length; ++i) {
					stream.writeByte(pilot.charCodeAt(i));
				}
				stream.writeByte(LIST_BEGIN);
				words = stripSpaces(words);
				for (var j:int = 0; j < words.length; ++j) {
					stream.writeByte(words.charCodeAt(j));
				}
				stream.writeByte(END_CATEGORY);
				stream.close();
				return true;
			}
			catch (err:Error) {
				trace("ERROR in FileManager writeWord: Unknown");
			}
			return false;
			/*  */
			words = stripSpaces(words);
			return writeParam(wordsFile, pilot, words);
		}
		
		public function wordsFileName():String {
			try{
				stream.open(prefsFile, FileMode.READ);
				var cumStr:String = "";
				var target:String = ">file:";
				while (cumStr != target && stream.bytesAvailable > 0) {
					cumStr += String.fromCharCode(stream.readUnsignedByte());
					if (cumStr.charAt(cumStr.length - 1) != target.charAt(cumStr.length - 1))
						cumStr = "";
				}
				if (cumStr != target) {
					stream.close();
					throw new FileCorruptionError();
				}
				var b:uint = stream.readUnsignedByte();
				cumStr = ""; // recycling
				while (b != END_CATEGORY && stream.bytesAvailable > 0) {
					cumStr += String.fromCharCode(b);
					b = stream.readUnsignedByte();
				}
				stream.close();
				return cumStr;
			}
			catch (fileErr:FileCorruptionError) {
				trace("ERROR in FileManager wordsFileName: No File parameter");
				createPrefFile();
			}
			catch (err:Error) {
				trace("ERROR in FileManager wordsFileName: Unknown error");
			}
			return DEFAULT_FILE_NAME;
		}
		
		private function createPrefFile():void {
			if (prefsFile.exists) prefsFile.deleteFile();
			stream.open(prefsFile, FileMode.WRITE);
			stream.writeMultiByte(String.fromCharCode(START_CATEGORY) + "file" + String.fromCharCode(LIST_BEGIN) + DEFAULT_FILE_NAME + String.fromCharCode(END_CATEGORY), Main.CHARSET);
			stream.close();
			var temp:File = home.resolvePath("data/" + DEFAULT_FILE_NAME + ".txt");
			if (!temp.exists) {
				stream.open(temp, FileMode.WRITE);
				stream.writeMultiByte(DefaultDictionary.DICTIONARY, Main.CHARSET);
				stream.close();
			}
		}
		
		/*  The Steps:
			 * Read into a ByteArray (ba1)
			 * Find the starting and ending positions of the param
				* If the param doesn't exist, begin becomes the end of file, and end becomes -1
			 * Read everything after end of ba1 into a second ByteArray (ba2)
			 * Write data into ba1 starting at begin
			 * Write ba2 into ba1
			 * Write ba1 into the file
			 * Return true if successful
		* */
		public function writeParam(file:File, param:String, data:String):Boolean {
			try{
				var ba1:ByteArray = new ByteArray();
				if (!file.exists) {
					trace("ERROR in FileManager writeParam: File does not exist");
					return false;
				}
				stream.open(file, FileMode.UPDATE);
				var begin:Number = findParam(file, param);
				var end:Number = begin;
				if(end >= 0){
					while (stream.readByte() != END_CATEGORY && stream.bytesAvailable > 0) ++end;
					++end;
				}
				stream.position = 0;
				stream.readBytes(ba1);
				if (begin < 0) begin = stream.position;
				var ba2:ByteArray = new ByteArray();
				if (end >= 0) {
					stream.position = end;
					stream.readBytes(ba2);
				}
				ba1.position = begin;
				if (end < 0)
					ba1.writeMultiByte(String.fromCharCode(START_CATEGORY) + param + String.fromCharCode(LIST_BEGIN), Main.CHARSET);
				ba1.writeMultiByte(data + String.fromCharCode(END_CATEGORY), Main.CHARSET);
				ba1.writeBytes(ba2);
				stream.position = 0;
				stream.truncate();
				stream.writeBytes(ba1, 0, ba1.position);
				stream.close();
				return true;
			}
			catch (err:Error) {
				trace("ERROR in FileManager writeParam: " + err.message);
			}
			return false;
		}
		
		// Assumes file is already open
		public function findParam(file:File, param:String):Number {
			stream.position = 0;
			var cumStr:String = "";
			var target:String = String.fromCharCode(START_CATEGORY) + param + String.fromCharCode(LIST_BEGIN);
			while (cumStr != target && stream.bytesAvailable > 0) {
				cumStr += String.fromCharCode(stream.readUnsignedByte());
				if (cumStr.charAt(cumStr.length - 1) != target.charAt(cumStr.length - 1))
					cumStr = "";
			}
			if (cumStr != target)
				return -1;
			return stream.position;
		}
		
		public function reInit():void {
			wordsFile = home.resolvePath("data/" + wordsFileName() + ".txt");
			confirmWordsFile();
			numOfCategories = countCategoriesInFile();
			Main.exerciseWidgit.createCategories();
			Main.exerciseWidgit.poseWord();
		}
		
		public function confirmWordsFile():void {
			if (!wordsFile.exists) {
				stream.open(wordsFile, FileMode.WRITE);
				stream.close();
			}
		}
	}
}