//
//  Stages.swift
//  Next
//
//  Created by Constantin Clerc on 05/02/2023.
//

import SwiftUI
import UIKit

struct Stages: View {
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("System")) {
                        Section(header: Text("helpdesk")) {
                            Text("Get some help on the plateform in general (all clients)")
                        }
                        Section(header: Text("suggestions")) {
                            Text("Suggest any new features to the plateform")
                        }
                        Section(header: Text("report")) {
                            Text("Report some abusive posts/stages on the network")
                        }
                        Section(header: Text("stage_showcase")) {
                            Text("Why not sharing out the stage you just created ? There, you can !")
                        }
                    }
                    Section(header: Text("API")) {
                        Section(header: Text("announcements")) {
                            Text("Get some of the latest news of Next")
                        }
                        Section(header: Text("changelog")) {
                            Text("Get a more detailed report of updates")
                        }
                        Section(header: Text("clients")) {
                            Text("Various client informations")
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Stages")
                        .bold()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        UIApplication.shared.newStageAlert(sampletext: "")
                    }) {
                        Image(systemName: "plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                    }
                }
            }
        }
    }
}

struct Stages_Previews: PreviewProvider {
    static var previews: some View {
        Stages()
    }
}
