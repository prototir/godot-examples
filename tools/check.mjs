import assert from 'node:assert/strict';
import { existsSync, readFileSync } from 'node:fs';

const read = (path) => readFileSync(new URL(`../${path}`, import.meta.url), 'utf8');
for (const path of [
  'addons/prototir/plugin.cfg',
  'addons/prototir/prototir.gd',
  'main.gd',
  'main.tscn',
  'project.godot',
  'export_presets.cfg',
  'prototir.json'
]) assert.ok(existsSync(new URL(`../${path}`, import.meta.url)), `Missing ${path}`);

assert.match(read('addons/prototir/plugin.cfg'), /version="0\.1\.0"/);
assert.match(read('project.godot'), /config\/features=PackedStringArray\("4\.3"\)/);
assert.match(read('project.godot'), /renderer\/rendering_method="gl_compatibility"/);
const manifest = JSON.parse(read('prototir.json'));
assert.equal(manifest.runtime?.engine, 'godot');
assert.equal(manifest.runtime?.profile, 'standard');
assert.equal(manifest.ai?.mode, 'managed');
assert.match(read('main.gd'), /Prototir\.ready\(\)/);

console.log('Godot example structure checks passed.');
