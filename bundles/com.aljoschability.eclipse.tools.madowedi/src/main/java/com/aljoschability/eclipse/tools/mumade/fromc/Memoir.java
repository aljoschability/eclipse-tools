package com.aljoschability.eclipse.tools.mumade.fromc;

import java.util.Collection;

public interface Memoir {
	void print_memoir_node_tree(StringBuilder out, Collection<Node> list, Collection<ScratchPad> scratch);

	void print_memoir_node(StringBuilder out, Collection<Node> n, Collection<ScratchPad> scratch);
}
