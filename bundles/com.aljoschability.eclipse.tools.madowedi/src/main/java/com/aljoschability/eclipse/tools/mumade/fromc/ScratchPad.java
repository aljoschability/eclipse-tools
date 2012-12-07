package com.aljoschability.eclipse.tools.mumade.fromc;

import java.util.Collection;

public interface ScratchPad {
	int getExtensions();

	int getPadded();

	int getBaseHeaderLevel();

	int getLanguage();

	String getTableAlignment();

	int getTableColumn();

	char getCellType();

	Collection<Node> getNotes();

	Collection<Node> getLinks();

	Collection<Node> getGlossary();

	Collection<Node> getCitations();

	Collection<Node> getUsedNoted();

	int getFootnoteToPrint();

	int getMaxFootnoteNum();

	boolean isObfuscate();

	String getLatexFooter();

	boolean isNoLatexFootnote();

	int getOdfParaType();

	boolean isOdfListNeedsEndP();

	void setExtensions(int i);

	void setPadded(int i);
}
