package com.aljoschability.eclipse.tools.madowedi

import com.aljoschability.core.runtime.AbstractCoreActivator
import com.aljoschability.core.runtime.ICoreActivator

class Activator extends AbstractCoreActivator {
	static ICoreActivator INSTANCE

	def static ICoreActivator get() {
		return Activator::INSTANCE
	}

	override protected initialize() {
		Activator::INSTANCE = this
	}

	override protected dispose() {
		Activator::INSTANCE = this
	}
}
