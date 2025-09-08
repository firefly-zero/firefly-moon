///|
/// Returns the WASM object address to a `FixedArray[Byte]` object.
///
/// > Warning: not implemented in `--target wasm-gc`. This function is only here
/// > to make intellisense happy in code editors that don't understand we are
/// > using `wasm` and not `wasm-gc`.
/// >
/// > This function does have an implementation for `--target wasm`.
pub fn get_addr_fixedbytes(_ : FixedArray[Byte]) -> UInt {
  panic() // unsupported on wasm-gc, but this function is here to satisfy my stupid editor
}

///|
/// Returns the WASM object address to a `Bytes` object.
///
/// > Warning: not implemented in `--target wasm-gc`. This function is only here
/// > to make intellisense happy in code editors that don't understand we are
/// > using `wasm` and not `wasm-gc`.
/// >
/// > This function does have an implementation for `--target wasm`.
pub fn get_addr_bytes(_ : Bytes) -> UInt {
  panic() // unsupported on wasm-gc, but this function is here to satisfy my stupid editor
}
