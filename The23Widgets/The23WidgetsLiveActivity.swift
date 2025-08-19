//
//  The23WidgetsLiveActivity.swift
//  The23Widgets
//
//  Created by Karim Mufti on 8/18/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct The23WidgetsAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct The23WidgetsLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: The23WidgetsAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension The23WidgetsAttributes {
    fileprivate static var preview: The23WidgetsAttributes {
        The23WidgetsAttributes(name: "World")
    }
}

extension The23WidgetsAttributes.ContentState {
    fileprivate static var smiley: The23WidgetsAttributes.ContentState {
        The23WidgetsAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: The23WidgetsAttributes.ContentState {
         The23WidgetsAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: The23WidgetsAttributes.preview) {
   The23WidgetsLiveActivity()
} contentStates: {
    The23WidgetsAttributes.ContentState.smiley
    The23WidgetsAttributes.ContentState.starEyes
}
