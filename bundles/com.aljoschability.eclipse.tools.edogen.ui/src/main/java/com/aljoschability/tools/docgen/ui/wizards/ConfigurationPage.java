package com.aljoschability.tools.docgen.ui.wizards;

import org.eclipse.jface.layout.GridDataFactory;
import org.eclipse.jface.layout.GridLayoutFactory;
import org.eclipse.jface.wizard.WizardPage;
import org.eclipse.swt.SWT;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.Text;

public class ConfigurationPage extends WizardPage {
	protected ConfigurationPage() {
		super(ConfigurationPage.class.getSimpleName());

		setTitle("Configure the Documentation Generation");
	}

	@Override
	public void createControl(Composite parent) {
		Composite composite = new Composite(parent, SWT.NONE);
		GridDataFactory.fillDefaults().grab(true, true).applyTo(composite);
		GridLayoutFactory.fillDefaults().margins(6, 6).applyTo(composite);

		// title
		Composite titleComposite = new Composite(composite, SWT.NONE);
		GridDataFactory.fillDefaults().grab(true, false).applyTo(titleComposite);
		GridLayoutFactory.fillDefaults().numColumns(2).applyTo(titleComposite);

		Label titleLabel = new Label(titleComposite, SWT.TRAIL);
		GridDataFactory.fillDefaults().align(SWT.FILL, SWT.CENTER).applyTo(titleLabel);
		titleLabel.setText("Title:");

		Text titleText = new Text(titleComposite, SWT.BORDER);
		GridDataFactory.fillDefaults().grab(true, false).applyTo(titleText);
		titleText.setText("Technical Reference");

		// options
		Button showContainments = new Button(composite, SWT.CHECK);
		showContainments.setText("Show Containments");

		Button showAttributes = new Button(composite, SWT.CHECK);
		showAttributes.setText("Show Attributes");

		Button showReferences = new Button(composite, SWT.CHECK);
		showReferences.setText("Show References");

		Button showSubTypes = new Button(composite, SWT.CHECK);
		showSubTypes.setText("Show Sub Types");

		Button showSuperTypes = new Button(composite, SWT.CHECK);
		showSuperTypes.setText("Show Super Types");

		setControl(composite);
	}
}
