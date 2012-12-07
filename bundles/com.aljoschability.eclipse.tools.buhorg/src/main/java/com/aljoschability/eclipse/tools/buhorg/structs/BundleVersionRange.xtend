package com.aljoschability.eclipse.tools.buhorg.structs

@Data class BundleVersionRange {
	BundleVersion minimum
	boolean excludeMinimum
	BundleVersion maximum
	boolean excludeMaximum
}
