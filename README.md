# SwiftUI-AnimationSequence
A simple tool for SwiftUI to allow multiple animations in a sequence.

## Usage

In place of multiple `withAnimation(...) { ... }` possibly wrapped in `DispatchQueue.main.asyncAfter(...)`, do this:

```swift
AnimationSequence()
  .nextAnimation(...) {
    // ... animations here ... 
  }
  .nextAnimation(...) {
    // ...
  }
  . etc...

```

## Example

```swift
 struct TestView: View {
   
   @State private var scale: CGFloat = 1
   @State private var rotation = .zero
     
   var body: some View {
     VStack(spacing: 20) {

       Rectangle()
         .foregroundColor(.blue)
         .frame(width: 100, height: 100)
         .scaleEffect(scale)
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
             rotation = .zero
           }
         
       }
     }
   }
 }

```

