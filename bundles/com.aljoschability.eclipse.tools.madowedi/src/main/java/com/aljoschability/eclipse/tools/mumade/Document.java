package com.aljoschability.eclipse.tools.mumade;

import java.util.List;

public interface Document {
	QuotationMark getLanguage();
	List<Node> getNodes();
}
