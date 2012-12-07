package com.aljoschability.tools.docgen.ui.handlers;

import java.util.Collection;
import java.util.HashSet;

import org.eclipse.core.commands.AbstractHandler;
import org.eclipse.core.commands.ExecutionEvent;
import org.eclipse.core.commands.ExecutionException;
import org.eclipse.core.resources.IFile;
import org.eclipse.jface.viewers.ISelection;
import org.eclipse.jface.viewers.IStructuredSelection;
import org.eclipse.jface.wizard.WizardDialog;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.ui.handlers.HandlerUtil;

import com.aljoschability.tools.docgen.ui.wizards.GenerateDocumentationWizard;

public class GenerateDocumentationHandler extends AbstractHandler {
	@Override
	public Object execute(ExecutionEvent event) throws ExecutionException {
		ISelection selection = HandlerUtil.getCurrentSelection(event);
		if (selection instanceof IStructuredSelection) {
			Collection<IFile> files = new HashSet<IFile>();
			for (Object selected : ((IStructuredSelection) selection).toArray()) {
				if (selected instanceof IFile) {
					files.add((IFile) selected);
				}
			}

			if (!files.isEmpty()) {
				Shell shell = HandlerUtil.getActiveShell(event);
				GenerateDocumentationWizard wizard = new GenerateDocumentationWizard();
				wizard.setFiles(files);

				new WizardDialog(shell, wizard).open();
			}
		}
		return null;
	}
}
