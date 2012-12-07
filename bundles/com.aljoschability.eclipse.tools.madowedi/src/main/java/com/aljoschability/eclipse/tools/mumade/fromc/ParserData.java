package com.aljoschability.eclipse.tools.mumade.fromc;

import java.util.Collection;

public interface ParserData {
	String getInputBuffer();

	String getOriginal();

	Collection<Node> getResult();

	int getExtensions();

	Collection<Node> getAutolabels();

	boolean isAborted();

	long getTime();
}
