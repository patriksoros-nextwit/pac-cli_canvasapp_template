# Client App Brief

---

## How to Use This File

This document is filled in by you (the consultant) right after the initial discovery meeting with the client. It is then handed to Copilot together with `component-kit-reference.md` to generate the first version of the Canvas App.

**Step-by-step:**

1. **Duplicate this file** — never edit the blank template directly. Save a copy named after the client, e.g. `contoso-app-brief.md`
2. **Fill in during or right after the meeting** — the more detail you capture while it's fresh, the better the output
3. **Replace placeholder text** — anywhere you see `[e.g. ...]` or a blank after a colon, that is where you write
4. **HTML comments are hints, not fields** — lines that look `<!-- like this -->` are instructions for you, not things to fill in. You can delete them once you've read them
5. **Required vs optional** — fields marked `<!-- required -->` must be filled in. Everything else helps but won't block generation
6. **Data sources** — tick the checkbox that applies (existing sources or no data yet), then only fill in that sub-section
7. **Screens** — add one bullet block per screen. Copy and paste the example block to add more. List them in the order a user would navigate through the app
8. **Component Mapping** — leave blank if unsure. Copilot will pick from the kit automatically. Only fill in if the client or your team has a specific preference
9. **User Flows** — write these as simple arrows: `Home → List → Detail → Back to Home`. One flow per main task the app needs to support
10. **When done** — open a new Copilot chat, attach this file and `component-kit-reference.md`, and send it. No extra prompt needed — the instructions at the bottom of this file tell Copilot what to do

---

## Project Info

- **App Name:** <!-- required — e.g. "Equipment Request Tracker" -->
- **Client / Department:** <!-- required -->
- **Meeting Date:** <!-- required — YYYY-MM-DD -->
- **Filled in by:** <!-- required — your name -->
- **Layout:** [Tablet | Phone]
- **Component Library Name:** [Exact name of the component kit in the environment, e.g., 'Contoso_Standard_UI_Kit']
- **Target Environment ID/Name:** [Environment Name or GUID]
---

## Purpose

<!-- required — 2–3 sentences answering: what problem does this solve, for whom, and why now? -->

---

## Users

- **Primary users:** <!-- e.g. field technicians, warehouse staff -->
- **Admin / manager users:** <!-- e.g. team leads, department managers — leave blank if none -->
- **Estimated total users:** <!-- approximate number -->

---

## Data Sources

<!-- Mark which situation applies, then fill in the relevant part only -->

- [ ] **Data sources already exist** — fill in the table below
- [ ] **No data yet** — describe what data is needed conceptually in plain text

### If sources exist

<!-- Type options: SharePoint List, Dataverse Table, SQL Table, Excel (OneDrive), Teams, Other -->
<!-- Copy and paste the block below for each additional source -->

- **Source name:** 
  - **Type:** <!-- SharePoint List / Dataverse Table / SQL Table / Excel / Teams / Other -->
  - **Details:** <!-- e.g. site URL, list name, table name -->

- **Source name:** 
  - **Type:** 
  - **Details:** 

### If no data yet

<!-- Describe each "thing" the app needs to store or read, as you'd explain it to the client -->
<!-- The AI will use this to propose a data model and placeholder structure -->
<!-- Example: "A list of employees with their name, department, and manager" -->

- 
- 
-

---

## Component Mapping

<!-- The component kit lives as a Canvas component library app in the target environment. -->
<!-- Copilot will download it via PAC CLI to get the exact component names. -->
<!-- Only fill this in if you want to override the automatic selection for a specific screen. -->
<!-- Leave blank to let Copilot pick the right components from the kit automatically. -->

- **Header:** <!-- leave blank to auto-select, or e.g. cmp_StandardHeader -->
- **Navigation / Menu:** <!-- e.g. cmp_SideNav -->
- **List / Gallery:** <!-- e.g. cmp_CardList -->
- **Form:** <!-- e.g. cmp_DataCard -->
- **Buttons:** <!-- e.g. cmp_PrimaryButton, cmp_SecondaryButton -->
- **Other:** <!-- any additional components specific to this app -->

---

## Screens

<!-- required — list screens in navigation order -->
<!-- "Who sees it" options: All users, Primary users only, Admin only -->
<!-- "Components" — names from the Component Mapping section above, or leave blank for Copilot to decide -->
<!-- Copy and paste the block below for each additional screen -->

- **Screen1:** Home
  - **Purpose:** Landing / navigation hub
  - **Who sees it:** All users
  - **Key actions:** Navigate to main sections
  - **Navigates to:** 
  - **Components:** <!-- e.g. cmp_StandardHeader, cmp_SideNav -->

- **Screen2:** 
  - **Purpose:** 
  - **Who sees it:** 
  - **Key actions:** 
  - **Navigates to:** 
  - **Components:** 

- **Screen3:** 
  - **Purpose:** 
  - **Who sees it:** 
  - **Key actions:** 
  - **Navigates to:** 
  - **Components:** 

---

## User Flows

<!-- Describe the key end-to-end journeys a user takes to complete a task -->
<!-- Format: Flow name → Step 1 screen → Step 2 screen → ... → End state -->
<!-- Add one flow per common task. Focus on the 2–3 most important ones. -->

**Flow 1 — [e.g. Submit a new request]:**  
Home → [Screen] → [Screen] → [e.g. Success message / back to Home]

**Flow 2 — [e.g. Manager approves a request]:**  
[Screen] → [Screen] → [End state]

**Flow 3 — [optional]:**  

---

## Business Rules

<!-- List any logic, constraints, or flow rules that must be enforced -->
<!-- Examples: approval steps, status transitions, role-based visibility, required fields -->

- 
- 
- 

---

## Complexity

Mark one:

- [ ] **Simple** — 3–5 screens, one data source, no approvals, no roles
- [ ] **Medium** — 5–8 screens, multiple data sources, some conditional logic or roles
- [ ] **Complex** — 8+ screens, approval workflows, multiple roles, external integrations

---

## Additional Notes

<!-- Anything else relevant:  known constraints, client preferences, follow-up questions -->

---

## Instructions for Copilot

*Act as a Power Platform developer. Using the PAC CLI Canvas YAML format (`.pa.yaml`), generate the source code for this app based on the specification above. Follow these rules:*

1. *Run `pac env select` to target the correct environment, then `pac canvas list` and `pac canvas download` to retrieve the component library named in `component-kit-reference.md` before writing any screen YAML*
2. *Every UI element — buttons, colors, headers, navigation, forms, inputs, badges, icons, dialogs, and any other visual control — must come from the downloaded component library. Do not use any standard out-of-the-box Power Apps controls. If the kit does not have a component for something, flag it as a `# TODO: no kit component available` comment and leave a placeholder*
3. *If data sources are not yet defined, generate the app using in-memory collections as placeholders and add a `# TODO:` comment where real bindings should be added later*
4. *Apply navigation exactly as described in the User Flows section using `Navigate()` formulas*
5. *Enforce all business rules via Power Fx formulas*
6. *Generate one `.pa.yaml` file per screen plus the root `App.pa.yaml`*

