import SwiftUI

struct HomeView: View {
    @StateObject private var timer = TickTimer()
    @StateObject private var streak = StreakStore()

    // pulse driver for the centered time
    @State private var pulse: Bool = false
    private var secondsLeft: Int { max(0, Int(timer.state.remaining)) }

    // tick animation tuning
    private let tickOn:  Double = 0.07   // quick pop
    private let tickOff: Double = 0.06   // quick release

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

                    // TIMER (ring + centered time with tick pulse)
                    ZStack {
                        TimerRing(progress: timer.state.progress, size: 260)

                        Text(timer.state.formattedRemaining)
                            .font(FontToken.bigNumber)
                              .fontWidth(.condensed)
                              .monospacedDigit()
                            .foregroundColor(.appPrimary) // red digits; swap to .appText for white
                            .monospacedDigit()
                            .glow(color: .appPrimary,
                                  radius: pulse ? 12 : 5,
                                  intensity: pulse ? 0.95 : 0.35)
                            .scaleEffect(pulse ? 1.03 : 1.0)
                    }
                    // one-shot tick each second (on fast, off fast, within the same second)
                    .onChange(of: secondsLeft) {
                        guard timer.state.phase == .running else { return }
                        if #available(iOS 17, *) {
                            withAnimation(.snappy(duration: tickOn, extraBounce: 0)) { pulse = true }
                            DispatchQueue.main.asyncAfter(deadline: .now() + tickOn) {
                                withAnimation(.snappy(duration: tickOff, extraBounce: 0)) { pulse = false }
                            }
                        } else {
                            withAnimation(.linear(duration: tickOn)) { pulse = true }
                            DispatchQueue.main.asyncAfter(deadline: .now() + tickOn) {
                                withAnimation(.linear(duration: tickOff)) { pulse = false }
                            }
                        }
                    }

                    // Subtitle
                    Text(timer.state.phase == .running ? "Stay with it"
                         : timer.state.phase == .finished ? "Well done"
                         : "Destroy the urge")
                        .font(FontToken.body)
                        .foregroundColor(.appMuted)

                    // Buttons (single, full-width)
                    VStack(spacing: 14) {
                        if timer.state.phase == .running {
                            BigButton(title: "End Early") { timer.stop() }
                                .frame(maxWidth: .infinity)
                        } else if timer.state.phase == .finished {
                            BigButton(title: "Reset") { timer.reset() }
                                .frame(maxWidth: .infinity)
                        } else {
                            BigButton(title: "Start 23") { timer.start() }
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.horizontal)

                    // DAY STREAK
                    // DAY STREAK (card now includes the compact grid on the right)
                    StreakCard(store: streak)
                        .padding(.horizontal)


                    Spacer(minLength: 40)
                }
                .padding(.top, 24)
            }
        }
        // Auto-mark today complete when a session finishes (tweak later with reflection)
        .onChange(of: timer.state.phase) { _, newPhase in
            if newPhase == .finished {
                streak.markTodayComplete()
            }
        }
    }
}

#Preview {
    HomeView()
        .preferredColorScheme(.dark)
}
