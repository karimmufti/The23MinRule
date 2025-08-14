import SwiftUI

struct HomeView: View {
    @StateObject private var timer = TickTimer()

    // pulse driver for the centered time
    @State private var pulse: Bool = false
    private var secondsLeft: Int { max(0, Int(timer.state.remaining)) }

    var body: some View {
        ZStack {
            Color.appBg.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 22) {

                    // Header
                    HStack {
                        Text("23 Min Rule")
                            .font(FontToken.title)
                            .foregroundColor(.appText)
                        Spacer()
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.appMuted)
                            .padding(10)
                            .background(Color.appCard)
                            .clipShape(Circle())
                    }
                    .padding(.horizontal)

                    // TIMER (ring + centered time with glow)
                    ZStack {
                        TimerRing(progress: timer.state.progress, size: 260)

                        Text(timer.state.formattedRemaining)
                            .font(FontToken.bigNumber)
                            .foregroundColor(.appPrimary)
                            .monospacedDigit()
                            .glow(color: .appPrimary, radius: pulse ? 18 : 8, intensity: pulse ? 0.9 : 0.45)
                            .scaleEffect(pulse ? 1.02 : 1.0)
                            .animation(.easeOut(duration: 0.25), value: pulse)
                    }
                    // toggle the pulse once per second as remaining time changes
                    .onChange(of: secondsLeft) {
                        withAnimation { pulse.toggle() }
                    }

                    // Subtitle
                    Text(timer.state.phase == .running ? "Stay with it"
                         : timer.state.phase == .finished ? "Well done"
                         : "Destroy the urge")
                        .font(FontToken.body)
                        .foregroundColor(.appMuted)

                    // Buttons
                    HStack(spacing: 14) {
                        if timer.state.phase == .running {
                            BigButton(title: "End Early") { timer.stop() }
                            BigButton(title: "Pause", action: { /* future */ }, filled: false)
                        } else if timer.state.phase == .finished {
                            BigButton(title: "Reset") { timer.reset() }
                        } else {
                            BigButton(title: "Start 23:00") { timer.start() }
                        }
                    }
                    .padding(.horizontal)

                    // Stat cards (placeholders for now)
                    HStack(spacing: 14) {
                        StreakCard(streak: 200)
                        LastResultCard(lastResult: "—")
                    }
                    .padding(.horizontal)

                    Spacer(minLength: 40)
                }
                .padding(.top, 24)
            }
        }
    }
}

#Preview {
    HomeView()
        .preferredColorScheme(.dark)
}
