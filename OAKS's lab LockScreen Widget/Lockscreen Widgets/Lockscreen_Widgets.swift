//
//  Lockscreen_Widgets.swift
//  Lockscreen Widgets
//
//  Created by Tom on 22.03.2023.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct Lockscreen_WidgetsEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    
    var entry: Provider.Entry
    
    var body: some View {
        switch widgetFamily {
        case .accessoryCircular:
            VStack {
                Gauge(value: 51, in: 0...60) {
                    ViewThatFits {
                        VStack(alignment: .center, spacing: 0) {
                            HStack(alignment: .lastTextBaseline, spacing: 0) {
                                Text("51")
                                    .font(.system(size: 20))
                                    .fontWeight(.medium)
                                Image(systemName: "figure.run")
                                    .font(.system(size: 8))

                            }
                            .privacySensitive()
                            
                            Image("logo")
                                .resizable()
                                .frame(width: 12, height: 12)

                        }
                    }
                    }
                .gaugeStyle(.accessoryCircularCapacity)
                }
            default:
                Text("Not impemented")
        }
    }
}


struct Lockscreen_Widgets: Widget {
    let kind: String = "Lockscreen_Widgets"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            Lockscreen_WidgetsEntryView(entry: entry)
        }
        .configurationDisplayName("Garmin Connect")
        .description("Widget allows you to see, what is the distance you ran weekly.")
        .supportedFamilies([.accessoryCircular])
    }
}

struct Lockscreen_Widgets_Previews: PreviewProvider {
    static var previews: some View {
        Lockscreen_WidgetsEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
            .previewDisplayName("Circular")
    }
}
