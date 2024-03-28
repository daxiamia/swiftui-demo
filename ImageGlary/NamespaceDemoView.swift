//
//  NamespaceDemoView.swift
//  ImageGlary
//
//  Created by daxia on 2024/3/28.
//

import SwiftUI

/**
 
 在 SwiftUI 中，@Namespace 是一个属性包装器，用于创建一个命名空间（namespace），该命名空间允许你在视图间共享动画状态。它通常与 .matchedGeometryEffect 修饰符一起使用，实现在不同视图之间平滑地动画过渡，特别是对于那些在容器之间移动的视图元素。

 通过使用 @Namespace 和 .matchedGeometryEffect，你可以让系统知道两个视图是“相同”的，即使它们在视图层级中的位置不同。这使得在视图之间转换时能够创建连贯和引人注目的动画效果，如共享元素过渡。
 
 */

struct NamespaceDemoView: View {
       @Namespace private var animationNamespace
       @State private var isFlipped = false

       var body: some View {
           VStack {
               if isFlipped {
                   Rectangle()
                       .matchedGeometryEffect(id: "shape", in: animationNamespace)
                       .frame(width: 100, height: 100)
                       .onTapGesture {
                           withAnimation {
                               isFlipped.toggle()
                           }
                       }
               } else {
                   Circle()
                       .matchedGeometryEffect(id: "shape", in: animationNamespace)
                       .frame(width: 100, height: 100)
                       .onTapGesture {
                           withAnimation {
                               isFlipped.toggle()
                           }
                       }
               }
           }
       }
}

#Preview {
    NamespaceDemoView()
}
