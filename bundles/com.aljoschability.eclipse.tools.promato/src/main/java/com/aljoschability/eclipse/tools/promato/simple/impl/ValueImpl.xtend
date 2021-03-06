package com.aljoschability.eclipse.tools.promato.simple.impl;

import com.aljoschability.eclipse.tools.promato.simple.data.Value
import java.util.List

public class ValueImpl implements Value {
	val List<String> values

	new() {
		values = newArrayList()
	}

	override getList() {
		return values
	}

	override add(String value) {
		values.add(value)
	}
}
