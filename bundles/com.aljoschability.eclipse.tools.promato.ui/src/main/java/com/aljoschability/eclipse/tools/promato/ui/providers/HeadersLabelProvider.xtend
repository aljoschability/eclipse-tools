package com.aljoschability.eclipse.tools.promato.ui.providers;

import org.eclipse.jface.viewers.ITableLabelProvider
import org.eclipse.jface.viewers.LabelProvider
import com.aljoschability.eclipse.tools.promato.ui.PromatoImages

public class HeadersLabelProvider extends LabelProvider implements ITableLabelProvider {
	override getColumnImage(Object element, int index) {
		return getImage(element);
	}

	override getImage(Object element) {
		return PromatoImages.getImage(PromatoImages.HEADER);
	}

	override getColumnText(Object element, int index) {
		return getText(element);
	}
}
