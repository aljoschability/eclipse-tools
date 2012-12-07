package com.aljoschability.eclipse.tools.mumade;

import com.aljoschability.core.runtime.AbstractCoreActivator;
import com.aljoschability.core.runtime.ICoreActivator;

public class Activator extends AbstractCoreActivator {
	private static ICoreActivator INSTANCE;

	public static ICoreActivator get() {
		return Activator.INSTANCE;
	}

	@Override
	protected void initialize() {
		Activator.INSTANCE = this;
	}

	@Override
	protected void dispose() {
		Activator.INSTANCE = null;
	}
}
