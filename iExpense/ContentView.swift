//
//  ContentView.swift
//  iExpense
//
//  Created by Scott on 11/4/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            
            VStack {
                List {
                    ForEach(expenses.items) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            if item.amount < 10 {
                                Text(String(format: "%.2f", item.amount))
                                    .foregroundColor(.purple)
                            } else if item.amount < 100 {
                                Text(String(format: "%.2f", item.amount))
                                    .foregroundColor(.orange)
                            } else {
                                Text(String(format: "%.2f", item.amount))
                                    .foregroundColor(.red)
                            }

                        }
                    }
                    .onDelete(perform: removeItems)
                    
                }
                .navigationBarTitle("iExpense")
                .navigationBarItems(leading: EditButton(), trailing:
                                        Button(action: {
                                            withAnimation {
                                                showingAddExpense = true
                                            }
                                        }) {
                                            Image(systemName: "plus")
                                    })
                HStack {
                    Text("Expenses: \(expenses.items.count)")
                        .font(.headline)
                    Spacer()
                    HStack {
                        Text("Total $:")
                            .font(.headline)
                        let totalAmount = expenses.items.map{$0.amount}.reduce(0, +)
                        if totalAmount >= 300.00 {
                            Text(String(format: "%.2f",totalAmount))
                                .font(.title2)
                                .foregroundColor(.red)
                        } else {
                            Text(String(format: "%.2f",totalAmount))
                                .font(.title2)
                                .foregroundColor(.green)
                        }
                        
                    }
                    
                }
                .padding()
                
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: self.expenses)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        withAnimation {
            expenses.items.remove(atOffsets: offsets)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
