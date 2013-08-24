package com.aljoschability.eclipse.tools.promato.reading.structs

@Data class BundleVersionRange {
	BundleVersion minimum
	boolean excludeMinimum
	BundleVersion maximum
	boolean excludeMaximum
}
