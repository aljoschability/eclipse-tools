package com.aljoschability.tools.docgen.ui.handlers;

import com.aljoschability.tools.docgen.ui.wizards.GenerateDocumentationWizard
import java.util.Collection
import org.eclipse.core.commands.AbstractHandler
import org.eclipse.core.commands.ExecutionEvent
import org.eclipse.core.commands.ExecutionException
import org.eclipse.core.resources.IFile
import org.eclipse.jface.viewers.IStructuredSelection
import org.eclipse.jface.wizard.WizardDialog
import org.eclipse.ui.handlers.HandlerUtil

class GenerateDocumentationHandler extends AbstractHandler {
	override execute(ExecutionEvent event) throws ExecutionException {
		val selection = HandlerUtil.getCurrentSelection(event)

		if (selection instanceof IStructuredSelection) {
			val Collection<IFile> files = newLinkedHashSet
			for (Object selected : selection.toArray()) {
				if (selected instanceof IFile) {
					files += selected
				}
			}

			if (!files.empty) {
				val shell = HandlerUtil.getActiveShell(event)
				val wizard = new GenerateDocumentationWizard()
				wizard.files = files

				new WizardDialog(shell, wizard).open()
			}
		}

		return null
	}
}
