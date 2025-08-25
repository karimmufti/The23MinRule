# 23Minute 

The **23Minute** is a productivity & habit-building tool built with **SwiftUI**.  
It’s based on a study that shows most urges and bad habits fade after about **23 minutes**.  
By committing to just 23 minutes of focus, you can resist distractions, beat procrastination, and build momentum

---

## Features

-  **23-Minute Timer** — start a focused work session with a single tap.  
-  **Lockscreen & Widget Integration** — quickly start a session without opening the app.  
-  **Daily Streak Counter** — track your consistency with automatic streak logging (powered by `UserDefaults`).  
-  **GitHub-Calendar-Style History** — see which days you committed.  
-  **Toggle & Reset** — easily mark/unmark today’s completion.  
-  **Lightweight & Fast** — minimal UI, no accounts or clutter.  

---

## Screenshots / Test Vid

<img width="200" height="402" alt="Screenshot 2025-08-24 at 7 29 24 PM" src="https://github.com/user-attachments/assets/43d23378-7d91-4918-8a0d-a0e41fbf58b9" />


https://github.com/user-attachments/assets/f2fea87c-b8ef-4a72-b1cc-f5f2c74cec7e




## Meaning Behind the App

Research suggests that **every urge or craving lasts only about 23 minutes** before it naturally fades.  
This app helps you ride out that window, whether it’s avoiding a bad habit or powering through distractions by committing to just **23 minutes of focused effort**.  

---

## Tech Stack

- **Language**: Swift  
- **Frameworks**: SwiftUI, Combine  
- **Data Persistence**: `UserDefaults` (streaks & history)  
- **Platform**: iOS (Xcode)  

---

## File Structure

The23MinRule/
│
├── The23MinRuleApp.swift # App entry point
├── ContentView.swift # Main UI with Timer & Streak display
├── StreakStore.swift # Handles streak logic (mark/unmark/toggle days)
├── TimerView.swift # 23-minute countdown timer
├── Widgets/ # Widget & lockscreen quick start code
└── Assets/ # App icons, colors, etc.


## Author
Kareem Muftee, passion project
