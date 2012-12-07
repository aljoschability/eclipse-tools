package com.aljoschability.eclipse.tools.mumade.impl;

public class ParserImpl {
	private StringBuilder builder;

	public String test(String text) {
		builder = new StringBuilder();

		appendHeader();

		builder.append("<pre>");

		builder.append(text);

		builder.append("</pre>");

		appendFooter();

		return builder.toString();
	}

	private void appendHeader() {
		builder.append("<!DOCTYPE html>");
		builder.append("\n<head>");
		builder.append("\n<title>");
		builder.append("</title>");
		builder.append("\n<style>\n");
		builder.append("pre {color:red;}");
		builder.append("\n</style>");
		builder.append("\n</head>");
		builder.append("\n<body>\n");
	}

	private void appendFooter() {
		builder.append("\n</body>");
		builder.append("\n</html>\n");
	}
}
