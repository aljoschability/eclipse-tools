package com.aljoschability.eclipse.tools.bumauni

import com.aljoschability.core.runtime.AbstractCoreActivator
import com.aljoschability.core.runtime.ICoreActivator

class Activator extends AbstractCoreActivator {
	static ICoreActivator INSTANCE

	static def get() {
		return Activator::INSTANCE
	}

	override initialize() {
		Activator::INSTANCE = this
	}

	override dispose() {
		Activator::INSTANCE = null
	}
}
