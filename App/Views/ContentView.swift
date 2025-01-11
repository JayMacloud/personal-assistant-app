
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CalendarView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Kalender")
                }
            PlanningView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Planung")
                }
            ChatView()
                .tabItem {
                    Image(systemName: "message")
                    Text("Assistent")
                }
            DashboardView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Dashboard")
                }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}
