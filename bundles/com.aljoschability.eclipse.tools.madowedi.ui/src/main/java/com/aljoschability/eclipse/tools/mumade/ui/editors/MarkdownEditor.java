package com.aljoschability.eclipse.tools.mumade.ui.editors;

import org.eclipse.ui.editors.text.TextEditor;
import org.eclipse.ui.editors.text.TextFileDocumentProvider;

public class MarkdownEditor extends TextEditor {
	public MarkdownEditor() {
		setDocumentProvider(new TextFileDocumentProvider());
	}
}
