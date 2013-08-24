package com.aljoschability.eclipse.tools.madowedi

import java.io.File
import org.pegdown.PegDownProcessor
import com.google.common.io.Files
import com.google.common.base.Charsets

class MarkdownParser {
	def void parse(File file) {
		val p = new PegDownProcessor

		val s = p.markdownToHtml(Files::toString(file, Charsets::UTF_8))

		println(s)
	}
}

class MarkdownParserTests {
	def static void main(String[] args) {
		val p= new MarkdownParser()

		p.parse(new File('''C:\Repositories\github.com\aljoschability\p2-libraries\README.md'''))
		p.parse(new File('''C:\Repositories\github.com\aljoschability\eclipse-tools\README.md'''))
	}

}