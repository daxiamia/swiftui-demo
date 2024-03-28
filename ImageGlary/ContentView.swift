//
//  ContentView.swift
//  ImageGlary
//
//  Created by daxia on 2024/3/28.
//

import SwiftUI

struct Data: Identifiable, Equatable {
    let id: UUID = .init()
    let value: String
}

struct ContentView: View {
    @Namespace var namespace: Namespace.ID
    let dataList = (1..<22).map { Data(value: "\($0)") }

    @State private var selectedItem: Data?
    @State private var position: CGSize = CGSize.zero
    
    
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible(minimum: 100, maximum: 200), spacing: 2),
                    GridItem(.flexible(minimum: 100, maximum: 200), spacing: 2),
                    GridItem(.flexible(minimum: 100, maximum: 200), spacing: 2)
                ], spacing: 2) {
                    ForEach(dataList) { data in
                        Image(data.value)
                         .resizable()
                         .aspectRatio(1, contentMode: .fill)
                         .matchedGeometryEffect(
                            id: data.id,
                            in: namespace,
                            isSource: selectedItem == nil
                         )
                         .zIndex(selectedItem == data ?1 : 0)
                         .onTapGesture {
                             position = .zero
                             withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                                 selectedItem = data
                             }
                         }
                    }
                }
                .padding(2)
            }
            
            Color.white
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                .opacity(selectedItem == nil ? 0 : min(1, max(0, 1-abs(Double(position.height)/800))))
            
            if let selectedItem {
                Image(selectedItem.value)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .matchedGeometryEffect(
                       id: selectedItem.id,
                       in: namespace,
                       isSource: self.selectedItem != nil
                    )
                    .zIndex(2)
                    .onTapGesture {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                            self.selectedItem = nil
                        }
                    }
                    .offset(position)
                    .gesture(
                        DragGesture()
                            .onChanged{value in
                                self.position = value.translation
                            }
                            .onEnded{ value in
                                withAnimation(.spring(response:0.4, dampingFraction: 0.75)) {
                                    if 200 < abs(self.position.height) {
                                        self.selectedItem = nil
                                    } else {
                                        self.position = .zero
                                    }
                                }
                            }
                    )
            }
            
        }

    }
}

#Preview {
    ContentView()
}
