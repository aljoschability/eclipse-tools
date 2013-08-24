package com.aljoschability.eclipse.tools.edogen.tests

import com.aljoschability.eclipse.tools.edogen.impl.LatexDocumentationGenerator
import org.eclipse.emf.common.util.URI
import org.eclipse.emf.ecore.EPackage
import org.eclipse.emf.ecore.resource.impl.ResourceSetImpl
import org.eclipse.emf.ecore.xmi.impl.XMIResourceFactoryImpl
import org.junit.Before
import org.junit.Test

class GeneratorTests {
	ResourceSetImpl resourceSet

	@Before def void before() {
		resourceSet = new ResourceSetImpl()
		resourceSet.resourceFactoryRegistry.extensionToFactoryMap.put("ecore", new XMIResourceFactoryImpl())
	}

	@Test def void testGeneratorCore() {
		val uri = getUri('''model/core.ecore''')
		val resource = resourceSet.getResource(uri, true)

		// load root package
		val pack = resource.contents.get(0) as EPackage

		// collect all packages
		val packs = newArrayList
		packs += pack
		packs += pack.ESubpackages.get(0)
		packs += pack.ESubpackages.get(0).ESubpackages.get(0)

		val generator = new LatexDocumentationGenerator()

		// System.out.println(g.generate(p));
		println(generator.generate(packs));
	}

	def static private URI getUri(String path) {
		val uri = GeneratorTests.getResource('''model/core.ecore''')

		return URI::createURI(uri.toString)
	}
}
