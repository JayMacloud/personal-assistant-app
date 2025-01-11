
import Foundation

struct OpenAIService {
    private let apiKey: String

    init(apiKey: String) {
        self.apiKey = apiKey
    }

    func sendPrompt(_ prompt: String, completion: @escaping (String?) -> Void) {
        completion("Antwort von der KI auf: \(prompt)")
    }
}
