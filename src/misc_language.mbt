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
} derive(Show, Eq, Hash)

///|
pub impl Default for Language with default() -> Language {
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
pub fn Language::from_code(code : Bytes) -> Language? {
  match code {
    "en" => Some(English)
    "nl" => Some(Dutch)
    "fr" => Some(French)
    "de" => Some(German)
    "it" => Some(Italian)
    "pl" => Some(Polish)
    "ro" => Some(Romanian)
    "ru" => Some(Russian)
    "es" => Some(Spanish)
    "sv" => Some(Swedish)
    "tr" => Some(Turkish)
    "uk" => Some(Ukrainian)
    "tp" => Some(TokiPona)
    _ => None
  }
}

///|
/// The language name in English.
pub fn Language::name_english(lang : Language) -> Bytes {
  match lang {
    English => "English"
    Dutch => "Dutch"
    French => "French"
    German => "German"
    Italian => "Italian"
    Polish => "Polish"
    Romanian => "Romanian"
    Russian => "Russian"
    Spanish => "Spanish"
    Swedish => "Swedish"
    Turkish => "Turkish"
    Ukrainian => "Ukrainian"
    TokiPona => "TokiPona"
  }
}

///|
/// The language name in the language itself (endonym).
pub fn Language::name_native(lang : Language) -> Bytes {
  match lang {
    English => "English"
    Dutch => "Nederlands"
    French => "Français"
    German => "Deutsch"
    Italian => "Italiano"
    Polish => "Polski"
    Romanian => "Română"
    Russian => "Русский"
    Spanish => "Español"
    Swedish => "Svenska"
    Turkish => "Türkçe"
    Ukrainian => "Українська"
    TokiPona => "toki pona"
  }
}

///|
pub fn Language::code(lang : Language) -> Bytes {
  match lang {
    English => "en"
    Dutch => "nl"
    French => "fr"
    German => "de"
    Italian => "it"
    Polish => "po"
    Romanian => "ro"
    Russian => "ru"
    Spanish => "es"
    Swedish => "sv"
    Turkish => "tr"
    Ukrainian => "uk"
    TokiPona => "tp"
  }
}

///|
/// ISO 8859 encoding slug for the language.
///
/// Useful for dynamically loading the correct font for the given language.
pub fn Language::encoding(lang : Language) -> Bytes {
  match lang {
    // Just like English, Dutch has very little non-ASCII characters
    // which can be avoided in translations to make it possible to stick
    // to the smaller fonts.
    English | Dutch | TokiPona => "ascii"
    Italian | Spanish | Swedish => "iso_8859_1"
    German | French => "iso_8859_2"
    Russian | Ukrainian => "iso_8859_5"
    Turkish => "iso_8859_9"
    Polish => "iso_8859_13"
    Romanian => "iso_8859_16"
  }
}
