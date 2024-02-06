import Foundation

struct DefinitionModelElement: Codable {
    let word, phonetic: String?
    let phonetics: [Phonetic]?
    let meanings: [Meaning]?
}

struct Meaning: Codable {
    let partOfSpeech: String?
    let definitions: [Definition]?
}

struct Definition: Codable {
    let definition, example: String?
}

struct Phonetic: Codable {
    let text: String?
    let audio: String?
}

typealias DefinitionModel = [DefinitionModelElement]
