package com.aljoschability.eclipse.tools.mumade.fromc;

import java.util.Collection;

public interface Latex {
	void print_latex_node_tree(StringBuilder out, Collection<Node> list, Collection<ScratchPad> scratch);

	void print_latex_node(StringBuilder out, Collection<Node> n, Collection<ScratchPad> scratch);

	void print_latex_localized_typography(StringBuilder out, int character, Collection<ScratchPad> scratch);

	void print_latex_string(StringBuilder out, String str, Collection<ScratchPad> scratch);

	void print_latex_url(StringBuilder out, String str, Collection<ScratchPad> scratch);

	void print_latex_endnotes(StringBuilder out, Collection<ScratchPad> scratch);

	int find_latex_mode(int format, Collection<Node> n);
}
