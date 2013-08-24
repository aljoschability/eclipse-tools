package com.aljoschability.eclipse.tools.bumauni.ui;

import org.eclipse.swt.graphics.Image;

class Images {
	public static val UP = "icons/up.png"
	public static val DOWN = "icons/down.png"
	public static val HEADER = "icons/header.png"

	static def Image getImage(String key) {
		return Activator::get().getImage(key)
	}
}
