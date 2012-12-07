package com.aljoschability.eclipse.tools.mumade;

public enum QuotationMark {
	Afrikaans('“', '”', '‘', '’'),

	Albanian('„', '“', '‘', '’'),

	Arabic('“', '”'),

	Armenian('«', '»'),

	Azerbaijani('«', '»', '‹', '›'),

	Basque('«', '»', '‹', '›'),

	Belarusian('«', '»'),

	Bulgarian('„', '“', '’', '’'),

	Catalan('«', '»', '“', '”'),

	Chinese_si('“', '”', '‘', '’'),

	Chinese_tr('「', '」', '『', '』'),

	Croatian('„', '”', '‚', '’'),

	Czech('„', '“', '‚', '‘'),

	Danish('»', '«', '„', '“'),

	Dutch('„', '”', '‚', '’'),

	English_UK('‘', '’', '“', '”'),

	English_US('“', '”', '‘', '’'),

	Esperanto('“', '”', '‘', '’'),

	Estonian('„', '”'),

	Filipino('“', '”', '‘', '’'),

	Finnish('”', '”', '’', '’'),

	French('«', '»', '“', '”'),

	French_Swiss('«', '»', '‹', '›'),

	Georgian('„', '“'),

	German('„', '“', '‚', '‘'),

	German_Swiss('«', '»', '‹', '›'),

	Greek('«', '»', '“', '”'),

	Hebrew('„', '”', '‚', '’'),

	Hungarian('„', '”', '»', '«'),

	Icelandic('„', '“', '‚', '‘'),

	Indonesian('“', '”', '‘', '’'),

	Irish('“', '”', '‘', '’'),

	Italian('«', '»', '“', '”'),

	Italian_Swiss('«', '»', '‹', '›'),

	Japanese('「', '」', '『', '』'),

	Korean('“', '”', '‘', '’'),

	Latvian('«', '»', '„', '“'),

	Lithuanian('„', '“'),

	Macedonian('„', '“', '’', '‘'),

	Norwegian('«', '»', '’', '’'),

	Persian('«', '»'),

	Polish('„', '”', '«', '»'),

	Portuguese_Brazil('“', '”', '‘', '’'),

	Portuguese_Portugal('«', '»', '“', '”'),

	Romanian('„', '”', '«', '»'),

	Russian('«', '»', '„', '“'),

	Serbian('„', '“', '’', '’'),

	Slovak('„', '“', '‚', '‘'),

	Slovene('„', '“', '‚', '‘'),

	Sorbian('„', '“', '‚', '‘'),

	Spanish('«', '»', '“', '”'),

	Swedish('”', '”', '’', '’'),

	Thai('“', '”', '‘', '’'),

	Turkish('“', '”', '‘', '’'),

	Ukrainian('«', '»'),

	Vietnamese('“', '”'),

	Welsh('‘', '’', '“', '”');

	private final char primaryStart;
	private final char primaryEnd;
	private final char secondaryStart;
	private final char secondaryEnd;

	private QuotationMark(QuotationMark quote) {
		this(quote.primaryStart, quote.primaryEnd, quote.secondaryStart, quote.secondaryEnd);
	}

	private QuotationMark(char primaryStart, char primaryEnd) {
		this(primaryStart, primaryEnd, primaryStart, primaryEnd);
	}

	private QuotationMark(char primaryStart, char primaryEnd, char secondaryStart, char secondaryEnd) {
		this.primaryStart = primaryStart;
		this.primaryEnd = primaryEnd;
		this.secondaryStart = secondaryStart;
		this.secondaryEnd = secondaryEnd;
	}

	public char getPrimaryStart() {
		return primaryStart;
	}

	public char getPrimaryEnd() {
		return primaryEnd;
	}

	public char getSecondaryStart() {
		return secondaryStart;
	}

	public char getSecondaryEnd() {
		return secondaryEnd;
	}
}
