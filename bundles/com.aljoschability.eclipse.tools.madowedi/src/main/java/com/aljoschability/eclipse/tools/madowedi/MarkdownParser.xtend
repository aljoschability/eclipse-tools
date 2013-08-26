package com.aljoschability.eclipse.tools.madowedi

import java.io.File

class MarkdownParser {
	def void parse(File file) {

		//val p = new PegDownProcessor
		//val s = p.markdownToHtml(Files::toString(file, Charsets::UTF_8))
		//println(s)
		println('''we need to get "org.pegdown.PegDownProcessor" as osgi bundle [asm v5+ would be great!]''')
	}
}

class MarkdownParserTests {
	def static void main(String[] args) {
		val p = new MarkdownParser()

		p.parse(new File('''C:\Repositories\github.com\aljoschability\p2-libraries\README.md'''))
		p.parse(new File('''C:\Repositories\github.com\aljoschability\eclipse-tools\README.md'''))
	}

}
