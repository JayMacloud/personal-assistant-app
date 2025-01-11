
import Foundation
import DotEnv // Importiere das DotEnv-Paket

struct OpenAIService {
    private let apiKey: String

    init() {
        // Lade die .env-Datei und hole den API-Key
        DotEnv.load()
        self.apiKey = ProcessInfo.processInfo.environment["OPENAI_API_KEY"] ?? ""
    }

    func fetchResponse(prompt: String, completion: @escaping (String) -> Void) {
        guard !apiKey.isEmpty else {
            completion("Fehler: API-Key fehlt.")
            return
        }

        let url = URL(string: "https://api.openai.com/v1/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestBody: [String: Any] = [
            "model": "text-davinci-003",
            "prompt": prompt,
            "max_tokens": 100
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion("Fehler: \(error?.localizedDescription ?? "Keine Daten")")
                return
            }

            if let result = try? JSONDecoder().decode(OpenAIResponse.self, from: data) {
                completion(result.choices.first?.text ?? "Keine Antwort")
            } else {
                completion("Fehler beim Dekodieren der Antwort.")
            }
        }.resume()
    }
}

struct OpenAIResponse: Codable {
    let choices: [Choice]
}

struct Choice: Codable {
    let text: String
}
