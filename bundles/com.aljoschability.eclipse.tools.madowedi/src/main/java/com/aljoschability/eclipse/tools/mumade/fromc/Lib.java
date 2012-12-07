package com.aljoschability.eclipse.tools.mumade.fromc;

public interface Lib {

	String markdown_to_string(String source, int extensions, int format);

	String extract_metadata_value(String source, int extensions, String key);

	boolean has_metadata(String source, int extensions);

	String mmd_version();
}
