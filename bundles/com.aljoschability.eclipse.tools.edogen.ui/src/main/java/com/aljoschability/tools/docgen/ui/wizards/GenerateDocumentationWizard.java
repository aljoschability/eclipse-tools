package com.aljoschability.tools.docgen.ui.wizards;

import java.util.Collection;
import java.util.HashSet;

import org.eclipse.core.resources.IFile;
import org.eclipse.core.runtime.IProgressMonitor;
import org.eclipse.emf.common.notify.Adapter;
import org.eclipse.emf.common.util.URI;
import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.emf.ecore.resource.ResourceSet;
import org.eclipse.emf.ecore.resource.impl.ResourceSetImpl;
import org.eclipse.emf.ecore.util.EcoreUtil;
import org.eclipse.jface.wizard.Wizard;

public class GenerateDocumentationWizard extends Wizard {
	private ResourceSet resourceSet;

	private Collection<IFile> files;
	private Collection<Object> excludes;

	private SelectInputPage inputPage;
	private ConfigurationPage configurationPage;
	private ExcludeElementsPage excludePage;

	public GenerateDocumentationWizard() {
		excludes = new HashSet<Object>();
	}

	public void addListener(Adapter adapter) {
		getResourceSet().eAdapters().add(adapter);
	}

	public void initialize(IProgressMonitor monitor) {
		monitor.beginTask("Loading Resources...", files.size());

		for (IFile file : files) {
			monitor.subTask("Loading '" + file.getName() + "'...");

			URI uri = URI.createPlatformResourceURI(file.getFullPath().toString(), true);

			Resource resource = getResourceSet().getResource(uri, true);
			EcoreUtil.resolveAll(resource);

			monitor.worked(1);
		}

		monitor.done();
	}

	public ResourceSet getResourceSet() {
		if (resourceSet == null) {
			resourceSet = new ResourceSetImpl();
		}
		return resourceSet;
	}

	public void setFiles(Collection<IFile> files) {
		this.files = files;
	}

	@Override
	public void addPages() {
		// add input selection page only if no files are given
		if (files == null || files.isEmpty()) {
			addPage(inputPage = new SelectInputPage());
		}

		// add configuration page
		addPage(configurationPage = new ConfigurationPage());

		// add excluded elements page
		addPage(excludePage = new ExcludeElementsPage());

		// add excluded elements page
		// addPage(excludePage = new ExcludeElementsPage());
	}

	@Override
	public boolean performFinish() {

		System.out.println(files);

		return false;
	}

	public void removeExcluded(Object element) {
		excludes.remove(element);
	}

	public void addExcluded(Object element) {
		excludes.add(element);
	}
}
