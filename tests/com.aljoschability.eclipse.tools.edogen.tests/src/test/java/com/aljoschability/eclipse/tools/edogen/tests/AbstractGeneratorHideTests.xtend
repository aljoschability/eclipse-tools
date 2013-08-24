package com.aljoschability.eclipse.tools.edogen.tests;

import com.aljoschability.eclipse.tools.edogen.AbstractGenerator
import com.aljoschability.eclipse.tools.edogen.Constants
import org.eclipse.emf.ecore.EcoreFactory
import org.junit.After
import org.junit.Before
import org.junit.Test

import static org.junit.Assert.assertFalse
import static org.junit.Assert.assertTrue

class AbstractGeneratorHideTests {
	AbstractGenerator generator;

	@Before def void start() {
		generator = [elements|return null]
	}

	@After def void stop() {
		generator = null
	}

	@Test def void hide_true() {
		val element = EcoreFactory.eINSTANCE.createEPackage();

		val a = EcoreFactory.eINSTANCE.createEAnnotation();
		a.getDetails().put(Constants.KEY__HIDE, Boolean.TRUE.toString());
		a.setSource(Constants.SOURCE_EDOGEN);
		a.setEModelElement(element);

		assertTrue(generator.hidden(element));
	}

	@Test def void hide_false() {
		val element = EcoreFactory.eINSTANCE.createEPackage();

		val a = EcoreFactory.eINSTANCE.createEAnnotation();
		a.getDetails().put(Constants.KEY__HIDE, Boolean.FALSE.toString());
		a.setSource(Constants.SOURCE_EDOGEN);
		a.setEModelElement(element);

		assertFalse(generator.hidden(element));
	}

	@Test def void hide_perhaps() {
		val element = EcoreFactory.eINSTANCE.createEPackage();

		val a = EcoreFactory.eINSTANCE.createEAnnotation();
		a.getDetails().put(Constants.KEY__HIDE, "perhaps");
		a.setSource(Constants.SOURCE_EDOGEN);
		a.setEModelElement(element);

		assertFalse(generator.hidden(element));
	}

	@Test def void hide_null() {
		val element = EcoreFactory.eINSTANCE.createEPackage();

		val a = EcoreFactory.eINSTANCE.createEAnnotation();
		a.getDetails().put(Constants.KEY__HIDE, null);
		a.setSource(Constants.SOURCE_EDOGEN);
		a.setEModelElement(element);

		assertFalse(generator.hidden(element));
	}

	@Test def void hide__inherited() {
		val parent = EcoreFactory.eINSTANCE.createEPackage();

		val a = EcoreFactory.eINSTANCE.createEAnnotation();
		a.getDetails().put(Constants.KEY__HIDE, Boolean.TRUE.toString());
		a.setSource(Constants.SOURCE_EDOGEN);
		a.setEModelElement(parent);

		val element = EcoreFactory.eINSTANCE.createEClass();
		parent.getEClassifiers().add(element);

		assertTrue(generator.hidden(parent));
		assertTrue(generator.hidden(element));
	}
}
