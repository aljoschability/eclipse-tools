package com.aljoschability.eclipse.tools.promato.simple.impl;

import com.aljoschability.eclipse.tools.promato.simple.data.Manifest
import com.aljoschability.eclipse.tools.promato.simple.data.Value
import java.util.List
import java.util.Map

public class ManifestImpl implements Manifest {
	val Map<String, Value> attributes
	List<String> list

	new() {
		attributes = newLinkedHashMap()
		list = newArrayList()
	}

	override addHeader(String name, Value value) {
		attributes.put(name, value);
		list.add(name);
	}

	override getNames() {
		return list;
	}

	override contains(String name) {
		return attributes.containsKey(name);
	}

	override get(String name) {
		return attributes.get(name);
	}

	override sort(List<String> sorting) {
		val newList = newArrayList();

		for (String string : sorting) {
			if (list.contains(string)) {
				newList.add(string);
			}
		}

		list = newList;
	}
}
