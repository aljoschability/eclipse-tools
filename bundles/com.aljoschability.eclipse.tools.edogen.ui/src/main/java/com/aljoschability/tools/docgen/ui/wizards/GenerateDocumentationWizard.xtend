package com.aljoschability.tools.docgen.ui.wizards

import java.util.Collection
import org.eclipse.core.resources.IFile
import org.eclipse.core.runtime.IProgressMonitor
import org.eclipse.emf.common.notify.Adapter
import org.eclipse.emf.common.util.URI
import org.eclipse.emf.ecore.resource.ResourceSet
import org.eclipse.emf.ecore.resource.impl.ResourceSetImpl
import org.eclipse.emf.ecore.util.EcoreUtil
import org.eclipse.jface.wizard.Wizard

class GenerateDocumentationWizard extends Wizard {
	ResourceSet resourceSet

	Collection<IFile> files
	Collection<Object> excludes

	SelectInputPage inputPage
	ConfigurationPage configurationPage
	ExcludeElementsPage excludePage

	new() {
		excludes = newLinkedHashSet
	}

	def void addListener(Adapter adapter) {
		resourceSet.eAdapters += adapter
	}

	def void initialize(IProgressMonitor monitor) {
		monitor.beginTask("Loading Resources...", files.size)

		for (IFile file : files) {
			monitor.subTask('''Loading "«file.name»"...''')

			val uri = URI.createPlatformResourceURI(file.fullPath.toString, true)

			val resource = getResourceSet().getResource(uri, true)
			EcoreUtil::resolveAll(resource)

			monitor.worked(1)
		}

		monitor.done
	}

	def ResourceSet getResourceSet() {
		if (resourceSet == null) {
			resourceSet = new ResourceSetImpl()
		}
		return resourceSet
	}

	def void setFiles(Collection<IFile> files) {
		this.files = files
	}

	override addPages() {

		// add input selection page only if no files are given
		if (files == null || files.isEmpty()) {
			addPage(inputPage = new SelectInputPage())
		}

		// add configuration page
		addPage(configurationPage = new ConfigurationPage())

		// add excluded elements page
		addPage(excludePage = new ExcludeElementsPage())

	// add excluded elements page
	// addPage(excludePage = new ExcludeElementsPage())
	}

	override performFinish() {
		println(files)

		return false
	}

	def void removeExcluded(Object element) {
		excludes += element
	}

	def void addExcluded(Object element) {
		excludes += element
	}
}
