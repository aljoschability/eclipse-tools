package com.aljoschability.eclipse.tools.bumauni.util;

import com.aljoschability.eclipse.tools.bumauni.data.Manifest
import com.aljoschability.eclipse.tools.bumauni.data.Value
import com.aljoschability.eclipse.tools.bumauni.impl.ManifestImpl
import com.aljoschability.eclipse.tools.bumauni.impl.ValueImpl
import java.io.BufferedReader
import java.io.ByteArrayInputStream
import java.io.IOException
import java.io.InputStreamReader
import org.eclipse.core.resources.IContainer
import org.eclipse.core.resources.IFile
import org.eclipse.core.resources.IProject
import org.eclipse.core.resources.IResource
import org.eclipse.core.resources.ProjectScope
import org.eclipse.core.runtime.CoreException
import org.eclipse.core.runtime.IPath
import org.eclipse.core.runtime.NullProgressMonitor
import org.eclipse.core.runtime.Path

public class ManifestUtil {
	static val PLUGIN_ID = "org.eclipse.pde.core"
	static val BUNDLE_ROOT_PATH = "BUNDLE_ROOT_PATH"

	static def Manifest read(IProject project) {
		val file = getManifestFile(project);
		val manifest = new ManifestImpl();

		val isr = new InputStreamReader(file.getContents());
		val reader = new BufferedReader(isr);

		var String currentName = null;
		var Value currentValue = null;

		var String line;
		while ((line = reader.readLine()) != null) {

			// add last header
			if (line.isEmpty()) {
				throw new IOException("Empty line detected");
			}

			if (line.charAt(0) == ' ') {

				// continue line
				if (currentName == null) {
					throw new IOException("Misplaced continuation line");
				}

				currentValue.add(getValue(line.substring(1)));
			} else {

				// store information
				if (currentName != null && currentValue != null) {
					manifest.addHeader(currentName, currentValue);
				}

				// new name
				val index = line.indexOf(':');
				if (index != -1) {
					currentName = line.substring(0, index).trim();

					currentValue = new ValueImpl();
					val value = getValue(line.substring(index + 1));

					currentValue.add(value);
				} else {
					throw new IOException("No header separator found");
				}
			}
		}

		// add last header
		manifest.addHeader(currentName, currentValue);

		System.out.println(manifest);

		return manifest;
	}

	static def void write(IProject project, Manifest manifest) throws CoreException {
		val file = getManifestFile(project);

		// create string
		val builder = new StringBuilder();
		for (String name : manifest.getNames()) {
			builder.append(name);
			builder.append(':');

			val values = manifest.get(name).getList();
			for (var i = 0; i < values.size(); i++) {
				val v = values.get(i)
				builder.append(' ');
				builder.append(v);

				if (i < values.size() - 1) {
					builder.append(',');
					builder.append('\r');
					builder.append('\n');
				}
			}
			builder.append('\r');
			builder.append('\n');
		}

		// set contents
		val stream = new ByteArrayInputStream(builder.toString().getBytes());
		file.setContents(stream, IResource.KEEP_HISTORY, new NullProgressMonitor());
	}

	private static def IFile getManifestFile(IProject project) {
		return getBundleRelativeFile(project, Manifest.PATH);
	}

	private static def IFile getBundleRelativeFile(IProject project, IPath path) {
		return getBundleRoot(project).getFile(path);
	}

	private static def IContainer getBundleRoot(IProject project) {
		val scope = new ProjectScope(project);
		val node = scope.getNode(PLUGIN_ID);
		if (node != null) {
			val string = node.get(BUNDLE_ROOT_PATH, null);
			if (string != null) {
				val path = Path.fromPortableString(string);
				return project.getFolder(path);
			}
		}
		return project;
	}

	private static def String getValue(String value) {
		var result = value
		if (result.endsWith(",")) { //$NON-NLS-1$
			result = result.substring(0, value.length() - 1);
		}

		return result.trim();
	}
}
