package com.aljoschability.eclipse.tools.mumade.ui.editors;

import org.eclipse.core.filebuffers.IDocumentSetupParticipant;
import org.eclipse.jface.text.IDocument;
import org.eclipse.jface.text.IDocumentPartitioner;
import org.eclipse.jface.text.rules.FastPartitioner;

public class MumadeSetupParticipant implements IDocumentSetupParticipant {
	@Override
	public void setup(IDocument document) {
		System.out.println("MumadeSetupParticipant");
		// TODO Auto-generated method stub
		IDocumentPartitioner partitioner = new FastPartitioner(new MumadePartitionScanner(),
				MumadePartitionScanner.MUMADE_PARTITION_TYPES);
		partitioner.connect(document);
	}
}
