# firefly-moon

An unofficial [MoonBit](https://www.moonbitlang.com/) SDK for making
[Firefly Zero](https://fireflyzero.com/) games.

* [▶️ getting started](https://docs.fireflyzero.com/dev/getting-started/)
* [📄 api docs](https://mooncakes.io/docs/applejag/firefly)
* [🐙 github](https://github.com/applejag/firefly-go)

## Prerequisites

- `moonc` v0.6.26 (or later)
- `--target wasm` MoonBit build target, as Firefly Zero doesn't support `wasm-gc`

## Installation

```bash
moon add applejag/firefly
```

Then in your game `moon.pkg.json` specify this:

```json
{
  "is-main": true,
  "import": [{ "path": "applejag/firefly", "alias": "ff" }],
  "link": {
    "wasm": {
      "exports": ["boot", "update", "render"],
      "export-memory-name": "memory"
    }
  }
```

## Examples

You need these to run the examples:

- Clone this Git repo: <https://github.com/applejag/firefly-moon>
- MoonBit CLI (`moon`): <https://www.moonbitlang.com/download#moonbit-cli-tools>
- Taskfile CLI (`task`): <https://taskfile.dev/>
- Firefly Zero CLI (`firefly_cli`): <https://docs.fireflyzero.com/user/installation/#-cli>
- Firefly Zero emulator (`firefly-emulator`): <https://docs.fireflyzero.com/user/installation/#-emulator>

Then run one of the examples by running either of these commands:

```bash
task example/input:run

task example/shapes:run
```

## License

MIT License. You can do whatever you want with the SDK, modify it,
embed into any apps and games. Have fun!
