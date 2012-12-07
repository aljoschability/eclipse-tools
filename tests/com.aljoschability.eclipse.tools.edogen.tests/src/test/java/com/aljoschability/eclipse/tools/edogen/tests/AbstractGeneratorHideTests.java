package com.aljoschability.eclipse.tools.edogen.tests;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import org.eclipse.emf.ecore.EAnnotation;
import org.eclipse.emf.ecore.EClass;
import org.eclipse.emf.ecore.EModelElement;
import org.eclipse.emf.ecore.EPackage;
import org.eclipse.emf.ecore.EcoreFactory;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.aljoschability.eclipse.tools.edogen.AbstractGenerator;
import com.aljoschability.eclipse.tools.edogen.Constants;

public class AbstractGeneratorHideTests {
	private AbstractGenerator generator;

	@Before
	public void start() {
		generator = new AbstractGenerator() {
			@Override
			public String generate(EPackage... elements) {
				return null;
			}
		};
	}

	@After
	public void stop() {
		generator = null;
	}

	@Test
	public void hide_true() throws Exception {
		EModelElement element = EcoreFactory.eINSTANCE.createEPackage();

		EAnnotation a = EcoreFactory.eINSTANCE.createEAnnotation();
		a.getDetails().put(Constants.KEY__HIDE, Boolean.TRUE.toString());
		a.setSource(Constants.SOURCE_EDOGEN);
		a.setEModelElement(element);

		assertTrue(generator.hidden(element));
	}

	@Test
	public void hide_false() throws Exception {
		EModelElement element = EcoreFactory.eINSTANCE.createEPackage();

		EAnnotation a = EcoreFactory.eINSTANCE.createEAnnotation();
		a.getDetails().put(Constants.KEY__HIDE, Boolean.FALSE.toString());
		a.setSource(Constants.SOURCE_EDOGEN);
		a.setEModelElement(element);

		assertFalse(generator.hidden(element));
	}

	@Test
	public void hide_perhaps() throws Exception {
		EModelElement element = EcoreFactory.eINSTANCE.createEPackage();

		EAnnotation a = EcoreFactory.eINSTANCE.createEAnnotation();
		a.getDetails().put(Constants.KEY__HIDE, "perhaps");
		a.setSource(Constants.SOURCE_EDOGEN);
		a.setEModelElement(element);

		assertFalse(generator.hidden(element));
	}

	@Test
	public void hide_null() throws Exception {
		EModelElement element = EcoreFactory.eINSTANCE.createEPackage();

		EAnnotation a = EcoreFactory.eINSTANCE.createEAnnotation();
		a.getDetails().put(Constants.KEY__HIDE, null);
		a.setSource(Constants.SOURCE_EDOGEN);
		a.setEModelElement(element);

		assertFalse(generator.hidden(element));
	}

	@Test
	public void hide__inherited() throws Exception {
		EPackage parent = EcoreFactory.eINSTANCE.createEPackage();

		EAnnotation a = EcoreFactory.eINSTANCE.createEAnnotation();
		a.getDetails().put(Constants.KEY__HIDE, Boolean.TRUE.toString());
		a.setSource(Constants.SOURCE_EDOGEN);
		a.setEModelElement(parent);

		EClass element = EcoreFactory.eINSTANCE.createEClass();
		parent.getEClassifiers().add(element);

		assertTrue(generator.hidden(parent));
		assertTrue(generator.hidden(element));
	}
}
