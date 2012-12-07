package com.aljoschability.eclipse.tools.edogen.tests;

import static org.junit.Assert.assertTrue;

import org.eclipse.emf.ecore.EAnnotation;
import org.eclipse.emf.ecore.EClass;
import org.eclipse.emf.ecore.EPackage;
import org.eclipse.emf.ecore.EcoreFactory;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.aljoschability.eclipse.tools.edogen.AbstractGenerator;
import com.aljoschability.eclipse.tools.edogen.Constants;

public class AbstractGeneratorHideClassesTests {
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
	public void hide_classes() throws Exception {
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
