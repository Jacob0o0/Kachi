//
//  WidgetTestLiveActivity.swift
//  WidgetTest
//
//  Created by Jacobo Escorcia on 01/11/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct WidgetTestAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct WidgetTestLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: WidgetTestAttributes.self) { context in
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

extension WidgetTestAttributes {
    fileprivate static var preview: WidgetTestAttributes {
        WidgetTestAttributes(name: "World")
    }
}

extension WidgetTestAttributes.ContentState {
    fileprivate static var smiley: WidgetTestAttributes.ContentState {
        WidgetTestAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: WidgetTestAttributes.ContentState {
         WidgetTestAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: WidgetTestAttributes.preview) {
   WidgetTestLiveActivity()
} contentStates: {
    WidgetTestAttributes.ContentState.smiley
    WidgetTestAttributes.ContentState.starEyes
}
