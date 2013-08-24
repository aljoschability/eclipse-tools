package com.aljoschability.eclipse.tools.bumauni.data

import java.util.List
import java.util.jar.JarFile
import org.eclipse.core.runtime.Path

interface Manifest {
	val PATH = new Path(JarFile::MANIFEST_NAME)

	def List<String> getNames()

	def void addHeader(String name, Value value)

	def boolean contains(String name)

	def Value get(String name)

	def void sort(List<String> sorting)
}
