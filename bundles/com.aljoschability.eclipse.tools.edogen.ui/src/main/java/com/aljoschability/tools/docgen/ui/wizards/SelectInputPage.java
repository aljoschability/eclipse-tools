package com.aljoschability.tools.docgen.ui.wizards;

import org.eclipse.jface.wizard.WizardPage;
import org.eclipse.swt.SWT;
import org.eclipse.swt.widgets.Composite;

public class SelectInputPage extends WizardPage {
	protected SelectInputPage() {
		super(SelectInputPage.class.getSimpleName());
	}

	@Override
	public void createControl(Composite parent) {
		Composite composite = new Composite(parent, SWT.NONE);
		setControl(composite);
	}
}
