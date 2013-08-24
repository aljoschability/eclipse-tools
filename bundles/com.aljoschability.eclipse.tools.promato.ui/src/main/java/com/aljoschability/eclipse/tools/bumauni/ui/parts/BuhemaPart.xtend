package com.aljoschability.eclipse.tools.bumauni.ui.parts

import com.aljoschability.eclipse.tools.buhorg.ManifestParser
import java.util.Set
import javax.annotation.PostConstruct
import javax.annotation.PreDestroy
import javax.inject.Inject
import javax.inject.Named
import org.eclipse.core.resources.IFile
import org.eclipse.core.resources.IProject
import org.eclipse.core.resources.IResource
import org.eclipse.core.runtime.IAdaptable
import org.eclipse.e4.core.di.annotations.Optional
import org.eclipse.e4.ui.services.IServiceConstants
import org.eclipse.jface.layout.GridDataFactory
import org.eclipse.jface.layout.GridLayoutFactory
import org.eclipse.jface.viewers.ArrayContentProvider
import org.eclipse.jface.viewers.IStructuredSelection
import org.eclipse.jface.viewers.ITreeContentProvider
import org.eclipse.jface.viewers.LabelProvider
import org.eclipse.jface.viewers.TreeViewer
import org.eclipse.swt.SWT
import org.eclipse.swt.widgets.Composite
import org.eclipse.swt.widgets.Tree

class ManifestTreeContentProvider extends ArrayContentProvider implements ITreeContentProvider {
	override getChildren(Object element) {
		return getElements(element)
	}

	override getParent(Object element) {
	}

	override hasChildren(Object element) {
		return !getChildren(element).empty
	}
}

class BuhemaPart {
	@PostConstruct def createControls(Composite parent) {
		val composite = new Composite(parent, SWT::NONE);
		GridDataFactory::fillDefaults.grab(true, true).applyTo(composite)
		GridLayoutFactory::fillDefaults.applyTo(composite)

		createProjectPart(composite)

		createSomething(composite)

		initialize()
	}

	def private createProjectPart(Composite parent) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	def private createSomething(Composite parent) {
		val tree = new Tree(parent, SWT::BORDER)
		GridDataFactory::fillDefaults.grab(true, true).applyTo(tree)

		viewer = new TreeViewer(tree)
		viewer.labelProvider = new LabelProvider
		viewer.contentProvider = new ManifestTreeContentProvider
	}

	def private initialize() {
	}

	@PreDestroy def dispose() {
	}

	val reader = new ManifestParser

	TreeViewer viewer

	@Inject def handleSelection(@Optional @Named(IServiceConstants::ACTIVE_SELECTION) IStructuredSelection selection) {
		if (selection != null && !selection.empty) {
			val projects = collectProjects(selection)

			val mfs = newArrayList
			for (project : projects) {
				val m = project.findMember("META-INF/MANIFEST.MF")
				if (m instanceof IFile) {
					mfs += reader.read(m.rawLocation.toFile)
				}
			}

			viewer.input = mfs
		}
	}

	private def Set<IProject> collectProjects(IStructuredSelection selection) {
		val projects = newLinkedHashSet
		val it = selection.iterator
		while (it.hasNext) {
			val selected = it.next

			if (selected instanceof IAdaptable) {
				val adapted = selected.getAdapter(typeof(IResource)) as IResource

				if (adapted != null) {
					projects += adapted.project
				}
			} else {
				println(selected)
			}
		}
		return projects
	}

}
