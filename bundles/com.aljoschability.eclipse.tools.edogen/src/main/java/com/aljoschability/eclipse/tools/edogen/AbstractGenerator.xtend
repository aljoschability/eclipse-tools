package com.aljoschability.eclipse.tools.edogen

import java.util.Map
import org.eclipse.emf.ecore.EClass
import org.eclipse.emf.ecore.EModelElement
import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.EPackage
import org.eclipse.emf.ecore.EEnum
import org.eclipse.emf.ecore.EDataType
import org.eclipse.emf.ecore.EAttribute
import org.eclipse.emf.ecore.EOperation
import org.eclipse.emf.ecore.EReference
import org.eclipse.emf.ecore.EEnumLiteral

abstract class AbstractGenerator implements Generator {
	String EMPTY = ""
	String NO_DOCUMENTATION = "No detailed documentation provided."

	val Map<EObject, String> anchorCache = newLinkedHashMap()

	def String raw_value(EModelElement element, String key) {
		var annotation = element.getEAnnotation(Constants.SOURCE_EDOGEN);
		if (annotation != null) {
			var detail = annotation.details.get(key)
			if (detail != null) {
				return detail
			}
		}
		return EMPTY
	}

	def void escape(String text) {
	}

	def boolean isRecursiveTrue(EModelElement element, String key) {
		var value = Boolean.valueOf(element.raw_value(key))
		if (!value) {
			var parent = element.eContainer
			if (parent instanceof EModelElement) {
				value = isRecursiveTrue(parent as EModelElement, key)
			}
		}
		return value
	}

	def boolean hidden(EModelElement element) {
		if (element.isRecursiveTrue(Constants.KEY__HIDE)) {
			return true
		}

		switch element {
			EPackage: {
				return element.isRecursiveTrue(Constants.KEY__HIDE_PACKAGES)
			}
			EClass: {
				return element.isRecursiveTrue(Constants.KEY__HIDE_CLASSES)
			}
			EEnum: {
				return element.isRecursiveTrue(Constants.KEY__HIDE_ENUMERATIONS)
			}
			EDataType: {
				return element.isRecursiveTrue(Constants.KEY__HIDE_DATATYPES)
			}
			EAttribute: {
				return element.isRecursiveTrue(Constants.KEY__HIDE_ATTRIBUTES)
			}
			EOperation: {
				return element.isRecursiveTrue(Constants.KEY__HIDE_OPERATIONS)
			}
			EReference: {
				var hidden = element.isRecursiveTrue(Constants.KEY__HIDE_REFERENCES)
				if (!hidden) {
					if (element.containment) {
						hidden = element.isRecursiveTrue(Constants.KEY__HIDE_CONTAINMENTS)
					} else {
						hidden = element.isRecursiveTrue(Constants.KEY__HIDE_CROSSREFERENCES)
					}
				}
				return hidden
			}
			EEnumLiteral: {
				return element.isRecursiveTrue(Constants.KEY__HIDE_LITERALS)
			}
			default: {
				throw new IllegalArgumentException
			}
		}
	}

	/**
	 * Returns the documentation text for the given model element represented by the GenModel annotation.
	 * @param element The element for which to get the documentation text.
	 */
	def documentation(EModelElement element) {
		var annotation = element.getEAnnotation(Constants.SOURCE_GENMODEL)
		if (annotation != null) {
			var entry = annotation.details.get(Constants.DOCUMENTATION)
			if (entry != null) {

				// {@code x}
				entry = entry.replaceAll("\\{@code ([^\\}]*)\\}", "\\\\texttt{$1}")

				// {@link x}
				entry = entry.replaceAll("\\{@link ([^\\}]*)\\}", "\\\\hyperref[$1]{\\\\texttt{$1}}")

				// {@linkplain x}
				entry = entry.replaceAll("\\{@linkplain ([^\\}]*)\\}", "\\\\hyperref[$1]{$1}")

				// {@link x y}
				entry = entry.replaceAll("\\{@link ([^\\s]*)([^\\}]*)\\}", "\\\\hyperref[$1]{\\\\texttt{$2}}")

				// {@linkplain x y}
				entry = entry.replaceAll("\\{@linkplain ([^\\s]*)([^\\}]*)\\}", "\\\\hyperref[$1]{$2}")

				return entry
			}
		}
		return "\\textcolor{red}{" + NO_DOCUMENTATION + "}"
	}

	def showAttributes(EClass element) {
		return true
	}
}
