package com.aljoschability.eclipse.tools.mumade.ui.editors;

import java.util.ArrayList;
import java.util.List;

import org.eclipse.jface.text.rules.EndOfLineRule;
import org.eclipse.jface.text.rules.IPredicateRule;
import org.eclipse.jface.text.rules.IToken;
import org.eclipse.jface.text.rules.MultiLineRule;
import org.eclipse.jface.text.rules.RuleBasedPartitionScanner;
import org.eclipse.jface.text.rules.SingleLineRule;
import org.eclipse.jface.text.rules.Token;

public class MumadePartitionScanner extends RuleBasedPartitionScanner {
	private static final String JAVA_DOC = "javadoc";
	private static final String JAVA_MULTILINE_COMMENT = "jmulco";

	public static final String[] MUMADE_PARTITION_TYPES = new String[] { JAVA_DOC, JAVA_MULTILINE_COMMENT };

	public MumadePartitionScanner() {
		System.out.println("MumadePartitionScanner");

		IToken javaDoc = new Token(JAVA_DOC);
		IToken comment = new Token(JAVA_MULTILINE_COMMENT);

		List<IPredicateRule> rules = new ArrayList<IPredicateRule>();
		// Add rule for single line comments.
		rules.add(new EndOfLineRule("//", Token.UNDEFINED));

		// Add rule for strings and character constants.
		rules.add(new SingleLineRule("\"", "\"", Token.UNDEFINED, '\\'));
		rules.add(new SingleLineRule("'", "'", Token.UNDEFINED, '\\'));

		// TODO: Add special case word rule.
		// rules.add(new WordPredicateRule(comment));

		// Add rules for multi-line comments and javadoc.
		rules.add(new MultiLineRule("/**", "*/", javaDoc, (char) 0, true));
		rules.add(new MultiLineRule("/*", "*/", comment, (char) 0, true));

		IPredicateRule[] result = new IPredicateRule[rules.size()];
		rules.toArray(result);
		setPredicateRules(result);
	}
}
