package com.aljoschability.eclipse.tools.bumauni.ui.parts;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;

import org.eclipse.e4.ui.di.Focus;
import org.eclipse.jface.viewers.TableViewer;
import org.eclipse.swt.SWT;
import org.eclipse.swt.layout.GridData;
import org.eclipse.swt.layout.GridLayout;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Group;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.TabFolder;
import org.eclipse.swt.widgets.TabItem;
import org.eclipse.swt.widgets.Table;
import org.eclipse.swt.widgets.TableColumn;
import org.eclipse.swt.widgets.Text;

public class BuhemaPartJava {
	private Table specificTable;
	private Text generalVendorText;
	private Text generalPrefixText;
	private Text generalSuffixText;

	public BuhemaPartJava() {
	}

	/**
	 * Create contents of the view part.
	 */
	@PostConstruct
	public void createControls(Composite parent) {
		parent.setLayout(new GridLayout(1, false));

		Composite crap = new Composite(parent, SWT.NONE);
		crap.setLayoutData(new GridData(SWT.FILL, SWT.FILL, true, true, 1, 1));
		crap.setLayout(new GridLayout(1, false));

		TabFolder actionTabs = new TabFolder(crap, SWT.NONE);
		actionTabs.setLayoutData(new GridData(SWT.FILL, SWT.FILL, true, true, 1, 1));
		actionTabs.setSize(418, 253);

		TabItem namingTab = new TabItem(actionTabs, SWT.NONE);
		namingTab.setText("Naming");

		TabItem versioningTab = new TabItem(actionTabs, SWT.NONE);
		versioningTab.setText("Versioning");

		Composite versioningComposite = new Composite(actionTabs, SWT.NONE);
		versioningTab.setControl(versioningComposite);
		versioningComposite.setLayout(new GridLayout(1, false));

		TabItem problemsTab = new TabItem(actionTabs, SWT.NONE);
		problemsTab.setText("Problems");

		Composite problemsComposite = new Composite(actionTabs, SWT.NONE);
		problemsTab.setControl(problemsComposite);

		Composite controlComposite = new Composite(crap, SWT.NONE);
		controlComposite.setLayoutData(new GridData(SWT.FILL, SWT.FILL, true, false, 1, 1));
		controlComposite.setBounds(0, 0, 64, 64);
		controlComposite.setLayout(new GridLayout(3, false));

		Label controlImage = new Label(controlComposite, SWT.NONE);
		controlImage.setLayoutData(new GridData(SWT.CENTER, SWT.CENTER, false, false, 1, 1));

		Label controlLabel = new Label(controlComposite, SWT.NONE);
		controlLabel.setLayoutData(new GridData(SWT.FILL, SWT.CENTER, true, false, 1, 1));
		controlLabel.setBounds(0, 0, 55, 15);
		controlLabel.setText("Status");

		Button controlButton = new Button(controlComposite, SWT.NONE);
		controlButton.setLayoutData(new GridData(SWT.CENTER, SWT.CENTER, false, false, 1, 1));
		controlButton.setBounds(0, 0, 75, 25);
		controlButton.setText("Apply");

		Composite composite_1 = new Composite(parent, SWT.NONE);

																												Group generalGroup = new Group(composite_1, SWT.NONE);
																												generalGroup.setText("Common");
																												generalGroup.setBounds(0, 0, 410, 101);
																												generalGroup.setLayout(new GridLayout(2, false));

																														Label generalPrefixLabel = new Label(generalGroup, SWT.NONE);
																														generalPrefixLabel.setLayoutData(new GridData(SWT.RIGHT, SWT.CENTER, false, false, 1, 1));
																														generalPrefixLabel.setText("Project");

																																generalPrefixText = new Text(generalGroup, SWT.BORDER);
																																generalPrefixText.setLayoutData(new GridData(SWT.FILL, SWT.CENTER, true, false, 1, 1));

																																		Label generalSuffixLabel = new Label(generalGroup, SWT.NONE);
																																		generalSuffixLabel.setLayoutData(new GridData(SWT.RIGHT, SWT.CENTER, false, false, 1, 1));
																																		generalSuffixLabel.setText("Suffix");

																																				generalSuffixText = new Text(generalGroup, SWT.BORDER);
																																				generalSuffixText.setLayoutData(new GridData(SWT.FILL, SWT.CENTER, true, false, 1, 1));

																																						Label generalVendorLabel = new Label(generalGroup, SWT.NONE);
																																						generalVendorLabel.setLayoutData(new GridData(SWT.RIGHT, SWT.CENTER, false, false, 1, 1));
																																						generalVendorLabel.setText("Provider");

																																								generalVendorText = new Text(generalGroup, SWT.BORDER);
																																								generalVendorText.setLayoutData(new GridData(SWT.FILL, SWT.CENTER, true, false, 1, 1));
																																								generalVendorText.setBounds(0, 0, 76, 21);

																																										Group specificGroup = new Group(composite_1, SWT.NONE);
																																										specificGroup.setSize(410, 25);
																																										specificGroup.setText("Project Specific");
																																										specificGroup.setLayout(new GridLayout(1, false));

																																												TableViewer specificViewer = new TableViewer(specificGroup, SWT.BORDER | SWT.FULL_SELECTION);
																																												specificTable = specificViewer.getTable();
																																												specificTable.setLinesVisible(true);
																																												specificTable.setHeaderVisible(true);
																																												specificTable.setLayoutData(new GridData(SWT.FILL, SWT.FILL, true, true, 1, 1));
																																												specificTable.setBounds(0, 0, 85, 85);

																																														TableColumn specificNameTableColumn = new TableColumn(specificTable, SWT.NONE);
																																														specificNameTableColumn.setWidth(100);
																																														specificNameTableColumn.setText("Project");

																																																TableColumn specificVersionTableColumn = new TableColumn(specificTable, SWT.NONE);
																																																specificVersionTableColumn.setWidth(100);
																																																specificVersionTableColumn.setText("Name");
	}

	@PreDestroy
	public void dispose() {
	}

	@Focus
	public void setFocus() {
		// TODO Set the focus to control
	}
}
