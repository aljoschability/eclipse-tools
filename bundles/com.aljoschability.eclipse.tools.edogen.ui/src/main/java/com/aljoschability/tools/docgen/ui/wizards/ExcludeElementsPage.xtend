package com.aljoschability.tools.docgen.ui.wizards

import java.lang.reflect.InvocationTargetException
import org.eclipse.emf.common.notify.Notification
import org.eclipse.emf.common.notify.impl.AdapterImpl
import org.eclipse.emf.edit.provider.ComposedAdapterFactory
import org.eclipse.emf.edit.provider.ComposedAdapterFactory.Descriptor.Registry
import org.eclipse.emf.edit.ui.provider.AdapterFactoryContentProvider
import org.eclipse.emf.edit.ui.provider.AdapterFactoryLabelProvider
import org.eclipse.jface.layout.GridDataFactory
import org.eclipse.jface.layout.GridLayoutFactory
import org.eclipse.jface.wizard.WizardPage
import org.eclipse.swt.SWT
import org.eclipse.swt.widgets.Composite
import org.eclipse.swt.widgets.Tree
import org.eclipse.ui.PlatformUI
import org.eclipse.ui.dialogs.ContainerCheckedTreeViewer

class ExcludeElementsPage extends WizardPage {
	boolean initialized

	ContainerCheckedTreeViewer viewer

	protected new() {
		super(typeof(ExcludeElementsPage).simpleName)

		title = "Select Elements to Exclude"
	}

	override createControl(Composite parent) {
		val composite = new Composite(parent, SWT::NONE)
		composite.layoutData = GridDataFactory.fillDefaults().grab(true, true).create
		composite.layout = GridLayoutFactory.fillDefaults().margins(6, 6).create

		val tree = new Tree(composite, SWT::BORDER.bitwiseOr(SWT::CHECK))
		tree.layoutData = GridDataFactory.fillDefaults().grab(true, true).create

		// create adapter factory
		val registry = Registry::INSTANCE
		val af = new ComposedAdapterFactory(registry)

		viewer = new ContainerCheckedTreeViewer(tree)
		viewer.contentProvider = new AdapterFactoryContentProvider(af)
		viewer.labelProvider = new AdapterFactoryLabelProvider(af)

		viewer.input = wizard.resourceSet

		addListeners()

		control = tree
	}

	def private void addListeners() {

		// listener to check the exclude state
		viewer.addCheckStateListener(
			[event|
				if (event.getChecked()) {
					getWizard().addExcluded(event.getElement())
				} else {
					getWizard().removeExcluded(event.getElement())
				}])

		// listener to hear on resource set changes
		val adapter = new AdapterImpl() {
			override notifyChanged(Notification msg) {
				PlatformUI::workbench.display.asyncExec(
					[ |
						if (viewer != null && !viewer.getControl().isDisposed()) {
							viewer.refresh()
						}
					])
			}
		}

		wizard.addListener(adapter)
	}

	override GenerateDocumentationWizard getWizard() {
		return super.wizard as GenerateDocumentationWizard
	}

	override setVisible(boolean visible) {
		super.setVisible(visible)

		if (visible) {
			if (!initialized) {
				try {
					container.run(true, false,
						[ monitor |
							wizard.initialize(monitor)
						])
					initialized = true
				} catch (InvocationTargetException e) {
					e.printStackTrace()
				} catch (InterruptedException e) {
					e.printStackTrace()
				}
			}
		}
	}
}
