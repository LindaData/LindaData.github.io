const STORAGE_KEYS = {
  feedback: "recycling-public-feedback-v1",
  audit: "recycling-admin-audit-v1"
};

function readStoredJson(key, fallback) {
  try {
    const raw = localStorage.getItem(key);
    return raw ? JSON.parse(raw) : fallback;
  } catch {
    return fallback;
  }
}

const state = {
  filter: "open",
  feedback: readStoredJson(STORAGE_KEYS.feedback, []),
  audit: readStoredJson(STORAGE_KEYS.audit, []),
  selectedId: null
};

const elements = {
  statusMeta: document.getElementById("status-meta"),
  statsGrid: document.getElementById("stats-grid"),
  queueFilters: document.getElementById("queue-filters"),
  queueList: document.getElementById("queue-list"),
  detailTitle: document.getElementById("detail-title"),
  detailPanel: document.getElementById("detail-panel"),
  startReview: document.getElementById("start-review"),
  needsData: document.getElementById("needs-data"),
  resolveRequest: document.getElementById("resolve-request"),
  ruleMunicipality: document.getElementById("rule-municipality"),
  ruleOutcome: document.getElementById("rule-outcome"),
  ruleItem: document.getElementById("rule-item"),
  ruleEffective: document.getElementById("rule-effective"),
  ruleSource: document.getElementById("rule-source"),
  ruleCopyEn: document.getElementById("rule-copy-en"),
  ruleCopyEs: document.getElementById("rule-copy-es"),
  saveDraft: document.getElementById("save-draft"),
  publishRule: document.getElementById("publish-rule"),
  checklistPanel: document.getElementById("checklist-panel"),
  auditLog: document.getElementById("audit-log")
};

const filterOptions = [
  { key: "open", label: "Open" },
  { key: "new", label: "New" },
  { key: "reviewing", label: "Reviewing" },
  { key: "resolved", label: "Resolved" },
  { key: "needs_data", label: "Needs data" }
];

const municipalities = {
  riverton: "Riverton",
  lakewood: "Lakewood",
  "sunset-hills": "Sunset Hills"
};

function escapeHtml(value) {
  return String(value)
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll("\"", "&quot;")
    .replaceAll("'", "&#39;");
}

function saveFeedbackStore() {
  localStorage.setItem(STORAGE_KEYS.feedback, JSON.stringify(state.feedback));
}

function saveAuditStore() {
  localStorage.setItem(STORAGE_KEYS.audit, JSON.stringify(state.audit));
}

function formatDate(value) {
  if (!value) {
    return "Unknown date";
  }

  return new Intl.DateTimeFormat("en-US", {
    month: "short",
    day: "numeric",
    hour: "numeric",
    minute: "2-digit"
  }).format(new Date(value));
}

function statusLabel(status) {
  if (status === "resolved") return "Resolved";
  if (status === "reviewing") return "Reviewing";
  if (status === "needs_data") return "Needs data";
  return "New";
}

function typeLabel(type) {
  if (type === "rule") return "Local rule";
  if (type === "center") return "Center correction";
  if (type === "business") return "Business submission";
  return "Unknown item";
}

function filteredFeedback() {
  if (state.filter === "open") {
    return state.feedback.filter((entry) => entry.status !== "resolved");
  }

  return state.feedback.filter((entry) => entry.status === state.filter);
}

function selectedEntry() {
  return state.feedback.find((entry) => entry.id === state.selectedId) || null;
}

function ensureSelection() {
  const visible = filteredFeedback();
  if (visible.some((entry) => entry.id === state.selectedId)) {
    return;
  }
  state.selectedId = visible[0] ? visible[0].id : null;
}

function addAudit(message) {
  state.audit.unshift({
    id: `audit-${Date.now()}`,
    message,
    timestamp: Date.now()
  });
  state.audit = state.audit.slice(0, 24);
  saveAuditStore();
}

function updateStatusMeta() {
  const openCount = state.feedback.filter((entry) => entry.status !== "resolved").length;
  elements.statusMeta.textContent = openCount
    ? `${openCount} open verification request${openCount === 1 ? "" : "s"}`
    : "Waiting for verification requests";
}

function renderStats() {
  const open = state.feedback.filter((entry) => entry.status !== "resolved").length;
  const reviewing = state.feedback.filter((entry) => entry.status === "reviewing").length;
  const resolved = state.feedback.filter((entry) => entry.status === "resolved").length;
  const coverageGaps = state.feedback.filter((entry) => entry.type === "unknown").length;

  const cards = [
    { label: "Open requests", value: open, copy: "Resident or business items awaiting review" },
    { label: "In review", value: reviewing, copy: "Items currently being investigated" },
    { label: "Resolved", value: resolved, copy: "Requests already closed in this local queue" },
    { label: "Coverage gaps", value: coverageGaps, copy: "Unknown-item reports that may need new catalog data" }
  ];

  elements.statsGrid.innerHTML = cards.map((card) => `
    <article class="card stat">
      <p class="eyebrow">${card.label}</p>
      <strong>${card.value}</strong>
      <span>${card.copy}</span>
    </article>
  `).join("");
}

function renderFilters() {
  elements.queueFilters.innerHTML = filterOptions.map((filter) => `
    <button
      class="filter-chip${state.filter === filter.key ? " is-active" : ""}"
      type="button"
      data-filter="${filter.key}"
    >
      ${filter.label}
    </button>
  `).join("");

  elements.queueFilters.querySelectorAll("[data-filter]").forEach((button) => {
    button.addEventListener("click", () => {
      state.filter = button.getAttribute("data-filter");
      ensureSelection();
      renderAll();
    });
  });
}

function renderQueue() {
  const items = filteredFeedback();
  elements.queueList.innerHTML = "";

  if (!items.length) {
    elements.queueList.innerHTML = `<div class="empty-state">No requests match this filter yet. Submit from the consumer app to populate the queue.</div>`;
    return;
  }

  items.forEach((entry) => {
    const item = document.createElement("button");
    item.className = `queue-card${entry.id === state.selectedId ? " is-active" : ""}`;
    item.type = "button";
    item.innerHTML = `
      <strong>${escapeHtml(entry.itemName || "Unlabeled request")}</strong>
      <p class="queue-copy">${escapeHtml(entry.note || "No notes provided.")}</p>
      <div class="queue-meta">
        <span class="mini-pill status-${entry.status}">${statusLabel(entry.status)}</span>
        <span class="mini-pill">${typeLabel(entry.type)}</span>
        <span class="mini-pill">${municipalities[entry.municipality] || "No municipality"}</span>
      </div>
    `;
    item.addEventListener("click", () => {
      state.selectedId = entry.id;
      loadEntryIntoEditor(entry);
      renderAll();
    });
    elements.queueList.appendChild(item);
  });
}

function renderDetail() {
  const entry = selectedEntry();
  if (!entry) {
    elements.detailTitle.textContent = "Select a request";
    elements.detailPanel.innerHTML = `<div class="empty-state">Choose a request from the queue to inspect resident context, contact details, and review actions.</div>`;
    updateActionButtons();
    return;
  }

  elements.detailTitle.textContent = entry.itemName || "Verification request";
  elements.detailPanel.innerHTML = `
    <div class="detail-card">
      <strong>${typeLabel(entry.type)}</strong>
      <div class="detail-meta">
        <span class="mini-pill status-${entry.status}">${statusLabel(entry.status)}</span>
        <span class="mini-pill">${municipalities[entry.municipality] || "No municipality"}</span>
        ${entry.barcode ? `<span class="mini-pill">${entry.barcode}</span>` : ""}
        <span class="mini-pill">${formatDate(entry.createdAt)}</span>
      </div>
      ${entry.note ? `<p>${escapeHtml(entry.note)}</p>` : ""}
      ${entry.business ? `<p><strong>Business:</strong> ${escapeHtml(entry.business)}</p>` : ""}
      ${entry.contact ? `<p><strong>Contact:</strong> ${escapeHtml(entry.contact)}</p>` : ""}
      ${entry.url ? `<p><strong>Review link:</strong> <a href="${entry.url}" target="_blank" rel="noreferrer">${escapeHtml(entry.url)}</a></p>` : ""}
    </div>
  `;

  updateActionButtons();
}

function checklistItems() {
  return [
    {
      label: "Source URL captured",
      done: Boolean(elements.ruleSource.value.trim())
    },
    {
      label: "Effective date recorded",
      done: Boolean(elements.ruleEffective.value)
    },
    {
      label: "English guidance drafted",
      done: Boolean(elements.ruleCopyEn.value.trim())
    },
    {
      label: "Spanish guidance drafted",
      done: Boolean(elements.ruleCopyEs.value.trim())
    },
    {
      label: "A request is selected for this update",
      done: Boolean(selectedEntry())
    }
  ];
}

function canPublish() {
  return checklistItems().every((item) => item.done);
}

function renderChecklist() {
  elements.checklistPanel.innerHTML = checklistItems().map((item) => `
    <div class="checklist-item">
      <strong>${item.label}</strong>
      <p>${item.done ? "Ready" : "Still needed before publishing"}</p>
    </div>
  `).join("");

  elements.publishRule.disabled = !canPublish();
}

function renderAudit() {
  elements.auditLog.innerHTML = "";

  if (!state.audit.length) {
    elements.auditLog.innerHTML = `<div class="empty-state">Audit entries will appear after draft saves, status changes, and publish actions.</div>`;
    return;
  }

  state.audit.slice(0, 10).forEach((entry) => {
    const item = document.createElement("div");
    item.className = "audit-item";
    item.innerHTML = `
      <strong>${formatDate(entry.timestamp)}</strong>
      <p>${entry.message}</p>
    `;
    elements.auditLog.appendChild(item);
  });
}

function loadEntryIntoEditor(entry) {
  elements.ruleMunicipality.value = entry.municipality || "riverton";
  elements.ruleItem.value = entry.itemName || "";
  elements.ruleOutcome.value = entry.type === "center" ? "drop_off" : entry.type === "rule" ? "check_locally" : "recycle";
  elements.ruleSource.value = entry.sourceUrl || "";
  elements.ruleCopyEn.value = entry.note || "";
  elements.ruleCopyEs.value = entry.note || "";
}

function updateActionButtons() {
  const entry = selectedEntry();
  const hasEntry = Boolean(entry);
  elements.startReview.disabled = !hasEntry;
  elements.needsData.disabled = !hasEntry;
  elements.resolveRequest.disabled = !hasEntry;
}

function updateSelectedEntryStatus(status) {
  const entry = selectedEntry();
  if (!entry) {
    return;
  }

  entry.status = status;
  entry.updatedAt = Date.now();
  saveFeedbackStore();
  addAudit(`${statusLabel(status)} request for ${entry.itemName || "unlabeled item"} in ${municipalities[entry.municipality] || "unknown municipality"}.`);
  renderAll();
}

function saveDraft() {
  const entry = selectedEntry();
  addAudit(`Saved draft guidance for ${elements.ruleItem.value.trim() || (entry ? entry.itemName : "unlabeled request")} (${municipalities[elements.ruleMunicipality.value] || "unknown municipality"}).`);
  renderAudit();
}

function publishRule() {
  const entry = selectedEntry();
  if (!canPublish()) {
    return;
  }

  if (entry) {
    entry.status = "resolved";
    entry.updatedAt = Date.now();
  }
  saveFeedbackStore();
  addAudit(`Published prototype rule update for ${elements.ruleItem.value.trim() || (entry ? entry.itemName : "unlabeled request")} with source ${elements.ruleSource.value.trim()}.`);
  renderAll();
}

function renderAll() {
  ensureSelection();
  updateStatusMeta();
  renderStats();
  renderFilters();
  renderQueue();
  renderDetail();
  renderChecklist();
  renderAudit();
}

elements.startReview.addEventListener("click", () => {
  updateSelectedEntryStatus("reviewing");
});

elements.needsData.addEventListener("click", () => {
  updateSelectedEntryStatus("needs_data");
});

elements.resolveRequest.addEventListener("click", () => {
  updateSelectedEntryStatus("resolved");
});

elements.saveDraft.addEventListener("click", () => {
  saveDraft();
});

elements.publishRule.addEventListener("click", () => {
  publishRule();
});

[
  elements.ruleMunicipality,
  elements.ruleOutcome,
  elements.ruleItem,
  elements.ruleEffective,
  elements.ruleSource,
  elements.ruleCopyEn,
  elements.ruleCopyEs
].forEach((field) => {
  field.addEventListener("input", () => {
    renderChecklist();
  });
  field.addEventListener("change", () => {
    renderChecklist();
  });
});

window.addEventListener("storage", (event) => {
  if (event.key === STORAGE_KEYS.feedback) {
    state.feedback = readStoredJson(STORAGE_KEYS.feedback, []);
    renderAll();
  }

  if (event.key === STORAGE_KEYS.audit) {
    state.audit = readStoredJson(STORAGE_KEYS.audit, []);
    renderAudit();
  }
});

renderAll();
