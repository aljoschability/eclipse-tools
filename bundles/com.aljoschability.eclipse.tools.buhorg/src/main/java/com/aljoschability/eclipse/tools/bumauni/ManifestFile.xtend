package com.aljoschability.eclipse.tools.bumauni

import java.io.File
import java.io.FileInputStream
import java.util.List
import java.util.Map
import java.util.jar.Manifest

interface ManifestFile {
	val MANIFEST_VERSION = "Manifest-Version"
	val BUNDLE_SYMBOLIC_NAME = "Bundle-SymbolicName"
	val BUNDLE_VERSION = "Bundle-Version"
	val BUNDLE_MANIFEST_VERSION = "Bundle-ManifestVersion"
	val BUNDLE_NAME = "Bundle-Name"
	val BUNDLE_VENDOR = "Bundle-Vendor"
	val BUNDLE_REQUIRED_EXECUTION_ENV = "Bundle-RequiredExecutionEnvironment"
	val REQUIRE_BUNDLE = "Require-Bundle"
	val EXPORT_PACKAGE = "Export-Package"

	def List<ManifestEntry> getEntries()

	def ManifestEntry getEntry(String key)
}

interface ManifestEntry {
	def String getKey()

	def List<ManifestEntryValue> getValues()
}

interface ManifestEntryValue {
	def String getValue()

	def Map<String, String> getAttributes()
}
