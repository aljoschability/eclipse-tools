package com.aljoschability.eclipse.tools.mumade.fromc;

import java.util.Collection;

public interface Html {
	void print_html_node_tree(StringBuilder out, Collection<Node> list, Collection<ScratchPad> scratch);

	void print_html_node(StringBuilder out, Node n, Collection<ScratchPad> scratch);

	void print_html_localized_typography(StringBuilder out, int character, Collection<ScratchPad> scratch);

	void print_html_string(StringBuilder out, String str, Collection<ScratchPad> scratch);

	void print_html_endnotes(StringBuilder out, Collection<ScratchPad> scratch);
}
