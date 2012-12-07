package com.aljoschability.eclipse.tools.mumade.ui.views;

import org.eclipse.jface.layout.GridDataFactory;
import org.eclipse.jface.text.DocumentEvent;
import org.eclipse.jface.text.IDocument;
import org.eclipse.jface.text.IDocumentListener;
import org.eclipse.swt.SWT;
import org.eclipse.swt.browser.Browser;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.ui.IMemento;
import org.eclipse.ui.IPartListener;
import org.eclipse.ui.IViewSite;
import org.eclipse.ui.IWorkbenchPart;
import org.eclipse.ui.PartInitException;
import org.eclipse.ui.part.ViewPart;
import org.eclipse.ui.texteditor.IDocumentProvider;

import com.aljoschability.core.ui.PartAdapter;
import com.aljoschability.eclipse.tools.mumade.impl.ParserImpl;
import com.aljoschability.eclipse.tools.mumade.ui.editors.MarkdownEditor;

public class PreviewPart extends ViewPart {
	public class EditorDocumentListener implements IDocumentListener {
		@Override
		public void documentChanged(DocumentEvent event) {
			String text = new ParserImpl().test(event.getDocument().get());
			browser.setText(text);
		}

		@Override
		public void documentAboutToBeChanged(DocumentEvent event) {
			// nothing
		}
	}

	public class EditorPartListener extends PartAdapter {
		@Override
		public void partActivated(IWorkbenchPart part) {
			if (part instanceof MarkdownEditor) {
				setContent((MarkdownEditor) part);
			}
		}

		@Override
		public void partClosed(IWorkbenchPart part) {
			if (part instanceof MarkdownEditor) {
				if (part.equals(activeEditor)) {
					setContent(null);
				}
			}
		}
	}

	private MarkdownEditor activeEditor;

	private IPartListener partListener;
	private EditorDocumentListener documentListener;

	private Browser browser;

	public PreviewPart() {
		partListener = new EditorPartListener();
		documentListener = new EditorDocumentListener();
	}

	private void setContent(MarkdownEditor editor) {
		// remove listener from editor
		if (activeEditor != null) {
			IDocumentProvider provider = activeEditor.getDocumentProvider();
			IDocument document = provider.getDocument(activeEditor.getEditorInput());
			document.removeDocumentListener(documentListener);
		}

		activeEditor = editor;

		if (activeEditor != null) {
			IDocumentProvider provider = activeEditor.getDocumentProvider();
			IDocument document = provider.getDocument(activeEditor.getEditorInput());
			document.addDocumentListener(documentListener);
			document.set(document.get());
		} else {
			browser.setText("");
		}
	}

	@Override
	public void init(IViewSite site, IMemento memento) throws PartInitException {
		super.init(site, memento);

		getSite().getWorkbenchWindow().getPartService().addPartListener(partListener);
	}

	@Override
	public void dispose() {
		getSite().getWorkbenchWindow().getPartService().removePartListener(partListener);

		super.dispose();
	}

	@Override
	public void createPartControl(Composite parent) {
		browser = new Browser(parent, SWT.NONE);
		GridDataFactory.fillDefaults().grab(true, true).applyTo(browser);
	}

	@Override
	public void setFocus() {
		if (browser != null && !browser.isDisposed()) {
			browser.setFocus();
		}
	}
}
