package com.aljoschability.tools.docgen.ui.wizards;

import org.eclipse.jface.wizard.WizardPage;
import org.eclipse.swt.SWT;
import org.eclipse.swt.widgets.Composite;

/*
 * TODO: not implemented.
 */
class SelectInputPage extends WizardPage {
	protected new() {
		super(typeof(SelectInputPage).simpleName)
	}

	override createControl(Composite parent) {
		val composite = new Composite(parent, SWT::NONE)

		control = composite
	}
}
