package com.aljoschability.eclipse.tools.promato.ui.parts;

import com.aljoschability.core.ui.CoreImages
import com.aljoschability.eclipse.tools.promato.simple.data.Manifest
import com.aljoschability.eclipse.tools.promato.simple.util.ManifestUtil
import com.aljoschability.eclipse.tools.promato.simple.util.ProjectUtil
import com.aljoschability.eclipse.tools.promato.ui.providers.HeadersLabelProvider
import com.aljoschability.eclipse.tools.promato.ui.providers.ProjectsLabelProvider
import java.lang.reflect.InvocationTargetException
import java.util.Collections
import java.util.List
import java.util.Map
import org.eclipse.core.resources.IProject
import org.eclipse.core.resources.IResourceChangeEvent
import org.eclipse.core.resources.IResourceChangeListener
import org.eclipse.core.resources.IResourceDelta
import org.eclipse.core.resources.ResourcesPlugin
import org.eclipse.core.runtime.CoreException
import org.eclipse.core.runtime.IProgressMonitor
import org.eclipse.jface.dialogs.ProgressMonitorDialog
import org.eclipse.jface.layout.GridDataFactory
import org.eclipse.jface.layout.GridLayoutFactory
import org.eclipse.jface.viewers.ArrayContentProvider
import org.eclipse.jface.viewers.CheckStateChangedEvent
import org.eclipse.jface.viewers.CheckboxTableViewer
import org.eclipse.jface.viewers.ICheckStateListener
import org.eclipse.jface.viewers.ISelectionChangedListener
import org.eclipse.jface.viewers.IStructuredSelection
import org.eclipse.jface.viewers.SelectionChangedEvent
import org.eclipse.jface.viewers.TableViewer
import org.eclipse.jface.viewers.Viewer
import org.eclipse.jface.viewers.ViewerFilter
import org.eclipse.swt.SWT
import org.eclipse.swt.custom.SashForm
import org.eclipse.swt.events.SelectionAdapter
import org.eclipse.swt.events.SelectionEvent
import org.eclipse.swt.widgets.Button
import org.eclipse.swt.widgets.Composite
import org.eclipse.swt.widgets.Group
import org.eclipse.swt.widgets.Label
import org.eclipse.swt.widgets.Table
import org.eclipse.ui.IViewSite
import org.eclipse.ui.PartInitException
import org.eclipse.ui.actions.WorkspaceModifyOperation
import org.eclipse.ui.model.WorkbenchContentProvider
import org.eclipse.ui.part.ViewPart

public class OrganizeManifestsView extends ViewPart {
	private Composite mainComposite;

	private CheckboxTableViewer projectsViewer;
	private TableViewer headersViewer;

	private Button upButton;
	private Button downButton;

	private Button applyButton;

	private IResourceChangeListener projectListener;

	private final Map<IProject, Manifest> projectHeaders;

	private final List<String> allHeaders;

	new() {
		allHeaders = newArrayList()
		projectHeaders = newLinkedHashMap()

		projectListener = [ event |
			if (ResourcesPlugin::workspace == event.source) {
				var refresh = false
				for (IResourceDelta delta : event.delta.affectedChildren) {
					if (delta.resource instanceof IProject &&
						ProjectUtil.hasManifest(delta.getResource() as IProject)) {
						refresh = true;

					//XXX: break;
					}
				}
				if (refresh && projectsViewer != null && !projectsViewer.control.disposed) {
					projectsViewer.control.display.asyncExec(
						[ |
							// projectsViewer.setInput(ResourcesPlugin.getWorkspace().getRoot());
							projectsViewer.refresh();
						])
				}
			}
		]
	}

	override createPartControl(Composite parent) {
		mainComposite = new Composite(parent, SWT.NONE);
		GridLayoutFactory.fillDefaults().applyTo(mainComposite);

		val mainSash = new SashForm(mainComposite, SWT.NONE);
		GridDataFactory.fillDefaults().grab(true, true).applyTo(mainSash);

		// projects side
		val projectsComposite = new Composite(mainSash, SWT.NONE);
		GridLayoutFactory.fillDefaults().applyTo(projectsComposite);

		fillProjectsSide(projectsComposite);

		// headers side
		val headersComposite = new Composite(mainSash, SWT.NONE);
		GridLayoutFactory.fillDefaults().applyTo(headersComposite);

		fillHeadersSide(headersComposite);

		mainSash.setWeights(#[1, 1]);

		// control section
		val controlComposite = new Composite(mainComposite, SWT.NONE);
		GridDataFactory.fillDefaults().grab(true, false).applyTo(controlComposite);
		GridLayoutFactory.fillDefaults().numColumns(2).applyTo(controlComposite);

		fillControlSection(controlComposite);
	}

	private def void fillProjectsSide(Composite parent) {
		val composite = new Composite(parent, SWT.NONE);
		GridDataFactory.fillDefaults().grab(true, true).applyTo(composite);
		GridLayoutFactory.fillDefaults().applyTo(composite);

		val group = new Group(composite, SWT.NONE);
		GridDataFactory.fillDefaults().grab(true, true).applyTo(group);
		GridLayoutFactory.fillDefaults().margins(6, 6).applyTo(group);
		group.setText("Projects");

		val table = new Table(group, SWT.BORDER.bitwiseOr(SWT.FULL_SELECTION).bitwiseOr(SWT.CHECK).bitwiseOr(SWT.MULTI));
		GridDataFactory.fillDefaults().grab(true, true).applyTo(table);
		table.setLinesVisible(true);

		projectsViewer = new CheckboxTableViewer(table);
		projectsViewer.setContentProvider(new WorkbenchContentProvider());
		projectsViewer.setLabelProvider(new ProjectsLabelProvider());
		projectsViewer.addSelectionChangedListener(
			new ISelectionChangedListener() {
				override selectionChanged(SelectionChangedEvent event) {
					handleProjectSelected(getSelectedProjects(event.getSelection() as IStructuredSelection));
				}
			});
		projectsViewer.addCheckStateListener(
			new ICheckStateListener() {
				override checkStateChanged(CheckStateChangedEvent event) {
					if (event.getElement() instanceof IProject) {
						handleProjectChecked(event.getElement() as IProject, event.getChecked());
					}
				}
			});
		projectsViewer.addFilter(
			new ViewerFilter() {
				override select(Viewer viewer, Object p, Object element) {
					if (element instanceof IProject) {
						return ProjectUtil.hasManifest(element);
					}
					return false;
				}
			});
		projectsViewer.setInput(ResourcesPlugin.getWorkspace().getRoot());
	}

	private def void fillHeadersSide(Composite parent) {
		val composite = new Composite(parent, SWT.NONE);
		GridDataFactory.fillDefaults().grab(true, true).applyTo(composite);
		GridLayoutFactory.fillDefaults().applyTo(composite);

		val group = new Group(composite, SWT.NONE);
		GridDataFactory.fillDefaults().grab(true, true).applyTo(group);
		GridLayoutFactory.fillDefaults().margins(6, 6).numColumns(2).applyTo(group);
		group.setText("Headers");

		// table
		val table = new Table(group, SWT.BORDER.bitwiseOr(SWT.FULL_SELECTION).bitwiseOr(SWT.CHECK).bitwiseOr(SWT.MULTI));
		GridDataFactory.fillDefaults().grab(true, true).applyTo(table);
		table.setLinesVisible(true);

		headersViewer = new TableViewer(table);
		headersViewer.setContentProvider(new ArrayContentProvider());
		headersViewer.setLabelProvider(new HeadersLabelProvider());
		headersViewer.addSelectionChangedListener(
			new ISelectionChangedListener() {
				override selectionChanged(SelectionChangedEvent event) {
					val headers = getSelectedHeaders(event.getSelection() as IStructuredSelection);
					handleHeaderSelection(headers);
				}
			});

		// up/down buttons
		val buttonsComposite = new Composite(group, SWT.NONE);
		GridLayoutFactory.fillDefaults().applyTo(buttonsComposite);

		upButton = new Button(buttonsComposite, SWT.PUSH);
		upButton.setEnabled(false);
		upButton.setImage(CoreImages::get(CoreImages::UP));
		upButton.setToolTipText("Move the selected header(s) upwards");
		upButton.addSelectionListener(
			new SelectionAdapter() {
				override widgetSelected(SelectionEvent e) {
					val headers = getSelectedHeaders(headersViewer.getSelection() as IStructuredSelection);
					handleMove(headers, true);
				}
			});

		downButton = new Button(buttonsComposite, SWT.PUSH);
		downButton.setEnabled(false);
		downButton.setImage(CoreImages::get(CoreImages::DOWN));
		downButton.setToolTipText("Move the selected header(s) downwards");
		downButton.addSelectionListener(
			new SelectionAdapter() {
				override widgetSelected(SelectionEvent e) {
					val headers = getSelectedHeaders(headersViewer.getSelection() as IStructuredSelection);
					handleMove(headers, false);
				}
			});
	}

	private def void fillControlSection(Composite parent) {

		// spacer
		val spacerLabel = new Label(parent, SWT.NONE);
		GridDataFactory.fillDefaults().grab(true, false).applyTo(spacerLabel);

		applyButton = new Button(parent, SWT.PUSH);
		applyButton.setEnabled(false);
		applyButton.setText("Apply");
		applyButton.addSelectionListener(
			new SelectionAdapter() {
				override widgetSelected(SelectionEvent e) {
					handleApplication();
				}
			});
	}

	override dispose() {

		// listen to workspace changes
		ResourcesPlugin.getWorkspace().removeResourceChangeListener(projectListener);

		super.dispose();
	}

	override init(IViewSite site) throws PartInitException {
		super.init(site);

		ResourcesPlugin.getWorkspace().addResourceChangeListener(projectListener, IResourceChangeEvent.POST_CHANGE);
	}

	override setFocus() {
		mainComposite.setFocus();
	}

	protected def List<String> getSelectedHeaders(IStructuredSelection selection) {
		val list = newArrayList();

		val it = selection.iterator();
		while (it.hasNext()) {
			val selected = it.next();
			if (selected instanceof String) {
				list.add(selected);
			}
		}

		return list;
	}

	protected def List<IProject> getSelectedProjects(IStructuredSelection selection) {
		val list = newArrayList();

		val it = selection.iterator();
		while (it.hasNext()) {
			val selected = it.next();
			if (selected instanceof IProject) {
				list.add(selected);
			}
		}
		return list;
	}

	protected def void handleApplication() {
		for (IProject project : projectHeaders.keySet()) {
			val manifest = projectHeaders.get(project);

			manifest.sort(allHeaders);
			try {
				val operation = new WorkspaceModifyOperation() {
					override protected execute(IProgressMonitor monitor) throws CoreException, InvocationTargetException, InterruptedException {
						ManifestUtil.write(project, manifest)
					}
				}

				new ProgressMonitorDialog(shell).run(true, false, operation)
			} catch (CoreException e) {
				e.printStackTrace();
			}
		}
	}

	def getShell() {
		if (mainComposite != null) {
			return mainComposite.shell
		}
	}

	protected def void handleHeaderSelection(List<String> headers) {

		// TODO: headers selection
		// refresh button state
		val buttonsActive = !headers.isEmpty();
		upButton.setEnabled(buttonsActive);
		downButton.setEnabled(buttonsActive);
	}

	protected def void handleMove(List<String> headers, boolean up) {
		if (up) {
			for (String header : headers) {
				val i = allHeaders.indexOf(header);

				Collections.swap(allHeaders, i, i - 1);
			}
		} else {
			Collections.reverse(headers);
			for (String header : headers) {
				val i = allHeaders.indexOf(header);

				if (up) {
					Collections.swap(allHeaders, i, i - 1);
				} else {
					Collections.swap(allHeaders, i, i + 1);
				}
			}
			Collections.reverse(headers);
		}

		// refresh list
		headersViewer.setInput(allHeaders);
	}

	protected def void handleProjectChecked(IProject project, boolean checked) {
		var countBefore = allHeaders.size();
		if (checked) {
			var Manifest manifest;

			manifest = ManifestUtil.read(project);
			projectHeaders.put(project, manifest);

			for (String name : manifest.getNames()) {
				if (!allHeaders.contains(name)) {
					allHeaders.add(name);
				}
			}
		} else {

			// remove project's headers
			var Manifest manifest = projectHeaders.remove(project);

			// remove headers that are not contained in other project
			val toRemove = newHashSet(manifest.getNames());
			for (IProject key : projectHeaders.keySet()) {
				for (String header : manifest.getNames()) {
					if (projectHeaders.get(key).contains(header)) {
						toRemove.remove(header);
					}
				}
			}

			allHeaders.removeAll(toRemove);
		}

		// refresh list if changed
		if (countBefore != allHeaders.size()) {
			headersViewer.setInput(allHeaders);
		}

		// refresh apply button state
		applyButton.setEnabled(!allHeaders.isEmpty());
	}

	protected def void handleProjectSelected(List<IProject> projects) {

		// TODO Auto-generated method stub
		System.out.println("hide/show label decoration for current selected projects");
	}
}
