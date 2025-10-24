<!--
SPDX-FileCopyrightText: 2025 Kalle Fagerberg

SPDX-License-Identifier: CC0-1.0
-->

# firefly-moon

[![REUSE status](https://api.reuse.software/badge/github.com/applejag/firefly-moon)](https://api.reuse.software/info/github.com/applejag/firefly-moon)
[![ci](https://github.com/applejag/firefly-moon/actions/workflows/ci.yml/badge.svg)](https://github.com/applejag/firefly-moon/actions/workflows/ci.yml)

An unofficial [MoonBit](https://www.moonbitlang.com/) SDK for making
[Firefly Zero](https://fireflyzero.com/) games.

* [▶️ getting started](https://docs.fireflyzero.com/dev/getting-started/)
* [📄 api docs](https://mooncakes.io/docs/applejag/firefly)
* [🐰 github](https://github.com/applejag/firefly-moon)

The SDK design is heavily inspired by the [firefly-go](https://github.com/firefly-zero/firefly-go)
and [firefly-rust](https://github.com/firefly-zero/firefly-rust) SDKs.
The type and function naming in this SDK is trying to stay as similar as
possible to the naming in the other SDKs.

## Prerequisites

- `moonc` v0.6.29 (or later)
- `--target wasm` MoonBit build target, as Firefly Zero doesn't support `wasm-gc`

## Installation

```bash
moon add applejag/firefly
```

Then in your game `moon.pkg.json` specify this:

```json
{
  "is-main": true,
  "import": [
    "applejag/firefly"
  ],
  "link": {
    "wasm": {
      "exports": ["boot", "update", "render", "before_exit"],
      "export-memory-name": "memory"
    }
  }
}
```

Then create a `main.mbt` file like so:

```moonbit
///|
/// `main` is called immediately on startup.
///
/// MoonBit requires the presence of a `main` function, but Firely Zero
/// recommends that you use `boot` for any initialization logic.
fn main {
  // keep this function empty
}

///|
/// `boot` is only called once, after all the memory is initialized and all
/// runtime functions are available but before any other callback is called.
///
/// This is the best place to load fonts, sprites, and other assets,
/// initialize the default state, read configurations, etc.
pub fn boot() -> Unit {
  @firefly.log_debug("entering boot") // placeholder for demonstration purposes
}

///|
/// `before_exit` is called before the app is closed.
pub fn before_exit() -> Unit {
  @firefly.log_debug("entering before_exit") // placeholder for demonstration purposes
}

///|
/// `update` is called ~60 times per second.
///
/// It is guaranteed to be never called more often, and it won’t be called less
/// often if the game doesn’t consume too much resources.
/// This is the best place to update the state of objects, position of NPCs,
/// read and handle user input, etc.
pub fn update() -> Unit {
  @firefly.log_debug("entering update") // placeholder for demonstration purposes
}

///|
/// `render` is called before updating the image on the screen.
///
/// It might be called less often than `update` if the device sees that the game
/// is slow and needs more resources.
/// This is the best place to call all drawing functions.
pub fn render() -> Unit {
  @firefly.log_debug("entering render") // placeholder for demonstration purposes
}
```

Firefly's CLI (`firefly_cli`) can't automatically build the project for you,
so you'll need to build it manually each time with `moon` CLI and tell Firefly
to just use the binary from `target/...` directory.

To do so, configure the `_bin` file in your `firefly.toml` like so:

```toml
author_id = "yourname"
app_id = "your-app-id"
author_name = "Your Name"
app_name = "Your App Name"

[files]
_bin = { path = "./target/wasm/release/build/<moonbit app name>.wasm", copy = true }
```

Building and running can then be done by running:

```bash
moon build --target wasm
firefly_cli build

firefly-emulator --id yourname.your-app-id
```

## Examples

See the [./example](./example) directory for example MoonBit modules.

## License

MIT License. You can do whatever you want with the SDK, modify it,
embed into any apps and games. Have fun!
