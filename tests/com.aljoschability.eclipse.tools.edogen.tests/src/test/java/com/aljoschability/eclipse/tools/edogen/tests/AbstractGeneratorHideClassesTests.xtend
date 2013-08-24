package com.aljoschability.eclipse.tools.edogen.tests;

import com.aljoschability.eclipse.tools.edogen.AbstractGenerator
import com.aljoschability.eclipse.tools.edogen.Constants
import org.eclipse.emf.ecore.EcoreFactory
import org.junit.After
import org.junit.Before
import org.junit.Test

import static org.junit.Assert.assertTrue

class AbstractGeneratorHideClassesTests {
	AbstractGenerator generator

	@Before def void start() {
		generator = [elements|return null]
	}

	@After def void stop() {
		generator = null
	}

	@Test def void hide_classes() {
		val parent = EcoreFactory::eINSTANCE.createEPackage

		val a = EcoreFactory::eINSTANCE.createEAnnotation
		a.details.put(Constants::KEY__HIDE, Boolean.TRUE.toString())
		a.setSource(Constants::SOURCE_EDOGEN)
		a.setEModelElement(parent)

		val element = EcoreFactory::eINSTANCE.createEClass()
		parent.EClassifiers += element

		assertTrue(generator.hidden(parent))
		assertTrue(generator.hidden(element))
	}
}
