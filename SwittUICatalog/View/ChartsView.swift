//
//  ChartsView.swift
//  SwittUICatalog
//
//  Created by Max Meza on 1/27/25.
//

import Charts
import SwiftUI

struct Pancakes: Identifiable {
    let name: String
    let sales: Int
    
    var id: String { name }
}

let sales: [Pancakes] = [
    .init(name: "Cachapa", sales: 916),
    .init(name: "Injera", sales: 850),
    .init(name: "Crepes", sales: 802),
    .init(name: "Jian Bing", sales: 753),
    .init(name: "Dosa", sales: 654),
    .init(name: "American", sales: 618)
]

struct SalesSummary: Identifiable {
    let weekday: Date
    let sales: Int
    
    var id: Date { weekday }
}

let cupertinoData: [SalesSummary] = [
    .init(weekday: DateFormatter().date(from: "2022-05-02T04:08:00+05:30")!, sales: 54),
    .init(weekday: DateFormatter().date(from: "2022-05-03T08:12:00+05:30")!, sales: 42),
    .init(weekday: DateFormatter().date(from: "2022-05-04T11:32:00+05:30")!, sales: 88),
    .init(weekday: DateFormatter().date(from: "2022-05-05T04:02:00+05:30")!, sales: 49),
    .init(weekday: DateFormatter().date(from: "2022-05-06T04:10:00+05:30")!, sales: 42),
    .init(weekday: DateFormatter().date(from: "2022-05-07T05:30:00+05:30")!, sales: 125),
    .init(weekday: DateFormatter().date(from: "2022-05-08T07:30:00+05:30")!, sales: 67),
]

struct ChartsView: View {
    var body: some View {
        ScrollView {
            Section(header: Text("Bar Chart Normal")) {
                Chart(sales, id: \.name) { element in
                    BarMark(
                        x: .value("Name", element.name),
                        y: .value("Sales", element.sales)
                    )
                }
                .frame(height: 200)
                .padding()
            }
            
            Section(header: Text("Bar Chart horizontal")) {
                Chart(sales, id: \.name) { element in
                    BarMark(
                        x: .value("Sales", element.sales),
                        y: .value("Name", element.name)
                    )
                }
                .frame(height: 200)
                .padding()
            }
            
            Section(header: Text("Day + Location (Toggle filter)")) {
                Chart(cupertinoData, id: \.weekday) { element in
                    BarMark(
                        x: .value("Day", element.weekday, unit: .day),
                        y: .value("Sales", element.sales)
                    )
                }
                .frame(height: 200)
                .padding()
            }
        }
        
    }
}

#Preview {
    ChartsView()
}
