<?php
class DisplayWidget extends Widget {
	public function render($data) {
		$Widget = M ( "Widget" )->where ( $data )->find ();
		if (! empty ( $Widget )) {
			$content = W ( $Widget ["name"], $Widget, true );
		}
		return $content;
	}

}
