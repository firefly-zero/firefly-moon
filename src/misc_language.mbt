///|
pub(all) enum Language {
  /// en 🇬🇧 💂
  English
  /// nl 🇳🇱 🧀
  Dutch
  /// fr 🇫🇷 🥐
  French
  /// de 🇩🇪 🥨
  German
  /// it 🇮🇹 🍕
  Italian
  /// pl 🇵🇱 🥟
  Polish
  /// ro 🇷🇴 🧛
  Romanian
  /// ru 🇷🇺 🪆
  Russian
  /// es 🇪🇸 🐂
  Spanish
  /// sv 🇸🇪 ❄️
  Swedish
  /// tr 🇹🇷 🕌
  Turkish
  /// uk 🇺🇦 ✊
  Ukrainian
  /// tp 🇨🇦 🙂
  TokiPona
} derive(Debug, Eq, Hash)

///|
pub impl Default for Language with fn default() -> Language {
  Language::English
}

///|
pub fn Language::from_raw(raw : UInt16) -> Language? {
  match raw {
    0x656e => Some(English)
    0x6e6c => Some(Dutch)
    0x6672 => Some(French)
    0x6465 => Some(German)
    0x6974 => Some(Italian)
    0x706c => Some(Polish)
    0x726f => Some(Romanian)
    0x7275 => Some(Russian)
    0x6573 => Some(Spanish)
    0x7376 => Some(Swedish)
    0x7472 => Some(Turkish)
    0x756b => Some(Ukrainian)
    0x7470 => Some(TokiPona)
    _ => None
  }
}

///|
pub fn Language::from_code(code : Utf8View) -> Language? {
  match code {
    b"en" => Some(English)
    b"nl" => Some(Dutch)
    b"fr" => Some(French)
    b"de" => Some(German)
    b"it" => Some(Italian)
    b"pl" => Some(Polish)
    b"ro" => Some(Romanian)
    b"ru" => Some(Russian)
    b"es" => Some(Spanish)
    b"sv" => Some(Swedish)
    b"tr" => Some(Turkish)
    b"uk" => Some(Ukrainian)
    b"tp" => Some(TokiPona)
    _ => None
  }
}

///|
/// The language name in English.
pub fn Language::name_english(lang : Language) -> Utf8 {
  match lang {
    English => b"English"
    Dutch => b"Dutch"
    French => b"French"
    German => b"German"
    Italian => b"Italian"
    Polish => b"Polish"
    Romanian => b"Romanian"
    Russian => b"Russian"
    Spanish => b"Spanish"
    Swedish => b"Swedish"
    Turkish => b"Turkish"
    Ukrainian => b"Ukrainian"
    TokiPona => b"TokiPona"
  }
}

///|
/// The language name in the language itself (endonym).
pub fn Language::name_native(lang : Language) -> Utf8 {
  match lang {
    English => b"English"
    Dutch => b"Nederlands"
    French => b"Français"
    German => b"Deutsch"
    Italian => b"Italiano"
    Polish => b"Polski"
    Romanian => b"Română"
    Russian => b"Русский"
    Spanish => b"Español"
    Swedish => b"Svenska"
    Turkish => b"Türkçe"
    Ukrainian => b"Українська"
    TokiPona => b"toki pona"
  }
}

///|
pub fn Language::code(lang : Language) -> Utf8 {
  match lang {
    English => b"en"
    Dutch => b"nl"
    French => b"fr"
    German => b"de"
    Italian => b"it"
    Polish => b"po"
    Romanian => b"ro"
    Russian => b"ru"
    Spanish => b"es"
    Swedish => b"sv"
    Turkish => b"tr"
    Ukrainian => b"uk"
    TokiPona => b"tp"
  }
}

///|
/// ISO 8859 encoding slug for the language.
///
/// Useful for dynamically loading the correct font for the given language.
pub fn Language::encoding(lang : Language) -> Utf8 {
  match lang {
    // Just like English, Dutch has very little non-ASCII characters
    // which can be avoided in translations to make it possible to stick
    // to the smaller fonts.
    English | Dutch | TokiPona => b"ascii"
    Italian | Spanish | Swedish => b"iso_8859_1"
    German | French => b"iso_8859_2"
    Russian | Ukrainian => b"iso_8859_5"
    Turkish => b"iso_8859_9"
    Polish => b"iso_8859_13"
    Romanian => b"iso_8859_16"
  }
}
