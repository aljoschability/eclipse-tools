package com.aljoschability.eclipse.tools.edogen.impl

import com.aljoschability.eclipse.tools.edogen.AbstractGenerator
import java.util.Collection
import java.util.Map
import org.eclipse.emf.ecore.EAttribute
import org.eclipse.emf.ecore.EClass
import org.eclipse.emf.ecore.EClassifier
import org.eclipse.emf.ecore.EDataType
import org.eclipse.emf.ecore.EEnum
import org.eclipse.emf.ecore.EModelElement
import org.eclipse.emf.ecore.ENamedElement
import org.eclipse.emf.ecore.EOperation
import org.eclipse.emf.ecore.EPackage
import org.eclipse.emf.ecore.EReference
import org.eclipse.emf.ecore.ETypedElement
import org.eclipse.emf.ecore.util.EcoreUtil
import org.eclipse.xtend2.lib.StringConcatenation

/*
 * TODO:
 * <ul>
 * <li>tex escape: '{', '}', '\', '$'
 * <li>html escape: <a>,<strong>,<em>,<code>,<pre>,<p>
 * </ul>
 */
class LatexDocumentationGenerator extends AbstractGenerator {
	val Collection<String> labels = newLinkedHashSet

	def static private String getLabel(EModelElement element) {
		val prefix = "api"
		val uri = EcoreUtil::getURI(element)

		return prefix + uri

	//"api:" + (uri.lastSegment + uri.fragment).replace("/", ":")
	}

	val TEXT_EXTENDS = "extends"

	def title(Object e) {
		if (e instanceof EModelElement) {
			println(e.label)
		}

		switch e {
			EPackage case e.ESuperPackage == null: '''Package \texttt{«e.escaped_name»}'''
			EPackage: {
				var StringBuilder b = new StringBuilder

				var s = e
				while (s != null) {
					b.insert(0, s.escaped_name)

					s = s.ESuperPackage

					if (s != null) {
						b.insert(0, "::")
					}
				}

				'''Package \texttt{«b»}'''
			}
			EClass case e.interface: '''Interface \texttt{«e.escaped_name»}'''
			EClass case e.abstract: '''Abstract Class \texttt{«e.escaped_name»}'''
			EClass: '''Class \texttt{«e.escaped_name»}'''
			EEnum: '''Enumeration \texttt{«e.escaped_name»}'''
			EDataType: '''Data Type \texttt{«e.escaped_name»}'''
		}
	}

	var Map<EClass, Collection<EClass>> subclassCache

	def reference(EModelElement element) {
		var uri = EcoreUtil.getURI(element)
		"api:" + (uri.lastSegment + uri.fragment).replace("/", ":")
	}

	override generate(EPackage... elements) {

		// create subclass cache
		subclassCache = newLinkedHashMap()

		// go through packages
		for (pack : elements) {

			// go through classifiers
			for (classifier : pack.EClassifiers) {
				switch classifier {
					// for all classes
					EClass:
						// go through super classes
						for (superclass : classifier.ESuperTypes) {
							var subclasses = subclassCache.get(superclass)
							if (subclasses == null) {
								subclasses = newLinkedHashSet()
								subclassCache.put(superclass, subclasses)
							}
							subclasses.add(classifier)
						}
				}
			}
		}

		// generate it
		var StringConcatenation result = new StringConcatenation
		for (pack : elements) {
			if (!pack.hidden) {
				result.append(generate(pack))
			}
		}
		result.toString
	}

	def children(EClass element) {
		subclassCache.get(element)
	}

	def parents(EClass element) {
		if (element.ESuperTypes.empty) {
			null
		} else {
			element.ESuperTypes
		}
	}

	def generate(EPackage pack) {
		labels += pack.reference
		return '''
			\section{«pack.title»}
			\label{«pack.reference»}
			«pack.documentation»
			\begin{description}
			\item[Namespace] \texttt{«pack.nsURI»}
			«IF !pack.name.equals(pack.nsPrefix)»
				\item[Prefix] \texttt{«pack.nsPrefix»}
			«ENDIF»
			\end{description}
			«FOR c : pack.EClassifiers»
				«IF !c.hidden»
					«create(c)»
				«ENDIF»
			«ENDFOR»
		'''
	}

	def create(EClassifier c) {
		switch c {
			EClass: create(c)
			EEnum: create(c)
			EDataType: create(c)
			default: throw new UnsupportedOperationException()
		}
	}

	def create(EClass c) '''
		\subsection{«c.title»}
		\label{«c.reference»}
		«c.documentation»
		«IF c.children != null»
			\subsubsection*{Subclasses}
			\begin{itemize}
			«FOR child : c.children»
				\item \hyperref[«child.reference»]{\texttt{«child.classifierName»} (see section \ref*{«child.reference»} on page \pageref*{«child.
			reference»})}
			«ENDFOR»
			\end{itemize}
		«ENDIF»
		«IF c.parents != null»
			\subsubsection*{Superclasses}
			\begin{itemize}
			«FOR sup : c.ESuperTypes»
				\item \hyperref[«sup.reference»]{\texttt{«sup.classifierName»} (see section \ref*{«sup.reference»} on page \pageref*{«sup.
			reference»})}
			«ENDFOR»
			\end{itemize}
		«ENDIF»
		«IF !c.attributes.empty»
			\subsubsection*{Attributes}
			\begin{description}
			«FOR a : c.attributes»
				«generate(a)»
			«ENDFOR»
			\end{description}
		«ENDIF»
		«IF !c.operations.empty»
			\subsubsection*{Operations}
			\begin{description}
			«FOR o : c.operations»
				«create(o)»
			«ENDFOR»
			\end{description}
		«ENDIF»
		«IF !c.containments.empty»
			\subsubsection*{Containments}
			\begin{description}
			«FOR r : c.containments»
				«create(r)»
			«ENDFOR»
			\end{description}
		«ENDIF»
		«IF !c.crossreferences.empty»
			\subsubsection*{References}
			\begin{description}
			«FOR r : c.crossreferences»
				«create(r)»
			«ENDFOR»
			\end{description}
		«ENDIF»
	'''

	def Iterable<? extends EAttribute> attributes(EClass element) {
		return element.EAttributes
	}

	def Iterable<? extends EOperation> operations(EClass element) {
		return element.EOperations
	}

	def containments(EClass element) {
		var references = newArrayList()
		for (reference : element.EReferences) {
			if (reference.containment) {
				references.add(reference)
			}
		}
		return references
	}

	def crossreferences(EClass element) {
		var references = newArrayList()
		for (reference : element.EReferences) {
			if (!reference.containment) {
				references.add(reference)
			}
		}
		return references
	}

	def generate(EAttribute a) '''
		\item[\texttt{«a.escaped_name»~:~«a.typeName»}] «a.documentation»
	'''

	def getTypeName(ETypedElement element) '''«element.EType.name»'''

	def create(EOperation o) '''
		\item[\texttt{«o.formatted_name»}] «o.documentation»
	'''

	def String formatted_name(EOperation element) {
		var builder = new StringBuilder

		// name
		builder.append(element.name)

		// parameters
		builder.append('(')
		var i = 0
		for (p : element.EParameters) {
			i = i + 1
			builder.append(p.EType.classifierName)
			if (i < element.EParameters.size) {
				builder.append(", ")
			}
		}
		builder.append(')')
		builder.append(' ')
		builder.append(':')
		builder.append(' ')
		builder.append(element.EType.classifierName)

		return builder.toString
	}

	def create(EReference r) '''
		\item[«r.escaped_name» : «r.EType.classifierName»] «r.documentation»
	'''

	def create(EEnum e) '''
		\subsection{«e.title»}
		«e.documentation»
		\begin{description}
		«FOR l : e.ELiterals»
			\item[«l.escaped_name»] «l.documentation»
		«ENDFOR»
		\end{description}
	'''

	def create(EDataType d) '''
		\subsection{«d.title»}
		«d.documentation»
	'''

	def escaped_name(ENamedElement element) '''«element.name.replace("_", "\\_").replace("$", "\\$")»'''

	def CharSequence getClassifierName(EClassifier c) {
		if (c == null) {
			throw new IllegalArgumentException
		}

		val StringConcatenation s = new StringConcatenation

		// name
		s.append(c.name)

		// type parameters
		if (!c.ETypeParameters.empty) {
			s.append('<')

			var int pIndex = 1
			var pSize = c.ETypeParameters.size
			for (p : c.ETypeParameters) {
				s.append(p.name)

				var int bIndex = 1
				var bSize = p.EBounds.size
				if (!p.EBounds.empty) {
					s.append(' ')
					s.append(TEXT_EXTENDS)
					s.append(' ')
					for (b : p.EBounds) {
						if (b.EClassifier == null) {
							s.append('?')
						} else {
							s.append(getClassifierName(b.EClassifier))
						}
						if (bIndex < bSize) {
							s.append(' ')
							s.append('\\')
							s.append('&')
							s.append(' ')
						}
						bIndex = bIndex + 1
					}
				}
				if (pIndex < pSize) {
					s.append(',')
					s.append(' ')
				}
				pIndex = pIndex + 1
			}

			s.append('>')
		}

		s.toString
	}

	override escape(String text) {
		text.replace("{", "\\{").replace("}", "\\}").replace("$", "\\$").replace("_", "\\_")
	}
}
