package com.aljoschability.eclipse.tools.edogen;

import java.io.IOException;

import org.eclipse.emf.common.util.URI;
import org.eclipse.emf.ecore.EPackage;
import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.emf.ecore.resource.ResourceSet;
import org.eclipse.emf.ecore.resource.impl.ResourceSetImpl;
import org.eclipse.emf.ecore.xmi.impl.XMIResourceFactoryImpl;

import com.aljoschability.eclipse.tools.edogen.impl.LatexDocumentationGenerator;

public class GenTest {

	/**
	 * TODO:
	 * <ul>
	 * <li>tex escape: '{', '}', '\', '$'
	 * <li>html escape: <a>,<strong>,<em>,<code>,<pre>,<p>
	 * </ul>
	 */

	/**
	 * {@link GenTest} {@code text}
	 * 
	 * @param args
	 * @throws IOException
	 */
	public static void main(String[] args) throws IOException {
		String path = "C:\\Workspace\\eclipse\\eclipse\\com.aljoschability.eclipse.tools.edogen.tests\\core.ecore";
		// path =
		// "C:\\Repositories\\git\\com.github\\aljoschability\\eclipse-tools\\bundles\\com.aljoschability.eclipse.tools.edogen\\My.ecore";
		// path =
		// "C:\\Repositories\\svn\\de.uni-paderborn.cs.svn-serv\\CRC901-ServiceSpecificationEnvironment\\trunk\\plugins\\de.upb.crc901.sse.matching\\model\\matching.ecore";
		URI uri = URI.createFileURI(path);

		// EcorePackageImpl.init();

		ResourceSet resourceSet = new ResourceSetImpl();
		resourceSet.getResourceFactoryRegistry().getExtensionToFactoryMap().put("ecore", new XMIResourceFactoryImpl());

		Resource resource = resourceSet.getResource(uri, true);
		// resource.load(Collections.emptyMap());

		EPackage p = (EPackage) resource.getContents().get(0);

		Generator g = new LatexDocumentationGenerator();

		// System.out.println(g.generate(p));
		System.out.println(g.generate(p, p.getESubpackages().get(0), p.getESubpackages().get(0).getESubpackages()
				.get(0)));
	}
}
