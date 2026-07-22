# PAC CLI Canvas App Template

Template repository for creating and deploying a Power Apps Canvas app through PAC CLI.

## What Is Included

- `client-app-brief.md`: editable brief for app requirements.
- `unpack-solution.ps1`: unpacks an exported solution zip into source format.
- `set-pac-environment.ps1`: signs in/selects PAC auth and target environment.
- `pack-and-upload.ps1`: packs canvas source, injects it into solution source, packs solution zip, and imports it.
- `powerapps-canvas-template/solution-src`: unpacked solution baseline.
- `powerapps-canvas-template/app-src`: canvas SourceCode app content to deploy.

## Prerequisites

- Github Copilot in VS Code
- Power Platform CLI installed (`pac --version`).
- Access to target environment(s).
- Permission to import solutions and publish customizations.
- Required connectors/connection references available in target environment.

## Quick Start

1. Clone this repository.
2. Update `client-app-brief.md` with project requirements.
3. Place/update app SourceCode files in `powerapps-canvas-template/app-src`.
4. Select target environment:

```powershell
.\set-pac-environment.ps1 -Environment "<environment-id-or-url>"
```

5. Deploy the app/solution:

```powershell
.\pack-and-upload.ps1
```

## First-Time Baseline Refresh (Optional)

Use this only when you export a new solution baseline zip and want to refresh `solution-src`:

```powershell
.\unpack-solution.ps1
```

Then run deploy again with `pack-and-upload.ps1`.

## Notes

- Deploy always goes to the currently selected PAC environment (`pac org who`).
- `pack-and-upload.ps1` auto-detects the `*_DocumentUri.msapp` file under `solution-src/CanvasApps`.
- If you need an extra publish step, run:

```powershell
.\pack-and-upload.ps1 -PublishAfterImport
```
