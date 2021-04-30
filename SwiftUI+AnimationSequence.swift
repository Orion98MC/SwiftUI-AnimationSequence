//
//  SwiftUI+AnimationSequence.swift
//
//  Created by Thierry Passeron on 30/04/2021.
//

import SwiftUI

/**
  Animation Sequence
 
  Example Usage:
  =============
 
 struct TestView: View {
   
   @State private var scale: CGFloat = 1
   @State private var rotation = .zero
     
   var body: some View {
     VStack(spacing: 20) {

       Rectangle()
         .foregroundColor(.blue)
         .frame(width: 100, height: 100)
         .scaleEffect(scale, anchor: UnitPoint(x: 0.5, y: 0.5))
         .rotationEffect(rotation)

       Button("Animate !") {
         
         AnimationSequence()
           .nextAnimation(.easeIn(duration: 1), duration: 1) {
             scale = 2
           }
           .nextAnimation(.easeOut(duration: 0.5), duration: 1) {
             rotation = Angle(degrees: 90)
           }
           .nextAnimation(.easeInOut(duration: 0.5), duration: 0.5) {
             scale = 1
             rotation = Angle(degrees: 0)
           }
         
       }
     }
   }
 }

 */

///
/// Create a sequence of animations
public final class AnimationSequence {
  private var animations: [(Animation, TimeInterval, (() -> Void)?)] = []
  private var delay: TimeInterval = 0
  
  public init(delay: TimeInterval = 0) {
    self.delay = delay
  }
  
  deinit {
    let now = DispatchTime.now()
    for (animation, duration, body) in animations {
      DispatchQueue.main.asyncAfter(deadline: now + delay) {
        SwiftUI.withAnimation(animation, body ?? {})
      }
      delay += duration
    }
  }
  
  /// Append an animation
  @discardableResult
  public func nextAnimation(_ animation: Animation = .default, duration: TimeInterval, _ body: (() -> Void)?) -> Self {
    animations.append((animation, duration, body))
    return self
  }
}
