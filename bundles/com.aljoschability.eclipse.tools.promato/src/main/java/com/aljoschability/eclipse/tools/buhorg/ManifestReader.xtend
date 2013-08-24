package com.aljoschability.eclipse.tools.buhorg

import com.google.common.base.Charsets
import com.google.common.io.Files
import java.io.File
import java.util.List

class ManifestParser {
	def Manifest read(File file) {
		val manifest = BuhorgFactory::eINSTANCE.createManifest

		for (header : collectHeaders(file)) {
			manifest.headers += readHeader(header)
		}

		return manifest
	}

	def private Header readHeader(String data) {
		val char nameSeparator = ':'
		val index = data.indexOf(nameSeparator)

		if (index == -1) {

			// XXX: rapid development
			throw new Error('''Could1 not separate header name/value!''')
		}

		if (index + 2 > data.length) {

			// XXX: rapid development
			throw new Error('''Could2 not separate header name/value!''')
		}

		val name = data.substring(0, index)
		val value = data.substring(index + 2)

		return readHeader(name, value)
	}

	def private Header readHeader(String name, String data) {
		val header = BuhorgFactory::eINSTANCE.createHeader
		header.name = name

		switch (name) {
			case "Bundle-SymbolicName": {
				header.splitAttribute = ";"
				header.values += readSingleValueWithSingleAttribute(data, "singleton", ":=")
			}
			case "Export-Package": {
			}
			case "Bundle-ClassPath",
			case "Bundle-RequiredExecutionEnvironment": {
				header.splitValue = ","

				for (part : data.split(header.splitValue)) {
					header.values += readValue(part)
				}
			}
			default: {
				header.values += readValue(data)
			}
		}

		return header
	}

	def private Value readSingleValueWithSingleAttribute(String data, String attributeName, String separator) {
		val attStart = ";"
		val attName = "singleton"
		val attSep = ":="
		val parts = data.split(attStart + attName + attSep)
		if (parts.size == 1) {
			return readValue(data)
		} else if (parts.size == 2) {
			val attribute = createAttribute(attName, attSep, parts.get(1))
			return readValue(parts.get(0), attribute)
		} else {
			throw new Error("XXX")
		}
	}

	def private Value readValue(String value) {
		return readValue(value, emptyList)
	}

	def private Value readValue(String value, Attribute attribute) {
		return readValue(value, newArrayList(attribute))
	}

	def private Value readValue(String value, List<Attribute> attributes) {
		val v = BuhorgFactory::eINSTANCE.createValue

		v.value = value
		v.attributes += attributes

		return v
	}

	def private static Attribute createAttribute(String name, String separator, String value) {
		val a = BuhorgFactory::eINSTANCE.createAttribute

		a.name = name
		a.separator = separator
		a.value = value

		return a
	}

	def private List<String> collectHeaders(File file) {
		val lines = Files::readLines(file, Charsets::UTF_8)

		val headers = newArrayList
		var String header
		for (line : lines) {
			if (line.empty) {
				if (header != null) {
					headers += header
				}
				header = null
			} else {
				if (line.startsWith(" ")) {
					header += line.substring(1)
				} else {
					if (header != null) {
						headers += header
					}
					header = line
				}
			}
		}

		// last line
		if (header != null) {
			headers += header
		}

		return headers
	}
}

class ManifestReaderTests {
	def static void main(String[] args) {
		val files = ManifestCollectorVisitor::getAll('''C:\Repositories''')

		val reader = new ManifestParser

		val map = newLinkedHashMap
		for (file : files) {
			map.put(file, reader.read(file))
		}

		val m = map.get(
			new File(
				'''C:\Repositories\arda.maglor\eclipse\eclipse-tools\bundles\com.aljoschability.eclipse.tools.bumauni\META-INF\MANIFEST.MF'''))
		printManifest(m)
	}

	def static private printManifest(Manifest manifest) {
		for (header : manifest.headers) {
			printHeader(header)
		}
	}

	def static private printHeader(Header header) {
		print('''«header.name»: ''')
		for (value : header.values) {
			printValue(value)
		}
		println()
	}

	def static printValue(Value value) {
		println(value.value)
	}

}
