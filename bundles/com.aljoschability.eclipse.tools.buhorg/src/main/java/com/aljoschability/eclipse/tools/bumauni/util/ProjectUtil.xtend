package com.aljoschability.eclipse.tools.bumauni.util;

import com.aljoschability.eclipse.tools.bumauni.data.Manifest
import org.eclipse.core.resources.IProject

public class ProjectUtil {
	static def boolean hasManifest(IProject project) {
		return project.isAccessible() && project.exists(Manifest.PATH);
	}
}
