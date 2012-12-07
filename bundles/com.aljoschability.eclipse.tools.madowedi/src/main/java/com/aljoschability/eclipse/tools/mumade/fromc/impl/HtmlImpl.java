package com.aljoschability.eclipse.tools.mumade.fromc.impl;

import java.util.Collection;

import com.aljoschability.eclipse.tools.mumade.fromc.Html;
import com.aljoschability.eclipse.tools.mumade.fromc.Node;
import com.aljoschability.eclipse.tools.mumade.fromc.ScratchPad;

public class HtmlImpl implements Html {
	@Override
	public void print_html_node_tree(StringBuilder out, Collection<Node> list, Collection<ScratchPad> scratch) {
		for (Node node : list) {
			print_html_node(out, node, scratch);
		}
	}

	@Override
	public void print_html_node(StringBuilder out, Node n, Collection<ScratchPad> scratch) {
		// TODO Auto-generated method stub

	}

	@Override
	public void print_html_localized_typography(StringBuilder out, int character, Collection<ScratchPad> scratch) {
		// TODO Auto-generated method stub

	}

	@Override
	public void print_html_string(StringBuilder out, String str, Collection<ScratchPad> scratch) {
		// TODO Auto-generated method stub

	}

	@Override
	public void print_html_endnotes(StringBuilder out, Collection<ScratchPad> scratch) {
		// TODO Auto-generated method stub

	}

}
