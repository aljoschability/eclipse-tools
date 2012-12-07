package com.aljoschability.eclipse.tools.mumade.fromc.impl;

import java.util.Collection;

import com.aljoschability.eclipse.tools.mumade.fromc.Node;
import com.aljoschability.eclipse.tools.mumade.fromc.ScratchPad;
import com.aljoschability.eclipse.tools.mumade.fromc.Text;

public class TextImpl implements Text {
	@Override
	public void print_text_node_tree(StringBuilder out, Collection<Node> list, Collection<ScratchPad> scratch) {
		for (Node node : list) {
			print_text_node(out, node, scratch);
		}
	}

	@Override
	public void print_text_node(StringBuilder out, Node n, Collection<ScratchPad> scratch) {
		switch (n.getKey()) {
		case STR:
			out.append(n.getValue());
			break;
		case METADATA:
			print_text_node_tree(out, n.getChildren(), scratch);
			break;
		case METAKEY:
			out.append(n.getValue());
			out.append(':');
			out.append('\t');
			// TODO: print_text_node(out,n->children,scratch);
			break;
		case METAVALUE:
			// TODO: g_string_append_printf(out,"%s",n->str);
			// TODO: pad(out,1, scratch);
			break;
		default:
			System.err.println("enum not supported");
			break;
		}
	}
}
