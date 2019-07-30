package {
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	public class InputField extends TextField {
		private var tf:TextFormat;
		public function InputField() {
			tf = Main.createDefaultTF();
			this.type = TextFieldType.INPUT;
			this.embedFonts = true;
			tf.size = 16;
			this.defaultTextFormat = tf;
			this.border = true;
			this.borderColor = 0x777777;
		}
	}
}