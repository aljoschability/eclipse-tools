package com.aljoschability.eclipse.tools.bumauni

import java.util.List
import java.util.Map

interface Manifest {
	def List<Header<?>> getHeaders()
}

class ManifestImpl implements Manifest {
	List<Header<?>> headers = newArrayList

	override getHeaders() {
		return headers
	}
}

interface Header<VT> {
	def String getKey()

	def VT getValue()
}

class HeaderImpl<VT> implements Header<VT> {
	val String key

	VT value

	new(String key, VT value) {
		this.key = key
		this.value = value
	}

	override getKey() {
		return key
	}

	override getValue() {
		return value
	}
}

interface ListHeader<V> extends Header<List<V>> {
}

class ListHeaderImpl<VT> extends HeaderImpl<List<VT>> implements ListHeader<VT> {
	new(String key, List<VT> values) {
		super(key, values)
	}
}

interface AttributedHeader<VT, AT> extends Header<VT> {
	def AT getAttribute(VT value)
}

class AttributedHeaderImpl<VT, AT> extends HeaderImpl<VT> implements AttributedHeader<VT, AT> {

	new(String key, VT value, Map<VT, AT> attributes) {
		super(key, value)
	}

	override getAttribute(VT value) {
	}

}

interface AttributedListHeader<V, A> extends ListHeader<V> {
}
