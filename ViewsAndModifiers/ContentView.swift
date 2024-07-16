//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Мария Газизова on 19.06.2024.
//

import SwiftUI

// should be a struct otherwise the fatal error in runtime
// TODO: why the error occures in runtime?
struct ContentView: View {
    var body: some View { // some View - oppaque return type
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        //        .frame(width: .infinity, height: .infinity) TODO: Why it doesn't make the view bigger?
        .background(.red)
    }
}

struct ButtonView: View {
    var body: some View {
        Button("Hello World") {
            print(type(of: self.body))
        }
        // the view isn't modified directly, the modification applies to the previous view [after it], that's why the yellow collor doen't apply to the whole frame
        .background(.yellow)
        .frame(width: 100, height: 100)
        .background(.red)
        
        // same modifier could be applied multiple times and has different effect
        Text("Hello World!")
            .background(.yellow)
            .padding()
            .background(.red)
            .padding()
            .background(.green)
            .padding()
            .background(.blue)
    }
}

struct TypeView: View {
    //    var body: Text { that is correct if text inside the body doesn't have modifiers
    //    var body: Button { that is incorrect becase the body isn't a Button
    //    var body: some Text { also incorrect because the Text isn't a protocol to return in that way
    var bodyTypes: some View { // uses always because you don't need to clarify the certain implementation of View
        Text("Hello World")
    }
    
    // VStack composes the views into the TupleView of views
    // if we don't use VStack or other types of stack than ViewBuilder (see it inside the View) combines Views into the ToupleViews
    var body: some View {
        VStack {
            Text("Hello World")
            
            Button("Push me") {
                print(type(of: self.body))
            }
            .padding()
            
            Text("Another text")
        }
    }
}

struct ConditionalView: View {
    @State private var useRedText = false
    
    var body: some View {
        Button("Hello World") {
            useRedText.toggle()
        }
        .foregroundStyle(useRedText ? .red : .blue)
        
        // Another option - use if statement
        if useRedText {
            Button("Red button") {
                useRedText.toggle()
            }
            .foregroundStyle(.red)
        } else {
            Button("Green button") {
                useRedText.toggle()
            }
            .foregroundStyle(.green)
        }
    }
}

// Environment modifiers apply to containers which contains many views
struct EnvironmentModifierView: View {
    var body: some View {
        VStack {
            Text("one")
                .font(.title) // Regular modifier has priority!
            Text("two")
            Text("three")
        }
        .font(.largeTitle) // font is environment modifier, so it can be ovverided by custom font
        
        VStack {
            Text("four")
                .blur(radius: 0)
            Text("five")
            Text("six")
        }
        .blur(radius: 5) // blur modifier is a regular modifier (not environment), so it can't be overrided by custom blur
    }
}

struct VariableView: View {
    private var one = Text("One") // variables
    private var two = Text("Two")
    
    private var three: some View { // computed properties
        Text("Three")
//        Text("Four") It doesn't work because @ViewBuilder doesn't apply to such property -> The stack, group or explicit viewBuilder should be used
    }
    
    private var stackFour: some View {
        VStack {
            Text("Four")
            Text("Four")
        }
    }
    
    private var groupFive: some View {
        Group { // The arrangement determined by the place where it will be used. See the example in HStack bellow
            Text("Five")
            Text("Five")
        }
    }
    
    @ViewBuilder private var viewBuilderSix: some View { // Good way because it do the same as body does
        Text("Six")
        Text("Six")
    }
    
    var body: some View {
        one.foregroundStyle(.purple)
        two.foregroundStyle(.pink)
        three.foregroundStyle(.green)
        
        stackFour.foregroundStyle(.blue)
        groupFive.foregroundStyle(.mint)
        
        HStack {
            groupFive.foregroundStyle(.orange)
        }
        
        viewBuilderSix.foregroundStyle(.teal)
        
        HStack {
            viewBuilderSix.foregroundStyle(.gray)
        }
    }
}

struct CapsuleView: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
//            .foregroundStyle(.white) Can't be ovveride in use
            .background(.blue)
            .clipShape(.capsule)
    }
}

struct UseOfCapsuleView: View {
    var body: some View {
        CapsuleView(text: "Hello")
            .foregroundStyle(.white)
        CapsuleView(text: "Mariia")
            .foregroundStyle(.yellow)
    }
}

struct Title: ViewModifier { // Tip: Custom modifier can have their own stored properies
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.white)
            .padding()
            .background(.mint)
            .clipShape(.rect(cornerRadius: 10))
    }
}
                         
struct UseOfCustomModifierView: View {
    var body: some View {
        Text("Hello, Mariia")
            .modifier(Title())
        
        Text("Another greeting, Mariia")
            .titleStyle()
        
        Text("Using prominent title")
            .modifier(ProminentTitle())
        
        Text("Using prominent title AGAIN")
            .prominentTitle()
        
        Color(.yellow)
            .frame(width: 300, height: 300)
            .watermark(with: "What are you doing????")
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
    
    func watermark(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
    
    func prominentTitle() -> some View {
        modifier(ProminentTitle())
    }
}

struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundStyle(.white)
                .padding(5)
                .background(.black)
        }
    }
}

#Preview {
//    ContentView()
//    ButtonView()
//    TypeView()
//    ConditionalView()
//    EnvironmentModifierView()
//    VariableView()
//    CapsuleView(text: "lala")
//    UseOfCapsuleView()
    UseOfCustomModifierView()
}
