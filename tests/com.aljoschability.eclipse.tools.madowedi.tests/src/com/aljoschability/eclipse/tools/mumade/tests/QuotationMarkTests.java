package com.aljoschability.eclipse.tools.mumade.tests;

import java.text.MessageFormat;

import org.junit.Test;

import com.aljoschability.eclipse.mumade.QuotationMark;

public class QuotationMarkTests {
	@Test
	public void testAll() throws Exception {
		for (QuotationMark mark : QuotationMark.values()) {
			String name = mark.name();
			char ps = mark.getPrimaryStart();
			char pe = mark.getPrimaryEnd();
			char ss = mark.getSecondaryStart();
			char se = mark.getSecondaryEnd();
			System.out.println(MessageFormat.format("{0}...{1}\t{2}...{3}\t{4}", ps, pe, ss, se, name));
		}
	}
}
