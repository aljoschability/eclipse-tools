package com.aljoschability.eclipse.tools.bumauni.data

import java.util.List

interface Value {
	def List<String> getList()

	def void add(String value)
}
