package com.aljoschability.eclipse.tools.mumade.fromc;

import java.util.Collection;

public interface Parser {
	/* Markdown compatibility mode */
	int EXT_COMPATIBILITY = 1 << 0;
	/* Create complete document */
	int EXT_COMPLETE = 1 << 1;
	/* for use by parser */
	int EXT_HEAD_CLOSED = 1 << 2;
	/* Enable Smart quotes */
	int EXT_SMART = 1 << 3;
	/* Enable Footnotes */
	int EXT_NOTES = 1 << 4;
	/* Don't add anchors to headers, etc. */
	int EXT_NO_LABELS = 1 << 5;
	/* Filter out style blocks */
	int EXT_FILTER_STYLES = 1 << 6;
	/* Filter out raw HTML */
	int EXT_FILTER_HTML = 1 << 7;
	/* Process Markdown inside HTML */
	int EXT_PROCESS_HTML = 1 << 8;
	/* Don't parse Metadata */
	int EXT_NO_METADATA = 1 << 9;
	/* Mask email addresses */
	int EXT_OBFUSCATE = 1 << 10;
	/* Critic Markup Support */
	int EXT_CRITIC = 1 << 11;
	/* Accept all proposed changes */
	int EXT_CRITIC_ACCEPT = 1 << 12;
	/* Reject all proposed changes */
	int EXT_CRITIC_REJECT = 1 << 13;
	/* 15 is highest number allowed */
	int EXT_FAKE = 1 << 15;

	Collection<Node> mk_node(int key);

	Collection<Node> mk_str(String string);

	Collection<Node> mk_list(int key, Collection<Node> list);

	Collection<Node> mk_link(Collection<Node> text, String label, String source, String title, Collection<Node> attr);

	Collection<Node> mk_pos_node(int key, String string, int start, int stop);

	Collection<Node> mk_pos_str(String string, int start, int stop);

	Collection<Node> mk_pos_list(int key, Collection<Node> list, int start, int stop);

	void free_node(Collection<Node> n);

	void free_node_tree(Collection<Node> n);

	void print_node_tree(Collection<Node> n);

	Collection<Node> cons(Collection<Node> newN, Collection<Node> list);

	Collection<Node> reverse_list(Collection<Node> list);

	void append_list(Collection<Node> newN, Collection<Node> list);

	Collection<Node> mk_str_from_list(Collection<Node> list, boolean extra_newline);

	StringBuilder concat_string_list(Collection<Node> list);

	Collection<ParserData> mk_parser_data(String charbuf, int extensions);

	void free_parser_data(Collection<ParserData> data);

	String preformat_text(String text);

	Collection<ScratchPad> mk_scratch_pad(int extensions);

	void free_scratch_pad(Collection<ScratchPad> scratch);

	Collection<LinkData> mk_link_data(String label, String source, String title, Collection<Node> attr);

	void free_link_data(Collection<LinkData> l);

	Collection<LinkData> extract_link_data(String label, Collection<ScratchPad> scratch);

	Collection<Node> mk_autolink(String text);

	void extract_references(Collection<Node> list, Collection<ScratchPad> scratch);

	boolean extension(int ext, int extensions);

	/* export utilities */
	void trim_trailing_whitespace(String str);

	void trim_trailing_newlines(String str);

	/* other utilities */
	String label_from_string(String str);

	String clean_string(String str);

	String label_from_node_tree(Collection<Node> n);

	String label_from_node(Collection<Node> n);

	void print_raw_node(StringBuilder out, Collection<Node> n);

	void print_raw_node_tree(StringBuilder out, Collection<Node> n);

	String correct_dimension_units(String original);

	Collection<Node> metadata_for_key(String key, Collection<Node> list);

	String metavalue_for_key(String key, Collection<Node> list);

	boolean tree_contains_key(Collection<Node> list, int key);

	boolean check_timeout();

	void debug_node(Collection<Node> n);
}
