///|
/// Audio sample rate, set to a constant 44100
pub const SAMPLE_RATE : UInt = 44_100

///|
pub(all) enum Pitch {
  C
  Cs
  D
  Ds
  E
  F
  Fs
  G
  Gs
  A
  As
  B
} derive(Show, Eq, Compare, Hash)

///|
pub fn Pitch::from_char(char : Char) -> Pitch? {
  match char {
    'A' => Some(A)
    'B' => Some(B)
    'C' => Some(C)
    'D' => Some(D)
    'E' => Some(E)
    'F' => Some(F)
    'G' => Some(G)
    _ => None
  }
}

///|
/// Audio frequency in Hz
pub type Hz = Float

///|
/// C0, MIDI note #12
pub const C0 : Hz = 16.351

///|
pub const CS0 : Hz = 17.324

///|
pub const D0 : Hz = 18.354

///|
pub const DS0 : Hz = 19.445

///|
pub const E0 : Hz = 20.601

///|
pub const F0 : Hz = 21.827

///|
pub const FS0 : Hz = 23.124

///|
pub const G0 : Hz = 24.499

///|
pub const GS0 : Hz = 25.956

///|
/// A0, the lowest note of a piano
pub const A0 : Hz = 27.5

///|
pub const AS0 : Hz = 29.135

///|
/// B0, the lowest note of a 5 string bass
pub const B0 : Hz = 30.868

///|
/// C1, the lowest note of double bass with C extension
pub const C1 : Hz = 32.703

///|
pub const CS1 : Hz = 34.648

///|
pub const D1 : Hz = 36.708

///|
pub const DS1 : Hz = 38.891

///|
/// E1, the lowest note of a bass
pub const E1 : Hz = 41.203

///|
pub const F1 : Hz = 43.654

///|
pub const FS1 : Hz = 46.249

///|
pub const G1 : Hz = 48.999

///|
pub const GS1 : Hz = 51.913

///|
pub const A1 : Hz = 55.0

///|
pub const AS1 : Hz = 58.27

///|
pub const B1 : Hz = 61.735

///|
pub const C2 : Hz = 65.406

///|
pub const CS2 : Hz = 69.296

///|
pub const D2 : Hz = 73.416

///|
pub const DS2 : Hz = 77.782

///|
/// E2, the lowest note of a guitar.
pub const E2 : Hz = 82.407

///|
pub const F2 : Hz = 87.307

///|
pub const FS2 : Hz = 92.499

///|
pub const G2 : Hz = 97.999

///|
pub const GS2 : Hz = 103.826

///|
pub const A2 : Hz = 110.0

///|
pub const AS2 : Hz = 116.541

///|
pub const B2 : Hz = 123.471

///|
pub const C3 : Hz = 130.813

///|
pub const CS3 : Hz = 138.591

///|
pub const D3 : Hz = 146.832

///|
pub const DS3 : Hz = 155.563

///|
pub const E3 : Hz = 164.814

///|
pub const F3 : Hz = 174.614

///|
pub const FS3 : Hz = 184.997

///|
/// G3, the lowest note of a violin.
pub const G3 : Hz = 195.998

///|
pub const GS3 : Hz = 207.652

///|
pub const A3 : Hz = 220.0

///|
pub const AS3 : Hz = 233.082

///|
pub const B3 : Hz = 246.942

///|
/// C4, the "middle C".
pub const C4 : Hz = 261.626

///|
pub const CS4 : Hz = 277.183

///|
pub const D4 : Hz = 293.665

///|
pub const DS4 : Hz = 311.127

///|
pub const E4 : Hz = 329.628

///|
pub const F4 : Hz = 349.228

///|
pub const FS4 : Hz = 369.994

///|
pub const G4 : Hz = 391.995

///|
pub const GS4 : Hz = 415.305

///|
/// A4, the tuning reference note.
pub const A4 : Hz = 440.0

///|
pub const AS4 : Hz = 466.164

///|
pub const B4 : Hz = 493.883

///|
pub const C5 : Hz = 523.251

///|
pub const CS5 : Hz = 554.365

///|
pub const D5 : Hz = 587.33

///|
pub const DS5 : Hz = 622.254

///|
pub const E5 : Hz = 659.255

///|
pub const F5 : Hz = 698.456

///|
pub const FS5 : Hz = 739.989

///|
pub const G5 : Hz = 783.991

///|
pub const GS5 : Hz = 830.609

///|
pub const A5 : Hz = 880.0

///|
pub const AS5 : Hz = 932.328

///|
pub const B5 : Hz = 987.767

///|
pub const C6 : Hz = 1046.502

///|
pub const CS6 : Hz = 1108.731

///|
pub const D6 : Hz = 1174.659

///|
pub const DS6 : Hz = 1244.508

///|
pub const E6 : Hz = 1318.51

///|
pub const F6 : Hz = 1396.913

///|
pub const FS6 : Hz = 1479.978

///|
pub const G6 : Hz = 1567.982

///|
pub const GS6 : Hz = 1661.219

///|
pub const A6 : Hz = 1760.0

///|
pub const AS6 : Hz = 1864.655

///|
pub const B6 : Hz = 1975.533

///|
pub const C7 : Hz = 2093.005

///|
pub const CS7 : Hz = 2217.461

///|
pub const D7 : Hz = 2349.318

///|
pub const DS7 : Hz = 2489.016

///|
pub const E7 : Hz = 2637.021

///|
pub const F7 : Hz = 2793.826

///|
pub const FS7 : Hz = 2959.955

///|
pub const G7 : Hz = 3135.964

///|
pub const GS7 : Hz = 3322.438

///|
pub const A7 : Hz = 3520.0

///|
pub const AS7 : Hz = 3729.31

///|
pub const B7 : Hz = 3951.066

///|
/// C8, the highest note of a piano.
pub const C8 : Hz = 4186.009

///|
pub const CS8 : Hz = 4434.922

///|
pub const D8 : Hz = 4698.636

///|
pub const DS8 : Hz = 4978.032

///|
pub const E8 : Hz = 5274.042

///|
pub const F8 : Hz = 5587.652

///|
pub const FS8 : Hz = 5919.91

///|
pub const G8 : Hz = 6271.928

///|
pub const GS8 : Hz = 6644.876

///|
pub const A8 : Hz = 7040.0

///|
pub const AS8 : Hz = 7458.62

///|
pub const B8 : Hz = 7902.132

///|
pub const C9 : Hz = 8372.018

///|
pub const CS9 : Hz = 8869.844

///|
pub const D9 : Hz = 9397.272

///|
pub const DS9 : Hz = 9956.064

///|
pub const E9 : Hz = 10548.084

///|
pub const F9 : Hz = 11175.304

///|
pub const FS9 : Hz = 11839.82

///|
pub const G9 : Hz = 12543.856

///|
/// G#9, MIDI note #128, the top of the MIDI tuning range.
pub const GS9 : Hz = 13289.752

///|
pub const A9 : Hz = 14080.0

///|
pub const AS9 : Hz = 14917.24

///|
/// B9. For most of adults, it is already beyond the hearing range.
pub const B9 : Hz = 15804.264

///|
pub fn midi(note : Byte) -> Hz {
  // https://inspiredacoustics.com/en/MIDI_note_numbers_and_center_frequencies
  // https://en.wikipedia.org/wiki/Musical_note#MIDI
  let f : Float = match note % 12 {
    0 => 8.1758
    1 => 8.66
    2 => 9.18
    3 => 9.72
    4 => 10.30
    5 => 10.91
    6 => 11.56
    7 => 12.25
    8 => 12.98
    9 => 13.75
    10 => 14.57
    _ => 15.43
  }
  let oct = note / 12
  f * Float::from_int(1 << oct.to_int())
}

///|
pub fn note(pitch : Pitch, octave : Byte) -> Hz {
  // https://github.com/crbulakites/hum/blob/master/src/hum_process/hum_math.rs
  // https://en.wikipedia.org/wiki/Musical_note#Pitch_frequency_in_hertz
  let f : Float = match pitch {
    C => 16.351
    Cs => 17.324
    D => 18.354
    Ds => 19.445
    E => 20.601
    F => 21.827
    Fs => 23.124
    G => 24.499
    Gs => 25.956
    A => 27.5
    As => 29.135
    B => 30.868
  }
  f * Float::from_uint(1 << octave.to_int())
}
