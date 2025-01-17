
import Foundation

/* struct LanguageTranslateData:Decodable {
    let data : Translation
    
}

struct TranslationText:Decodable {
    let translation : [TranslatedString]
    
}

struct TranslatedString:Decodable {
    let translated : String

} */


// MARK: - GoogleTranslate
struct GoogleTranslateDataStruct: Decodable{
    let data: TranslateData
}

// MARK: - DataClass
struct TranslateData: Decodable {
    let translations: [TranslationText]
}

// MARK: - Translation
struct TranslationText: Decodable{
    let translatedText: String
}
