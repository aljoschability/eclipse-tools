package com.aljoschability.eclipse.tools.mumade.fromc;

import java.util.Collection;

public interface Beamer {
	void print_beamer_node_tree(StringBuilder out, Collection<Node> list, Collection<ScratchPad> scratch);

	void print_beamer_node(StringBuilder out, Node n, Collection<ScratchPad> scratch);

	void print_beamer_endnotes(StringBuilder out, Collection<ScratchPad> scratch);
}
