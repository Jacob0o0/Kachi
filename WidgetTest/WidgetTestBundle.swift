//
//  WidgetTestBundle.swift
//  WidgetTest
//
//  Created by Jacobo Escorcia on 01/11/24.
//

import WidgetKit
import SwiftUI

@main
struct WidgetTestBundle: WidgetBundle {
    var body: some Widget {
        WidgetTest()
        WidgetTestControl()
        WidgetTestLiveActivity()
    }
}
