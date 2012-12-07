package com.aljoschability.eclipse.tools.mumade.fromc.impl;

import java.util.Collection;

import com.aljoschability.eclipse.tools.mumade.fromc.Beamer;
import com.aljoschability.eclipse.tools.mumade.fromc.Node;
import com.aljoschability.eclipse.tools.mumade.fromc.ScratchPad;

public class BeamerImpl implements Beamer {
	@Override
	public void print_beamer_node_tree(StringBuilder out, Collection<Node> list, Collection<ScratchPad> scratch) {
		for (Node node : list) {
			print_beamer_node(out, node, scratch);
		}
	}

	public void print_beamer_node(StringBuilder out, Node n, ScratchPad scratch) {
		// int lev;
		// String temp;
		//
		// /* If we are forcing a complete document, and METADATA isn't the first thing,
		// we need to close <head> */
		// if (((scratch.getExtensions() & Parser.EXT_COMPLETE)==1)
		// && !((scratch.getExtensions() & Parser.EXT_HEAD_CLOSED)==1) &&
		// !((n.getKey() == Key.FOOTER) || (n.getKey() == Key.METADATA))) {
		// pad(out, 2, scratch);
		// scratch.setExtensions(scratch.getExtensions() | Parser.EXT_HEAD_CLOSED);
		// }
		// switch (n.getKey()) {
		// case FOOTER:
		// print_beamer_endnotes(out, scratch);
		// out.append("\\mode<all>\n");
		// if (scratch.getLatexFooter() != null) {
		// pad(out, 2, scratch);
		// out.append("\\input{");
		// out.append(scratch.getLatexFooter());
		// out.append("}\n");
		// }
		// if ((scratch.getExtensions() & Parser.EXT_COMPLETE)==1) {
		// out.append("\n\\end{document}");
		// }
		// out.append("\\mode*\n");
		// break;
		// case LISTITEM:
		// pad(out, 1, scratch);
		// out.append("\\item<+-> ");
		// scratch.setPadded(2);
		// print_latex_node_tree(out, n.getChildren(), scratch);
		// out.append("\n");
		// break;
		// case HEADINGSECTION:
		// if (n.getChildren()->key -H1 + scratch.getBaseHeaderLevel() == 3) {
		// pad(out, 2, scratch);
		// g_string_append_printf(out, "\\begin{frame}");
		// /* TODO: Fix this */
		// if (tree_contains_key(n->children,VERBATIM)) {
		// g_string_append_printf(out, "[fragile]");
		// }
		// scratch->padded = 0;
		// print_beamer_node_tree(out, n->children, scratch);
		// g_string_append_printf(out, "\n\n\\end{frame}\n\n");
		// scratch->padded = 2;
		// } else if (n->children->key -H1 + scratch->baseheaderlevel == 4) {
		// pad(out, 1, scratch);
		// g_string_append_printf(out, "\\mode<article>{\n");
		// scratch->padded = 0;
		// print_beamer_node_tree(out, n->children->next, scratch);
		// g_string_append_printf(out, "\n\n}\n\n");
		// scratch->padded = 2;
		// } else {
		// print_beamer_node_tree(out, n->children, scratch);
		// }
		// break;
		// case H1: case H2: case H3: case H4: case H5: case H6:
		// pad(out, 2, scratch);
		// lev = n->key - H1 + scratch->baseheaderlevel; /* assumes H1 ... H6 are in order */
		// switch (lev) {
		// case 1:
		// g_string_append_printf(out, "\\part{");
		// break;
		// case 2:
		// g_string_append_printf(out, "\\section{");
		// break;
		// case 3:
		// g_string_append_printf(out, "\\frametitle{");
		// break;
		// default:
		// g_string_append_printf(out, "\\emph{");
		// break;
		// }
		// /* generate a label for each header (MMD);
		// don't allow footnotes since invalid here */
		// scratch->no_latex_footnote = TRUE;
		// if (n->children->key == AUTOLABEL) {
		// temp = label_from_string(n->children->str);
		// print_latex_node_tree(out, n->children->next, scratch);
		// g_string_append_printf(out, "}\n\\label{%s}", temp);
		// free(temp);
		// } else {
		// print_latex_node_tree(out, n->children, scratch);
		// temp = label_from_node_tree(n->children);
		// g_string_append_printf(out, "}\n\\label{%s}", temp);
		// free(temp);
		// }
		// scratch->no_latex_footnote = FALSE;
		// scratch->padded = 0;
		// break;
		// default:
		// /* most things are not changed for memoir output */
		// print_latex_node(out, n, scratch);
		// }
	}

	@Override
	public void print_beamer_endnotes(StringBuilder out, Collection<ScratchPad> scratch) {
		// TODO Auto-generated method stub

	}

	@Override
	public void print_beamer_node(StringBuilder out, Node n, Collection<ScratchPad> scratch) {
		// TODO Auto-generated method stub

	}
}
