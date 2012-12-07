package com.aljoschability.eclipse.tools.buhorg

import java.io.File
import java.io.IOException
import java.nio.file.FileVisitResult
import java.nio.file.Files
import java.nio.file.Path
import java.nio.file.Paths
import java.nio.file.SimpleFileVisitor
import java.nio.file.attribute.BasicFileAttributes
import java.util.Set

class ManifestCollectorVisitor extends SimpleFileVisitor<Path> {
	val Set<File> files = newLinkedHashSet

	override visitFile(Path file, BasicFileAttributes attrs) throws IOException {
		if (file.fileName.toString == "MANIFEST.MF") {
			files += file.toFile
		}
		return FileVisitResult::CONTINUE
	}

	def getFiles() {
		return files
	}

	def static getAll(String path) {
		val startPath = Paths::get(path)
		val visitor = new ManifestCollectorVisitor

		Files::walkFileTree(startPath, visitor)

		return visitor.files
	}
}
