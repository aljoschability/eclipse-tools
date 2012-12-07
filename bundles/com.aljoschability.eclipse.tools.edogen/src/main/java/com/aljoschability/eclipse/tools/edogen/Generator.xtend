package com.aljoschability.eclipse.tools.edogen

import org.eclipse.emf.ecore.EPackage

interface Generator {
	/**
	 * This method generated the string that represents the full documentation for the given packages.
	 * @param elements The packages for which to generate the documentation.
	 */
	def String generate(EPackage... elements)

}
