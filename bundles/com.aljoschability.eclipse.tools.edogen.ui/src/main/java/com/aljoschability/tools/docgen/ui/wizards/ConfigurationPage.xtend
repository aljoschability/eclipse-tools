package com.aljoschability.tools.docgen.ui.wizards

import org.eclipse.jface.layout.GridDataFactory
import org.eclipse.jface.layout.GridLayoutFactory
import org.eclipse.jface.wizard.WizardPage
import org.eclipse.swt.SWT
import org.eclipse.swt.widgets.Button
import org.eclipse.swt.widgets.Composite
import org.eclipse.swt.widgets.Label
import org.eclipse.swt.widgets.Text

class ConfigurationPage extends WizardPage {
	protected new() {
		super(typeof(ConfigurationPage).simpleName)

		title = "Configure the Documentation Generation"
	}

	override createControl(Composite parent) {
		val composite = new Composite(parent, SWT::NONE)
		composite.layoutData = GridDataFactory.fillDefaults().grab(true, true).create
		composite.layout = GridLayoutFactory.fillDefaults().margins(6, 6).create

		// title
		val titleComposite = new Composite(composite, SWT::NONE)
		titleComposite.layoutData = GridDataFactory.fillDefaults().grab(true, false).create
		titleComposite.layout = GridLayoutFactory.fillDefaults().numColumns(2).create

		val titleLabel = new Label(titleComposite, SWT::TRAIL)
		titleLabel.layoutData = GridDataFactory.fillDefaults().align(SWT::FILL, SWT::CENTER).create
		titleLabel.text = "Title:"

		val titleText = new Text(titleComposite, SWT::BORDER)
		titleText.layoutData = GridDataFactory.fillDefaults().grab(true, false).create
		titleText.text = "Technical Reference"

		// options
		val showContainments = new Button(composite, SWT::CHECK)
		showContainments.text = "Show Containments"

		val showAttributes = new Button(composite, SWT::CHECK)
		showAttributes.text = "Show Attributes"

		val showReferences = new Button(composite, SWT::CHECK)
		showReferences.text = "Show References"

		val showSubTypes = new Button(composite, SWT::CHECK)
		showSubTypes.text = "Show Sub Types"

		val showSuperTypes = new Button(composite, SWT::CHECK)
		showSuperTypes.text = "Show Super Types"

		control = composite
	}
}
