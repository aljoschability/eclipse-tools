package com.aljoschability.eclipse.tools.mumade.fromc;

import java.util.Collection;

public interface Writer {
	String export_node_tree(Collection<Node> list, int format, int extensions);

	void extract_references(Collection<Node> list, Collection<ScratchPad> scratch);

	Collection<LinkData> extract_link_data(String label, Collection<ScratchPad> scratch);

	void pad(StringBuilder out, int num, Collection<ScratchPad> scratch);

	int note_number_for_label(String text, Collection<ScratchPad> scratch);

	Collection<Node> node_matching_label(String label, Collection<Node> n);

	int count_node_from_end(Collection<Node> n);

	int cite_count_node_from_end(Collection<Node> n);

	Collection<Node> node_for_count(Collection<Node> n, int count);

	void move_note_to_used(Collection<Node> list, Collection<ScratchPad> scratch);

	Collection<Node> node_for_attribute(String querystring, Collection<Node> list);

	String dimension_for_attribute(String querystring, Collection<Node> list);
}
