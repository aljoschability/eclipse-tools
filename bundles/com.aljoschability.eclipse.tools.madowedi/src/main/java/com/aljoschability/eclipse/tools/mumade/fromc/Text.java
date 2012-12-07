package com.aljoschability.eclipse.tools.mumade.fromc;

import java.util.Collection;

public interface Text {
	void print_text_node_tree(StringBuilder out, Collection<Node> list, Collection<ScratchPad> scratch);

	void print_text_node(StringBuilder out, Node n, Collection<ScratchPad> scratch);
}
