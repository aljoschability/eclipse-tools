package com.aljoschability.eclipse.tools.bumauni.ui.providers;

import org.eclipse.jface.viewers.ITableLabelProvider
import org.eclipse.ui.model.WorkbenchLabelProvider

public class ProjectsLabelProvider extends WorkbenchLabelProvider implements ITableLabelProvider {
	override getColumnImage(Object element, int index) {
		return getImage(element);
	}
	
	override getColumnText(Object element, int index) {
		return getText(element);
	}
}
