package com.aljoschability.tools.docgen.ui;

import com.aljoschability.core.runtime.AbstractCoreActivator
import com.aljoschability.core.runtime.ICoreActivator

public class Activator extends AbstractCoreActivator {
	static ICoreActivator INSTANCE

	override protected initialize() {
		Activator::INSTANCE = this
	}

	override protected dispose() {
		Activator::INSTANCE = null
	}

	def get() {
		return Activator::INSTANCE
	}
}
