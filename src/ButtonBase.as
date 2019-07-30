package {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	public class ButtonBase extends Sprite {
		protected var isActive:Boolean;
		// An action should be a static function belonging to the relevant class
		protected var action:Function;
		public function ButtonBase(func:Function, active:Boolean = true) {
			action = func;
			isActive = active;
			if (isActive) activate();
		}
		
		/*  Public Functions
		========================================*/
		public function deactivate():void {
			isActive = false;
			this.removeEventListener(MouseEvent.MOUSE_UP, action);
		}
		public function activate():void {
			isActive = true;
			this.addEventListener(MouseEvent.MOUSE_UP, action);
		}
		public function toggle():void {
			if (isActive) deactivate();
			else activate();
		}
		public function isButtonActive():Boolean {    return isActive; }
	}
}