package com.aljoschability.eclipse.tools.promato.ui.providers;

import com.aljoschability.eclipse.tools.promato.ui.Images
import org.eclipse.jface.viewers.ITableLabelProvider
import org.eclipse.jface.viewers.LabelProvider

public class HeadersLabelProvider extends LabelProvider implements ITableLabelProvider {
	override getColumnImage(Object element, int index) {
		return getImage(element);
	}

	override getImage(Object element) {
		return Images.getImage(Images.HEADER);
	}

	override getColumnText(Object element, int index) {
		return getText(element);
	}
}
