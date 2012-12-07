package com.aljoschability.eclipse.tools.mumade.fromc;

import java.util.Collection;

public interface Critic {
	void print_critic_accept_node_tree(StringBuilder out, Collection<Node> list, Collection<ScratchPad> scratch);

	void print_critic_reject_node_tree(StringBuilder out, Collection<Node> list, Collection<ScratchPad> scratch);

	void print_critic_html_highlight_node_tree(StringBuilder out, Collection<Node> list, Collection<ScratchPad> scratch);

	void print_critic_accept_node(StringBuilder out, Collection<Node> list, Collection<ScratchPad> scratch);

	void print_critic_reject_node(StringBuilder out, Collection<Node> list, Collection<ScratchPad> scratch);

	void print_critic_html_highlight_node(StringBuilder out, Collection<Node> list, Collection<ScratchPad> scratch);
}
