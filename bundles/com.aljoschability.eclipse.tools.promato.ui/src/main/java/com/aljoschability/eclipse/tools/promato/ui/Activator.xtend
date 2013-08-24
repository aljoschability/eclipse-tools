package com.aljoschability.eclipse.tools.promato.ui;

import com.aljoschability.core.ui.runtime.AbstractActivator
import com.aljoschability.core.ui.runtime.IActivator

final public class Activator extends AbstractActivator {
	static IActivator INSTANCE

	def static IActivator get() {
		Activator::INSTANCE
	}

	override void initialize() {
		Activator::INSTANCE = this

		// add images
		addImage(PromatoImages.HEADER);
	}

	override void dispose() {
		Activator::INSTANCE = null
	}
}
