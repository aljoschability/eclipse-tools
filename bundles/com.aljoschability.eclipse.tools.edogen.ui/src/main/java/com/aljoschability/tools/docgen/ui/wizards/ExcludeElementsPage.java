package com.aljoschability.tools.docgen.ui.wizards;

import java.lang.reflect.InvocationTargetException;

import org.eclipse.core.runtime.IProgressMonitor;
import org.eclipse.emf.common.notify.Adapter;
import org.eclipse.emf.common.notify.AdapterFactory;
import org.eclipse.emf.common.notify.Notification;
import org.eclipse.emf.common.notify.impl.AdapterImpl;
import org.eclipse.emf.edit.provider.ComposedAdapterFactory;
import org.eclipse.emf.edit.provider.ComposedAdapterFactory.Descriptor.Registry;
import org.eclipse.emf.edit.ui.provider.AdapterFactoryContentProvider;
import org.eclipse.emf.edit.ui.provider.AdapterFactoryLabelProvider;
import org.eclipse.jface.layout.GridDataFactory;
import org.eclipse.jface.layout.GridLayoutFactory;
import org.eclipse.jface.operation.IRunnableWithProgress;
import org.eclipse.jface.viewers.CheckStateChangedEvent;
import org.eclipse.jface.viewers.ICheckStateListener;
import org.eclipse.jface.wizard.WizardPage;
import org.eclipse.swt.SWT;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Tree;
import org.eclipse.ui.PlatformUI;
import org.eclipse.ui.dialogs.ContainerCheckedTreeViewer;

public class ExcludeElementsPage extends WizardPage {
	private ContainerCheckedTreeViewer viewer;
	private boolean initialized;

	protected ExcludeElementsPage() {
		super(ExcludeElementsPage.class.getSimpleName());

		setTitle("Select Elements to Exclude");
	}

	@Override
	public void createControl(Composite parent) {
		Composite composite = new Composite(parent, SWT.NONE);
		GridDataFactory.fillDefaults().grab(true, true).applyTo(composite);
		GridLayoutFactory.fillDefaults().margins(6, 6).applyTo(composite);

		Tree tree = new Tree(composite, SWT.BORDER | SWT.CHECK);
		GridDataFactory.fillDefaults().grab(true, true).applyTo(tree);

		// create adapter factory
		Registry registry = Registry.INSTANCE;
		AdapterFactory af = new ComposedAdapterFactory(registry);

		viewer = new ContainerCheckedTreeViewer(tree);
		viewer.setContentProvider(new AdapterFactoryContentProvider(af));
		viewer.setLabelProvider(new AdapterFactoryLabelProvider(af));

		viewer.setInput(getWizard().getResourceSet());

		addListeners();

		setControl(tree);
	}

	private void addListeners() {
		// listener to check the exclude state
		viewer.addCheckStateListener(new ICheckStateListener() {
			@Override
			public void checkStateChanged(CheckStateChangedEvent event) {
				if (event.getChecked()) {
					getWizard().addExcluded(event.getElement());
				} else {
					getWizard().removeExcluded(event.getElement());
				}
			}
		});

		// listener to hear on resource set changes
		Adapter adapter = new AdapterImpl() {
			@Override
			public void notifyChanged(Notification msg) {
				PlatformUI.getWorkbench().getDisplay().asyncExec(new Runnable() {
					@Override
					public void run() {
						if (viewer != null && !viewer.getControl().isDisposed()) {
							viewer.refresh();
						}
					}
				});
			}
		};

		getWizard().addListener(adapter);
	}

	@Override
	public GenerateDocumentationWizard getWizard() {
		return (GenerateDocumentationWizard) super.getWizard();
	}

	@Override
	public void setVisible(boolean visible) {
		super.setVisible(visible);

		if (visible) {
			if (!initialized) {
				try {
					getContainer().run(true, false, new IRunnableWithProgress() {
						@Override
						public void run(IProgressMonitor monitor) throws InvocationTargetException,
								InterruptedException {
							getWizard().initialize(monitor);
						}
					});
					initialized = true;
				} catch (InvocationTargetException e) {
					e.printStackTrace();
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
		}
	}
}
