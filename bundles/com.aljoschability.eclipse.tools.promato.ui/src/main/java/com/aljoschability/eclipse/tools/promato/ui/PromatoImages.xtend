package com.aljoschability.eclipse.tools.promato.ui;

import org.eclipse.swt.graphics.Image;

class PromatoImages {
	public static val HEADER = "icons/header.png"

	static def Image getImage(String key) {
		return Activator::get().getImage(key)
	}
}
