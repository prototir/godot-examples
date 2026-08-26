# Prototir Godot examples

A small Godot 4.3+ project demonstrating the official
[Prototir Godot SDK](https://github.com/prototir/godot-sdk). The scene reports readiness, events,
scores, persistent storage, and a managed AI request while remaining playable in the editor through
the SDK's local mocks.

Godot does not currently provide a general-purpose package manager for project addons, so this
repository vendors `addons/prototir` from SDK `v0.1.0`. The copied addon retains its MIT license and
version metadata. Update it only from a reviewed SDK tag.

## Open the project

1. Install the standard Godot Engine 4.3 or newer. The .NET build is not required.
2. Clone this repository and import `project.godot` in the Project Manager.
3. Open the **Prototir** dock and resolve every blocking issue.
4. Run `main.tscn`.

The example configures a local managed-AI mock in the editor. A Web export uses the real Prototir
player and requires managed AI to be enabled for the uploaded prototype.

## Export and upload

1. Open **Project > Export** and select the included Web preset.
2. Export a non-debug build to `build/index.html`.
3. ZIP the contents of `build`, not the directory itself.
4. Upload the ZIP to Prototir and test resize, fullscreen, focus, storage, and console diagnostics.

Run the lightweight repository check with Node.js 20 or newer:

```bash
node tools/check.mjs
```

See the [Godot creator guide](https://prototir.com/docs/creators?runtime=godot#setup) for the complete
supported profile.
