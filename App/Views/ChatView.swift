
import SwiftUI

struct ChatView: View {
    @State private var message = ""
    @State private var chatMessages: [String] = []
    private let openAIService = OpenAIService()
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(chatMessages, id: \.self) { msg in
                    HStack {
                        Text(msg)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                }
            }
            
            HStack {
                TextField("Nachricht eingeben...", text: $message)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: sendMessage) {
                    Image(systemName: "paperplane.fill")
                        .font(.largeTitle)
                }
            }
            .padding()
        }
    }
    
    func sendMessage() {
        chatMessages.append("Ich: \(message)")
        
        openAIService.fetchResponse(prompt: message) { response in
            DispatchQueue.main.async {
                chatMessages.append("KI: \(response)")
            }
        }
        
        message = ""
    }
}
