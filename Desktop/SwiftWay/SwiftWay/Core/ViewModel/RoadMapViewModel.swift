//
//  RoadMapViewModel.swift
//  SwiftWay
//
//  Created by Татьяна Касперович on 3.11.23.
//

import SwiftUI

@MainActor final class RoadMapViewModel: ObservableObject {
    @AppStorage("selectedProfession") var selectedProfession: Professions = .iosDeveloper
  //  @Published var selectedColor: Professions = .accentColor
    
    @Published var selectedSector: String = ""
    @Published private(set) var sectors: [Sector] = []
    @Published var selected_Profession: String = ""
    @Published private(set) var professions: [Profession] = []
    // Levels ...
    @Published private(set) var levels: [Level] = []
    @Published var isLoadingLevels: Bool = false
    @Published var selectedFilter: FilterOption? = nil
  //  @Published var  filteredAndSortedLevel: [Level] = []

    // Tasks...
    @Published var tasks: [UserTask] = []
    @Published var isLoadingTasks: Bool = false
 
//    //    Upload Sectors+Pr+Levels ...
//           func uploadSectors() async throws {
//               
//               //               // Sectors...
//               let sectorIT = Sector(title: "IT",
//                         professions: [Profession(title: "IOS Developer", levels: [level1_IOSDeveloper, level2_IOSDeveloper, level3_IOSDeveloper, level4_IOSDeveloper, level5_IOSDeveloper, level6_IOSDeveloper]),
//                                       Profession(title: "Product Designer", levels: [])],
//                                     color: "SectorIT"
//               )
//               let sectorBeauty = Sector(title: "Beauty",
//                         professions: [Profession(title: "Lash Maker", levels: []),
//                                       Profession(title: "Nails Master", levels: [])
//                                      ],
//                                       color: "SectorBeauty"
//               )
//
//               let sectorsArray = [sectorIT, sectorBeauty]
//               
//               for sector in sectorsArray {
//                    try? await RoadMapManager.shared.uploadSectors(sector: sector)
//               }
//   
//           }

    func getSectors() async throws {
        self.sectors = try await RoadMapManager.shared.getSectors()
        self.selectedSector = sectors.first?.title ?? ""
        try? await getProfessions()
    }
    
    func getProfessions() async throws {
        for sector in sectors {
            self.professions = try await RoadMapManager.shared.getProfessions(sectorId: sector.id)
        }
    }
    
    // Get Levels ...
    func getLevels() async throws {
        isLoadingLevels = true
        for sector in sectors {
            for profession in professions {
                self.levels = try await RoadMapManager.shared.getLevels(sectorId: sector.id, professionId: profession.id)
            }
        }
        isLoadingLevels = false
    }
    
//
//    func uploadSectors() async throws {
//        let sectorIT = Sector(title: "IT", color: "Lime")
//        let sectorBeauty = Sector(title: "Beauty", color: "Pink")
//        
//        let sectorsArray = [sectorIT, sectorBeauty]
//        
//        let professionsArray = [
//            Profession(title: "IOS Developer", sector: "IT"),
//            Profession(title: "Lash Maker", sector: "Beauty"),
//            Profession(title: "Nails Master", sector: "Beauty")]
//        
//        let level1_IOSDeveloper = Level(title: "Basic", rating: 10.0 ,categories: [
//                            Category(title: "OOP", subTitle: "", description: "OOP -  rnfernk nfkjencv ejnbrjfnrjf", color: "Red", rating: 0.0, subCategory: [
//                                SubCategory(title: "Наследование", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                                            tests: [ ]),
//                                SubCategory(title: "Полиморфизм", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                                            tests: [ ]),
//                                SubCategory(title: "Инкапсуляция", description: "", url: "", rating: 0.0, isPremiumAccess: true,
//                                            tests: [ ]),
//                            ]),
//                            Category(title: "SOLID", subTitle: "", description: "SOLID - ", color: "Blue", rating: 0.0, subCategory: [
//                                SubCategory(title: "S", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                                            tests: [ ]),
//                                SubCategory(title: "O", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                                            tests: [ ]),
//                                SubCategory(title: "L", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                                            tests: [ ]),
//                                SubCategory(title: "I", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                                            tests: [ ]),
//                                SubCategory(title: "D", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                                            tests: [ ])
//                            ]),
//                            Category(title: "Алгоритмы", subTitle: "", description: "Алгоритмы - ", color: "Brown", rating: 0.0, subCategory: [
//                                SubCategory(title: " ", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                                            tests: [ ]),
//                                SubCategory(title: " ", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                                            tests: [ ]),
//                                SubCategory(title: " ", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                                            tests: [ ]),
//                            ]),
//                            Category(title: "XCode", subTitle: "", description: "XCode - mfvlem emrmkv krmfkmek knkfe kewfwf", color: "Cyan", rating: 0.0, subCategory: [
//                            ]),
//                        ], level: 1,profession: "IOS Developer")
//        
//                       let level2_IOSDeveloper = Level(title: "Swift", rating: 54.0 ,categories: [
//                       Category(title: "Swift", subTitle: "Swift", description: "Swift - ", color: "Orange", rating: 10.0,
//                                   subCategory: [
//                                       SubCategory(title: "The Basics", description: "Work with common kinds of data and write basic syntax.", url: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics", rating: 55.0, isPremiumAccess: false,
//                                       tests: [ ]),
//                                       SubCategory(title: "Basic Operators", description: "Perform operations like assignment, arithmetic, and comparison.", url: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/basicoperators", rating: 20.0, isPremiumAccess: false,
//                                       tests: [ ]),
//                                       SubCategory(title: "Strings and Characters", description: "Store and manipulate text.", url: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/stringsandcharacters", rating: 50.0, isPremiumAccess: false,
//                                       tests: [ ]),
//                                       SubCategory(title: "Collection Types", description: "Organize data using arrays, sets, and dictionaries.", url: "", rating: 0.0, isPremiumAccess: false,
//                                       tests: [ ]),
//                                       SubCategory(title: "Control Flow", description: "Structure code with branches, loops, and early exits.", url: "", rating: 100.0, isPremiumAccess: false,
//                                       tests: [ ]),
//                                       SubCategory(title: "Functions", description: "Define and call functions, label their arguments, and use their return values.", url: "", rating: 0.0, isPremiumAccess: false,
//                                       tests: []),
//                                       SubCategory(title: "Closures", description: "Group code that executes together, without creating a named function.", url: "", rating: 0.0, isPremiumAccess: false,
//                                       tests: []),
//                                       SubCategory(title: "Enumerations", description: "Model custom types that define a list of possible values.", url: "", rating: 0.0, isPremiumAccess: false,
//                                       tests: []),
//                                       SubCategory(title: "Structures and Classes", description: "Model custom types that encapsulate data.", url: "", rating: 100.0, isPremiumAccess: false,
//                                       tests: []),
//                                       SubCategory(title: "Properties", description: "Access stored and computed values that are part of an instance or type.", url: "", rating: 0.0, isPremiumAccess: false,
//                                       tests: []),
//                                       SubCategory(title: "Methods", description: "Define and call functions that are part of an instance or type.", url: "", rating: 0.0, isPremiumAccess: false,
//                                       tests: []),
//                                       SubCategory(title: "Subscripts", description: "Access the elements of a collection.", url: "", rating: 0.0, isPremiumAccess: false,
//                                       tests: []),
//                                       SubCategory(title: "Inheritance", description: "Subclass to add or override functionality.", url: "", rating: 0.0, isPremiumAccess: false,
//                                       tests: []),
//                                       SubCategory(title: "Initialization", description: "Set the initial values for a type’s stored properties and perform one-time setup.", url: "", rating: 0.0, isPremiumAccess: false,
//                                       tests: []),
//                                       SubCategory(title: "Deinitialization", description: "Release resources that require custom cleanup.", url: "", rating: 0.0, isPremiumAccess: false,
//                                       tests: []),
//                                       SubCategory(title: "Optional Chaining", description: "Access members of an optional value without unwrapping.", url: "", rating: 0.0, isPremiumAccess: false,
//                                       tests: []),
//                                       SubCategory(title: "Error Handling", description: "Respond to and recover from errors.", url: "", rating: 0.0, isPremiumAccess: false,
//                                       tests: []),
//                                       SubCategory(title: "Concurrency", description: "Perform asynchronous operations.", url: "", rating: 0.0, isPremiumAccess: false,
//                                       tests: []),
//                                       SubCategory(title: "Macros", description: "Use macros to generate code at compile time.", url: "", rating: 0.0, isPremiumAccess: false,
//                                       tests: []),
//                                       SubCategory(title: "Type Casting", description: "Determine a value’s runtime type and give it more specific type information.", url: "", rating: 0.0, isPremiumAccess: false,
//                                       tests: []),
//                                       SubCategory(title: "Nested Types", description: "Define types inside the scope of another type.", url: "", rating: 100.0, isPremiumAccess: false,
//                                       tests: []),
//                                       SubCategory(title: "Extensions", description: "Add functionality to an existing type.", url: "", rating: 0.0, isPremiumAccess: false,
//                                       tests: []),
//                                       SubCategory(title: "Protocols", description: "Define requirements that conforming types must implement.", url: "", rating: 0.0, isPremiumAccess: false,
//                                       tests: []),
//                                       SubCategory(title: "Generics", description: "Write code that works for multiple types and specify requirements for those types.", url: "", rating: 0.0, isPremiumAccess: false,
//                                       tests: []),
//                                       SubCategory(title: "Opaque and Boxed Types", description: "Hide implementation details about a value’s type.", url: "", rating: 0.0, isPremiumAccess: false,
//                                       tests: []),
//                                       SubCategory(title: "Automatic Reference Counting", description: "Model the lifetime of objects and their relationships.", url: "", rating: 0.0, isPremiumAccess: false,
//                                       tests: []),
//                                       SubCategory(title: "Memory Safety", description: "Structure your code to avoid conflicts when accessing memory.", url: "", rating: 0.0, isPremiumAccess: false,
//                                       tests: []),
//                                       SubCategory(title: "Access Control", description: "Manage the visibility of code by declaration, file, and module.", url: "", rating: 0.0, isPremiumAccess: false,
//                                       tests: []),
//                                       SubCategory(title: "Advanced Operators", description: "Define custom operators, perform bitwise operations, and use builder syntax.", url: "", rating: 0.0, isPremiumAccess: false,
//                                       tests: [])
//                       ])
//                   ], level: 2, profession: "IOS Developer")
//        
//                       let level3_IOSDeveloper = Level(title: "SwiftUI", rating: 54.0 ,categories: [
//                       Category(title: "SwiftUI Basics Review", subTitle: "", description: "SwiftUI - ", color: "Purple", rating: 20.0, subCategory: [
//                           SubCategory(title: "Swift Language Essentials", description: "Before you can truly excel in SwiftUI, a solid understanding of the Swift programming language is paramount. Swift is not just the backbone of SwiftUI; it’s a powerful, intuitive language that makes coding for Apple platforms a joy. In this sub-module, you’ll revisit the core concepts of Swift, including its syntax, control flow, optionals, and data structures. Whether you’re refreshing your memory or solidifying your understanding, mastering these essentials is your key to unlocking the full potential of SwiftUI.", url: "", rating: 100.0, isPremiumAccess: false,
//                                       tests: [ ]),
//                           SubCategory(title: "SwiftUI Framework Overview", description: "SwiftUI is a groundbreaking framework that has transformed the way we design and build apps for Apple platforms. With its declarative syntax and data-driven approach, creating stunning, efficient user interfaces has never been easier. This sub-module provides a comprehensive overview of the SwiftUI framework, including its architecture, components, and how it integrates seamlessly with the Swift language. You’ll gain a clear understanding of why SwiftUI is the future of app development and how you can leverage its power in your projects.", url: "", rating: 30.0, isPremiumAccess: false,
//                                       tests: [ ]),
//                           SubCategory(title: "Understanding Declarative Syntax", description: "One of the most revolutionary aspects of SwiftUI is its declarative syntax, which allows you to describe your UI in a clear, concise manner. This approach not only makes your code more readable but also significantly reduces the amount of code needed to create complex interfaces. In this sub-module, you’ll dive deep into the principles of declarative programming and how SwiftUI applies them to make UI development a breeze. Through practical examples, you’ll learn how to think declaratively and apply these concepts to build dynamic, responsive layouts.", url: "", rating: 0.0, isPremiumAccess: false,
//                                       tests: []),
//                           SubCategory(title: "State and Data Flow", description: "Managing state and data flow is at the heart of every SwiftUI application. Understanding how data drives your UI and how to manage it effectively is crucial for building responsive, data-driven apps. This sub-module explores the innovative ways SwiftUI handles data and state, including the use of @State, @Binding, @ObservedObject, and more. You’ll learn how to architect your app for optimal data flow, ensuring your UI always reflects the current state of your app accurately.", url: "", rating: 10.0, isPremiumAccess: false,
//                                       tests: []),
//                           SubCategory(title: "Views and Modifiers", description: "Views are the building blocks of your SwiftUI app, and modifiers are the tools that shape them. Together, they offer a powerful, flexible way to create and customize your app’s interface. In this sub-module, you’ll get hands-on with creating various views and applying modifiers to style and layout your UI precisely how you want it. From text and images to complex custom views, you’ll discover the endless possibilities SwiftUI offers for crafting beautiful, engaging apps.", url: "", rating: 10.0, isPremiumAccess: false,
//                                       tests: [])
//        
//                       ]),
//                       Category(title: "Advanced UI Components", subTitle: "", description: "SwiftUI - ", color: "Pink", rating: 20.0, subCategory: [
//                           SubCategory(title: "Custom Views and Modifiers", description: "Dive into the world of Custom Views and Modifiers, where your creativity meets SwiftUI’s flexibility. Here, you’ll learn to craft unique components that can give your apps a distinctive look and feel. This submodule is your playground for experimenting with SwiftUI’s vast capabilities, enabling you to create reusable and efficient UI elements that stand out.", url: "", rating: 100.0, isPremiumAccess: false,
//                                       tests: [ ]),
//                           SubCategory(title: "Advanced List and Grids", description: "Next, we explore Advanced Lists and Grids, the backbone of displaying collections in a structured yet elegant manner. Whether you’re aiming for a simple list or a complex grid layout, mastering these components will allow you to present data beautifully and intuitively. Prepare to harness the power of SwiftUI to handle dynamic data sets with grace.", url: "", rating: 100.0, isPremiumAccess: false,
//                                       tests: [ ]),
//                           SubCategory(title: "Navigation and Presentation", description: "In Navigation and Presentation, you’ll navigate the crucial aspect of moving between views in your app. This submodule goes beyond the basics, introducing you to advanced techniques for creating seamless and intuitive user journeys. Learn to manage complex navigation flows and present content in innovative ways, enhancing the overall user experience.", url: "", rating: 100.0, isPremiumAccess: false,
//                                       tests: [ ]),
//                           SubCategory(title: "Animation and Transitions", description: "Bring your apps to life with Animation and Transitions. This exciting submodule teaches you how to incorporate motion into your UI, making interactions feel more natural and engaging. From subtle transitions to complex animations, you’ll learn how to add a layer of polish that can truly differentiate your apps.", url: "", rating: 100.0, isPremiumAccess: false,
//                                       tests: [ ]),
//                           SubCategory(title: "Drawing and Custom Graphics", description: "Finally, unleash your artistic side with Drawing and Custom Graphics. Discover how to draw shapes, paths, and create custom graphics that can add a unique visual touch to your apps. This submodule is perfect for those looking to push the boundaries of standard UI components and truly make their mark.", url: "", rating: 100.0, isPremiumAccess: false,
//                                       tests: [ ])
//        
//                       ]),
//                       Category(title: "Data Management", subTitle: "", description: " - ", color: "DarkOrange", rating: 20.0, subCategory: [
//                           SubCategory(title: "Binding and State Management", description: "In the world of SwiftUI, understanding how to manage the state of your app is fundamental. This submodule will guide you through the intricacies of @State, @Binding, @ObservedObject, and more, enabling you to build fluid and interactive user interfaces. Learn how to keep your app’s UI in perfect sync with its underlying data model, making your apps intuitive and delightful to use.", url: "", rating: 100.0, isPremiumAccess: false,
//                                       tests: [ ]),
//                           SubCategory(title: "Core Data Integration", description: "Dive into the world of persistent data storage with Core Data, Apple’s powerful framework for managing an object graph. This submodule will teach you how to integrate Core Data into your SwiftUI projects, allowing you to store, retrieve, and manipulate data efficiently. From setting up your Core Data stack to performing complex queries, you’ll gain the skills to manage large datasets with ease.", url: "", rating: 100.0, isPremiumAccess: false,
//                                       tests: [ ]),
//                           SubCategory(title: "JSON Parsing and Networking", description: "In today’s interconnected world, your app needs to communicate with web services and APIs. This submodule focuses on fetching data from the internet, parsing JSON, and handling network requests. You’ll learn how to make your SwiftUI apps talk to RESTful APIs, handle asynchronous tasks, and present data fetched from the web seamlessly to your users.", url: "", rating: 100.0, isPremiumAccess: false,
//                                       tests: [ ]),
//                           SubCategory(title: "Observable Objects, Published, and Environment", description: "Master the art of reactive programming within SwiftUI by understanding @ObservableObject, @Published, and the @Environment property wrapper. This submodule will show you how to architect your app for scalability and reusability, making your code cleaner and more efficient. Learn how to propagate changes across your app’s components in a seamless and controlled manner.", url: "", rating: 100.0, isPremiumAccess: false,
//                                       tests: [ ]),
//                           SubCategory(title: "Combine Framework for Reactive Programming", description: "Embrace the power of reactive programming with the Combine framework. This advanced submodule will take you through the concepts of Publishers, Subscribers, and Operators, enabling you to handle complex data flows and asynchronous operations elegantly. By integrating Combine with SwiftUI, you’ll be able to create highly responsive apps that provide a superior user experience.", url: "", rating: 100.0, isPremiumAccess: false,
//                                       tests: [ ]),
//        
//                       ]),
//                       Category(title: "App Architecture", subTitle: "", description: " - ", color: "Green", rating: 20.0, subCategory: [
//                           SubCategory(title: "MVVM in SwiftUI", description: "The Model-View-ViewModel (MVVM) pattern is a cornerstone of modern SwiftUI development. It promotes a clean separation of concerns, making your code more modular, easier to understand, and test. In this sub-module, you’ll learn how to effectively implement MVVM in your SwiftUI projects, ensuring your UI code remains as lean and maintainable as possible. Prepare to master the art of binding data to your UI, creating dynamic and responsive applications.", url: "", rating: 100.0, isPremiumAccess: false,
//                                       tests: [ ]),
//                           SubCategory(title: "Coordinator Pattern", description: "Dive into the Coordinator pattern, an advanced architectural concept that takes navigation and flow management out of your view controllers or views. This pattern simplifies the process of managing app-wide navigation logic, making your codebase more modular and navigable. You’ll explore how to implement coordinators in a SwiftUI environment, enhancing the scalability and maintainability of your applications.", url: "", rating: 100.0, isPremiumAccess: false,
//                                       tests: [ ]),
//                           SubCategory(title: "Dependency Injection", description: "Understanding Dependency Injection (DI) is crucial for building flexible and decoupled iOS applications. This sub-module will guide you through the concepts and practical applications of DI in SwiftUI, allowing you to develop components that are easily testable and maintainable. Learn how to leverage DI to pass dependencies into your views and view models, facilitating a more modular and testable codebase.", url: "", rating: 100.0, isPremiumAccess: false,
//                                       tests: [ ]),
//                           SubCategory(title: "Modular Design", description: "Embrace the power of Modular Design to build scalable and robust SwiftUI applications. This approach allows you to break down your app into smaller, independent modules, making it easier to manage, develop, and test. Discover strategies for identifying logical modules within your app, and learn how to leverage Swift Package Manager to manage these modules. This sub-module will equip you with the knowledge to build apps that can grow and evolve over time, without becoming unwieldy. By the end of the App Architecture module, you’ll have a deep understanding of the architectural patterns and principles that are essential for building sophisticated and scalable SwiftUI applications. Each sub-module is designed to build upon the last, ensuring you have a comprehensive grasp of how to architect apps that stand the test of time. Dive in, and let’s start shaping the future of your SwiftUI projects!", url: "", rating: 100.0, isPremiumAccess: false,
//                                       tests: [ ])
//                       ]),
//                       Category(title: "Advanced SwiftUI Features", subTitle: "", description: " - ", color: "Indigo", rating: 20.0, subCategory: [
//                           SubCategory(title: "Gestures and Haptics", description: "Gestures are the secret language between your app and users. In this submodule, you’ll learn to implement intuitive gesture controls that make your app feel alive and responsive. From simple taps to complex swipes and pinches, mastering gestures will allow you to craft an interactive user interface that delights at every touch. Haptics add a layer of physical feedback to your digital creations, making interactions tangible. You’ll explore how to integrate haptic feedback in response to gestures, enhancing the user experience with tactile sensations that guide and reassure users in their interactions with your app.", url: "", rating: 100.0, isPremiumAccess: false,
//                                       tests: [ ]),
//                           SubCategory(title: "Camera and Photo Library Access", description: "Unlock the full potential of the device’s camera and photo library, turning your app into a hub for visual creativity. This submodule covers everything from accessing and displaying photos to capturing new images directly within your app. You’ll learn to implement permissions, handle image data, and create a seamless experience for users who wish to capture and share their moments.", url: "", rating: 100.0, isPremiumAccess: false,
//                                       tests: [ ]),
//                           SubCategory(title: "MapKit and Core Location", description: "Maps and location services open a world of possibilities for app development. From displaying interactive maps to customizing annotations and tracking user location in real-time, this submodule will guide you through integrating MapKit and Core Location into your SwiftUI app, enabling you to create location-aware features that add immense value to your users.", url: "", rating: 100.0, isPremiumAccess: false,
//                                       tests: [ ]),
//                           SubCategory(title: "Local Notifications", description: "Stay connected with your users through timely and relevant notifications. This submodule dives into scheduling and managing local notifications, a powerful tool to engage and retain users by providing updates, reminders, or custom alerts right on their device lock screens.", url: "", rating: 100.0, isPremiumAccess: false,
//                                       tests: [ ]),
//                           SubCategory(title: "SiriKit Integration", description: "Voice is the future of human-computer interaction, and with SiriKit, your app can be a part of that future. Learn to integrate SiriKit to handle voice commands, making your app accessible and convenient to use without even touching the screen. From setting tasks to querying information, voice integration will make your app a personal assistant to your users. As you progress through the “Advanced SwiftUI Features” module, remember that each of these submodules is a stepping stone towards creating an app that not only functions flawlessly but also provides an unparalleled user experience. Dive in with curiosity and creativity, and let’s bring your visionary app ideas to life!", url: "", rating: 100.0, isPremiumAccess: false,
//                                       tests: [ ]),
//        
//                       ]),
//                       Category(title: "Testing and Debugging", subTitle: "", description: " - ", color: "Mint", rating: 20.0, subCategory: [
//                           SubCategory(title: "Unit Testing SwiftUI Apps", description: "Unit testing is your first line of defense against bugs. It allows you to verify that individual parts of your app work as expected. In this submodule, you’ll learn how to write and run unit tests specifically for SwiftUI apps, ensuring your codebase is solid and error-free. We’ll explore the XCTest framework and how to leverage it to test your app’s logic, models, and more.", url: "", rating: 100.0, isPremiumAccess: false,
//                                       tests: [ ]),
//                           SubCategory(title: "UI Testing", description: "UI testing takes things a step further by simulating user interactions with your app. This submodule will guide you through creating UI tests in SwiftUI, allowing you to automate the process of checking UI elements like buttons, sliders, and text fields. You’ll learn how to use Xcode’s UI Testing framework to ensure your app not only looks good but is also intuitive and accessible to your users.", url: "", rating: 100.0, isPremiumAccess: false,
//                                       tests: [ ]),
//                           SubCategory(title: "Debugging Techniques", description: "Every developer’s journey involves encountering and solving bugs. This submodule is your guide to mastering the art of debugging in SwiftUI. You’ll learn various techniques and tools available in Xcode to help you quickly identify and fix issues in your code. From breakpoints to the LLDB debugger, you’ll gain the skills to keep your development process smooth and efficient.", url: "", rating: 100.0, isPremiumAccess: false,
//                                       tests: [ ]),
//                           SubCategory(title: "Performance Optimization", description: "The final piece of the puzzle is ensuring your app runs smoothly across all devices. In this submodule, you’ll dive into performance optimization techniques specific to SwiftUI. Learn how to profile your app using Xcode’s Instruments tool, identify bottlenecks, and implement best practices to enhance your app’s speed and responsiveness. This knowledge is key to delivering a top-notch user experience. By the end of this module, you’ll be equipped with the skills to test, debug, and optimize your SwiftUI apps like a pro. These are indispensable tools in your arsenal, ensuring your projects are not only functional but also polished and professional. Let’s get started and take your SwiftUI apps to the next level!", url: "", rating: 100.0, isPremiumAccess: false,
//                                       tests: [ ])
//        
//                       ]),
//                       Category(title: "Cross-Platform Development", subTitle: "", description: " - ", color: "Terracot", rating: 20.0, subCategory: [
//                           SubCategory(title: "Building for macOS", description: "Dive into the realm of macOS development, where the power of SwiftUI enables you to craft stunning desktop applications. This submodule will guide you through the nuances of macOS design patterns, menu bars, and window management, ensuring your apps not only look fantastic but also integrate seamlessly with the macOS ecosystem. Embrace the challenge and expand your app’s reach to the desktop!", url: "", rating: 100.0, isPremiumAccess: false,
//                                       tests: [ ]),
//                           SubCategory(title: "Building for watchOS", description: "Next, we’ll shrink the canvas but not the ambition, as we explore building for watchOS. Designing for the wrist demands precision and ingenuity. This submodule will teach you how to create compelling, glanceable interfaces that deliver key information and interactions right from the user’s wrist. Learn to leverage the unique features of watchOS, such as complications and the Digital Crown, to provide an intimate and engaging user experience.", url: "", rating: 100.0, isPremiumAccess: false,
//                                       tests: [ ]),
//                           SubCategory(title: "Building for tvOS", description: "Prepare to go big as we shift our focus to tvOS. Developing for the living room’s centerpiece offers a unique opportunity to craft immersive experiences on a grand scale. This submodule will cover the essentials of tvOS, including navigation, focus management, and the use of the Siri Remote. Discover how to bring your apps to life on the big screen, where they can be enjoyed by everyone in the room.", url: "", rating: 100.0, isPremiumAccess: false,
//                                       tests: [ ]),
//                           SubCategory(title: "Adaptive Layouts for Different Screen Sizes", description: "The final piece of the cross-platform puzzle is mastering adaptive layouts. In this submodule, you’ll learn the secrets to designing flexible interfaces that look and work beautifully across all device sizes and orientations. From the compact screen of the Apple Watch to the expansive display of the Apple TV, and everything in between, you’ll gain the skills to ensure your apps are accessible, attractive, and user-friendly, no matter where they’re running. By conquering the Cross-Platform Development module, you’ll not only broaden the reach of your applications but also significantly enhance your attractiveness to potential employers. Each platform offers its own set of challenges and opportunities, and mastering them will make you a versatile and valuable asset in the app development world. Let’s get started on this exciting journey to make your apps truly universal!", url: "", rating: 100.0, isPremiumAccess: false,
//                                       tests: [ ])
//        
//                       ]),
//        
//                   ], level: 3, profession: "IOS Developer")
//        
//                       let level4_IOSDeveloper = Level(title: "UIKit", rating: 54.0 ,categories: [
//                       Category(title: "UIKit - Basic", subTitle: "UIKit Road Map", description: "UIKit - ", color: "Blue", rating: 0.0, subCategory: [])
//                   ], level: 4, profession: "IOS Developer")
//        
//                       let level5_IOSDeveloper = Level(title: "Project", rating: 100 ,categories: [
//                           Category(title: "Real-World Project Building", subTitle: "", description: "Real-World Project Building - ", color: "LightPurple", rating: 0.0, subCategory: [
//                               SubCategory(title: "Ideation and Prototyping", description: "Before any code is written, the journey of app creation begins with a spark of imagination. In Ideation and Prototyping, you’ll learn how to harness your creativity to generate innovative app ideas. This submodule will guide you through techniques for brainstorming, validating your concepts, and sketching out your ideas. Then, you’ll dive into prototyping tools that bring your sketches to life, allowing you to visualize the flow and feel of your app early in the development process. This stage is crucial for setting a solid foundation for your project, ensuring that your efforts are aligned with a clear vision.", url: "", rating: 0.0, isPremiumAccess: false,
//                                           tests: []),
//                               SubCategory(title: "Project Planning and Management", description: "With a prototype in hand, it’s time to plan how to turn it into a fully functioning app. Project Planning and Management introduces you to the methodologies and tools that help you organize, schedule, and track your development process. From Agile and Scrum to Kanban, you’ll discover the project management techniques that best fit your working style and project needs. This submodule emphasizes the importance of effective communication, time management, and collaboration skills, preparing you to lead or contribute to development teams efficiently.", url: "", rating: 0.0, isPremiumAccess: false,
//                                           tests: []),
//                               SubCategory(title: "Building a Complete SwiftUI App", description: "Now, the real fun begins. Building a Complete SwiftUI App is where you apply everything you’ve learned to create a fully functional application. This submodule walks you through the development process step by step, from setting up your project in Xcode to writing the last line of code. You’ll integrate UI components, manage data flow, and ensure your app’s architecture is solid and scalable. By the end of this submodule, you’ll have a portfolio-ready app and the confidence to tackle any SwiftUI project that comes your way.", url: "", rating: 0.0, isPremiumAccess: false,
//                                           tests: []),
//                               SubCategory(title: "Incorporating Third-Party Libraries and APIs", description: "No app is an island, and in Incorporating Third-Party Libraries and APIs, you’ll learn how to extend the functionality of your apps by leveraging external resources. This submodule covers how to choose the right libraries and APIs for your project, integrate them seamlessly, and handle dependencies. Whether you’re adding authentication, social media integration, or advanced data processing capabilities, this submodule ensures you can build on the work of others to enrich your app’s features and user experience.", url: "", rating: 0.0, isPremiumAccess: false,
//                                           tests: []),
//                               SubCategory(title: "User Authentication and Authorization", description: "In today’s digital world, security is paramount. User Authentication and Authorization teaches you how to protect your users and their data. You’ll implement login systems, manage user sessions, and ensure that users can only access the features and data they’re entitled to. This submodule not only covers the technical aspects of authentication and authorization but also introduces best practices for privacy and security, preparing you to build trust with your users from the start.", url: "", rating: 0.0, isPremiumAccess: false,
//                                           tests: [])
//                           ]),
//                           Category(title: "App Distribution", subTitle: "", description: "App Distribution - ", color: "Mint", rating: 0.0, subCategory: [
//                               SubCategory(title: "App Store Submission Process", description: "The App Store is the gateway to visibility and success for your iOS app. Understanding the submission process is crucial for a smooth approval journey. This sub-module covers everything from preparing your app for submission, understanding Apple’s guidelines, to navigating the actual submission process. You’ll learn how to make your app stand out and ensure it meets all the necessary criteria for approval.", url: "", rating: 0.0, isPremiumAccess: false,
//                                           tests: []),
//                               SubCategory(title: "TestFlight Beta Testing", description: "Before your app makes its grand debut on the App Store, ensuring its quality and user experience is paramount. TestFlight is Apple’s beta testing program that allows you to invite users to test your app and provide valuable feedback. This sub-module will teach you how to set up beta tests, manage feedback, and iterate on your app to perfect it before the official launch.", url: "", rating: 0.0, isPremiumAccess: false,
//                                           tests: []),
//                               SubCategory(title: "App Store Optimization (ASO)", description: "With millions of apps on the App Store, standing out is a challenge. App Store Optimization (ASO) is the key to improving your app’s visibility and attracting more downloads. This sub-module delves into strategies for optimizing your app’s title, keywords, description, and screenshots to rank higher in search results and captivate potential users.", url: "", rating: 0.0, isPremiumAccess: false,
//                                           tests: []),
//                               SubCategory(title: "Continuous Integration and Continuous Deployment (CI/CD)", description: "In the fast-paced world of app development, efficiency and quality are king. Continuous Integration and Continuous Deployment (CI/CD) practices allow you to automate the testing and deployment of your apps, ensuring that you can quickly release new features while maintaining high standards. This sub-module explores setting up CI/CD pipelines, automating your workflow, and ensuring that your app remains bug-free and up-to-date.", url: "", rating: 0.0, isPremiumAccess: false,
//                                           tests: [])
//                           ]),
//                       ], level: 5, profession: "IOS Developer")
//        
//                       let level6_IOSDeveloper = Level(title: "Professional Skills", rating: 100 ,categories: [
//                           Category(title: "Резюме", subTitle: "", description: "Резюме - ", color: "Green", rating: 0.0, subCategory: [
//                               SubCategory(title: "Фото", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                                           tests: []),
//                               SubCategory(title: "Заголовок", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                                           tests: []),
//                               SubCategory(title: "Навыки", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                                           tests: []),
//                               SubCategory(title: "Обучение", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                                           tests: []),
//                               SubCategory(title: "Опыт работы", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                                           tests: []),
//                               SubCategory(title: "О себе", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                                           tests: []),
//                               SubCategory(title: "Сопроводительное письмо", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                                           tests: [])
//                           ]),
//                           Category(title: "Подготовка к собеседованию", subTitle: "", description: "Подготовка к собеседованию - ", color: "Indigo", rating: 0.0, subCategory: [
//                               SubCategory(title: "HR", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                                           tests: []),
//                               SubCategory(title: "Техническое интервью", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                                           tests: [])
//                           ]),
//                           Category(title: "Professional Skills and Employment", subTitle: "", description: "Professional Skills and Employment", color: "Mint", rating: 0.0, subCategory: [
//                               SubCategory(title: "Building a Portfolio", description: "When you’re venturing into the world of SwiftUI and aiming for employment, one of the most crucial steps you can take is building a compelling portfolio. This is not just a collection of your work; it’s a testament to your skills, creativity, and dedication. It’s what stands between you and your dream job. Let’s dive into how you can build a portfolio that not only showcases your technical prowess but also tells your unique story as a developer.", url: "", rating: 0.0, isPremiumAccess: false,
//                                           tests: []),
//                               SubCategory(title: "Open Source Contributions", description: "Contributing to open-source projects is not just about coding. It’s about being part of a community that shares your interests and passions. It’s about learning, growing, and making a difference in the world of technology. Whether you’re fixing bugs, adding new features, or improving documentation, every contribution counts. In this module, we’ll explore the ins and outs of open-source contributions, specifically within the context of SwiftUI and the broader iOS development ecosystem.", url: "", rating: 0.0, isPremiumAccess: false,
//                                           tests: []),
//                               SubCategory(title: "Networking and Community Participation", description: "In the realm of software development, especially within the vibrant ecosystem of SwiftUI, networking and community participation are not just beneficial; they are essential. This module will guide you through the intricacies of building meaningful connections, contributing to the community, and leveraging these experiences towards achieving your goal of employment in the field.", url: "", rating: 0.0, isPremiumAccess: false,
//                                           tests: []),
//                               SubCategory(title: "Interview Preparation for SwiftUI Developers", description: "Interview preparation is a crucial step towards securing a job as a SwiftUI developer. It’s not just about showcasing your technical skills but also demonstrating your problem-solving abilities, communication skills, and cultural fit for the company. Let’s dive into how you can prepare effectively, making your interview process not just successful but also an opportunity for personal growth.", url: "", rating: 0.0, isPremiumAccess: false,
//                                           tests: []),
//                               SubCategory(title: "Negotiating Job Offers", description: "Congratulations on reaching the final stretch of your SwiftUI learning journey! By now, you’ve amassed a wealth of knowledge and skills, making you a prime candidate for numerous exciting opportunities in the tech industry. The last hurdle before you embark on your professional career is mastering the art of negotiating job offers. This module is designed to equip you with the strategies and confidence needed to ensure you not only land a job but secure terms that align with your value and expectations.", url: "", rating: 0.0, isPremiumAccess: false,
//                                           tests: [])
//        
//                           ])
//                       ], level: 6, profession: "IOS Developer")
//        
//let levelsArray = [level1_IOSDeveloper, level2_IOSDeveloper, level3_IOSDeveloper, level4_IOSDeveloper, level5_IOSDeveloper, level6_IOSDeveloper]
//        
//        for sector in sectorsArray {
//         try? await RoadMapManager.shared.uploadSectors(sector: sector)
//            
//            let filteredProfessions = professionsArray.filter({$0.sector == sector.title})
//            for profession in professionsArray {
//                try? await RoadMapManager.shared.uploadProfessions(sector: sector, profession: profession)
//                
//                let filteredLevels = levelsArray.filter({$0.profession == profession.title})
//                for level in filteredLevels {
//                    try? await RoadMapManager.shared.uploadLevels(sector: sector, profession: profession, level: level)
//                }
//                           }
//                       }
//    }
//

    
    enum FilterOption: String {
        case progressHigt
        case progressLow
    }
    
//    func filterAndSortLevels() {
//        let filteredLevel = levels.filter({$0.profession == self.selectedProfession.rawValue})
//        filteredAndSortedLevel = filteredLevel.sorted(by: {$0.level ?? 0 < $1.level ?? 1})
//    }
    
}











//    Upload Levels ...
//        func uploadRoadMapLevels() async throws {
//
//            let level1 = Level(title: "Basic", rating: 10.0 ,categories: [
//                Category(title: "OOP", subTitle: "", description: "OOP -  rnfernk nfkjencv ejnbrjfnrjf", color: "red", rating: 0.0, subCategory: [
//                    SubCategory(title: "Наследование", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                                tests: [ ]),
//                    SubCategory(title: "Полиморфизм", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                                tests: [ ]),
//                    SubCategory(title: "Инкапсуляция", description: "", url: "", rating: 0.0, isPremiumAccess: true,
//                                tests: [ ]),
//                ]),
//                Category(title: "SOLID", subTitle: "", description: "SOLID - ", color: "blue", rating: 0.0, subCategory: [
//                    SubCategory(title: "S", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                                tests: [ ]),
//                    SubCategory(title: "O", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                                tests: [ ]),
//                    SubCategory(title: "L", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                                tests: [ ]),
//                    SubCategory(title: "I", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                                tests: [ ]),
//                    SubCategory(title: "D", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                                tests: [ ])
//                ]),
//                Category(title: "Алгоритмы", subTitle: "", description: "Алгоритмы - ", color: "brown", rating: 0.0, subCategory: [
//                    SubCategory(title: " ", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                                tests: [ ]),
//                    SubCategory(title: " ", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                                tests: [ ]),
//                    SubCategory(title: " ", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                                tests: [ ]),
//                ]),
//                Category(title: "XCode", subTitle: "", description: "XCode - mfvlem emrmkv krmfkmek knkfe kewfwf", color: "cyan", rating: 0.0, subCategory: [
//                ]),
//            ], level: 1,profession: "IOS Developer")
//
//            let level2 = Level(title: "Swift", rating: 54.0 ,categories: [
//            Category(title: "Swift", subTitle: "Swift", description: "Swift - ", color: "orange", rating: 10.0,
//                        subCategory: [
//                            SubCategory(title: "The Basics", description: "Work with common kinds of data and write basic syntax.", url: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics", rating: 55.0, isPremiumAccess: false,
//                            tests: [ ]),
//                            SubCategory(title: "Basic Operators", description: "Perform operations like assignment, arithmetic, and comparison.", url: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/basicoperators", rating: 20.0, isPremiumAccess: false,
//                            tests: [ ]),
//                            SubCategory(title: "Strings and Characters", description: "Store and manipulate text.", url: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/stringsandcharacters", rating: 50.0, isPremiumAccess: false,
//                            tests: [ ]),
//                            SubCategory(title: "Collection Types", description: "Organize data using arrays, sets, and dictionaries.", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: [ ]),
//                            SubCategory(title: "Control Flow", description: "Structure code with branches, loops, and early exits.", url: "", rating: 100.0, isPremiumAccess: false,
//                            tests: [ ]),
//                            SubCategory(title: "Functions", description: "Define and call functions, label their arguments, and use their return values.", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: []),
//                            SubCategory(title: "Closures", description: "Group code that executes together, without creating a named function.", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: []),
//                            SubCategory(title: "Enumerations", description: "Model custom types that define a list of possible values.", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: []),
//                            SubCategory(title: "Structures and Classes", description: "Model custom types that encapsulate data.", url: "", rating: 100.0, isPremiumAccess: false,
//                            tests: []),
//                            SubCategory(title: "Properties", description: "Access stored and computed values that are part of an instance or type.", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: []),
//                            SubCategory(title: "Methods", description: "Define and call functions that are part of an instance or type.", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: []),
//                            SubCategory(title: "Subscripts", description: "Access the elements of a collection.", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: []),
//                            SubCategory(title: "Inheritance", description: "Subclass to add or override functionality.", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: []),
//                            SubCategory(title: "Initialization", description: "Set the initial values for a type’s stored properties and perform one-time setup.", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: []),
//                            SubCategory(title: "Deinitialization", description: "Release resources that require custom cleanup.", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: []),
//                            SubCategory(title: "Optional Chaining", description: "Access members of an optional value without unwrapping.", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: []),
//                            SubCategory(title: "Error Handling", description: "Respond to and recover from errors.", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: []),
//                            SubCategory(title: "Concurrency", description: "Perform asynchronous operations.", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: []),
//                            SubCategory(title: "Macros", description: "Use macros to generate code at compile time.", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: []),
//                            SubCategory(title: "Type Casting", description: "Determine a value’s runtime type and give it more specific type information.", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: []),
//                            SubCategory(title: "Nested Types", description: "Define types inside the scope of another type.", url: "", rating: 100.0, isPremiumAccess: false,
//                            tests: []),
//                            SubCategory(title: "Extensions", description: "Add functionality to an existing type.", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: []),
//                            SubCategory(title: "Protocols", description: "Define requirements that conforming types must implement.", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: []),
//                            SubCategory(title: "Generics", description: "Write code that works for multiple types and specify requirements for those types.", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: []),
//                            SubCategory(title: "Opaque and Boxed Types", description: "Hide implementation details about a value’s type.", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: []),
//                            SubCategory(title: "Automatic Reference Counting", description: "Model the lifetime of objects and their relationships.", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: []),
//                            SubCategory(title: "Memory Safety", description: "Structure your code to avoid conflicts when accessing memory.", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: []),
//                            SubCategory(title: "Access Control", description: "Manage the visibility of code by declaration, file, and module.", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: []),
//                            SubCategory(title: "Advanced Operators", description: "Define custom operators, perform bitwise operations, and use builder syntax.", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: [])
//            ])
//        ], level: 2, profession: "IOS Developer")
//
//            let level3 = Level(title: "SwiftUI", rating: 54.0 ,categories: [
//            Category(title: "SwiftUI Basics Review", subTitle: "", description: "SwiftUI - ", color: "purple", rating: 20.0, subCategory: [
//                SubCategory(title: "Swift Language Essentials", description: "Before you can truly excel in SwiftUI, a solid understanding of the Swift programming language is paramount. Swift is not just the backbone of SwiftUI; it’s a powerful, intuitive language that makes coding for Apple platforms a joy. In this sub-module, you’ll revisit the core concepts of Swift, including its syntax, control flow, optionals, and data structures. Whether you’re refreshing your memory or solidifying your understanding, mastering these essentials is your key to unlocking the full potential of SwiftUI.", url: "", rating: 100.0, isPremiumAccess: false,
//                            tests: [ ]),
//                SubCategory(title: "SwiftUI Framework Overview", description: "SwiftUI is a groundbreaking framework that has transformed the way we design and build apps for Apple platforms. With its declarative syntax and data-driven approach, creating stunning, efficient user interfaces has never been easier. This sub-module provides a comprehensive overview of the SwiftUI framework, including its architecture, components, and how it integrates seamlessly with the Swift language. You’ll gain a clear understanding of why SwiftUI is the future of app development and how you can leverage its power in your projects.", url: "", rating: 30.0, isPremiumAccess: false,
//                            tests: [ ]),
//                SubCategory(title: "Understanding Declarative Syntax", description: "One of the most revolutionary aspects of SwiftUI is its declarative syntax, which allows you to describe your UI in a clear, concise manner. This approach not only makes your code more readable but also significantly reduces the amount of code needed to create complex interfaces. In this sub-module, you’ll dive deep into the principles of declarative programming and how SwiftUI applies them to make UI development a breeze. Through practical examples, you’ll learn how to think declaratively and apply these concepts to build dynamic, responsive layouts.", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: []),
//                SubCategory(title: "State and Data Flow", description: "Managing state and data flow is at the heart of every SwiftUI application. Understanding how data drives your UI and how to manage it effectively is crucial for building responsive, data-driven apps. This sub-module explores the innovative ways SwiftUI handles data and state, including the use of @State, @Binding, @ObservedObject, and more. You’ll learn how to architect your app for optimal data flow, ensuring your UI always reflects the current state of your app accurately.", url: "", rating: 10.0, isPremiumAccess: false,
//                            tests: []),
//                SubCategory(title: "Views and Modifiers", description: "Views are the building blocks of your SwiftUI app, and modifiers are the tools that shape them. Together, they offer a powerful, flexible way to create and customize your app’s interface. In this sub-module, you’ll get hands-on with creating various views and applying modifiers to style and layout your UI precisely how you want it. From text and images to complex custom views, you’ll discover the endless possibilities SwiftUI offers for crafting beautiful, engaging apps.", url: "", rating: 10.0, isPremiumAccess: false,
//                            tests: [])
//
//            ]),
//            Category(title: "Advanced UI Components", subTitle: "", description: "SwiftUI - ", color: "purple", rating: 20.0, subCategory: [
//                SubCategory(title: "Custom Views and Modifiers", description: "Dive into the world of Custom Views and Modifiers, where your creativity meets SwiftUI’s flexibility. Here, you’ll learn to craft unique components that can give your apps a distinctive look and feel. This submodule is your playground for experimenting with SwiftUI’s vast capabilities, enabling you to create reusable and efficient UI elements that stand out.", url: "", rating: 100.0, isPremiumAccess: false,
//                            tests: [ ]),
//                SubCategory(title: "Advanced List and Grids", description: "Next, we explore Advanced Lists and Grids, the backbone of displaying collections in a structured yet elegant manner. Whether you’re aiming for a simple list or a complex grid layout, mastering these components will allow you to present data beautifully and intuitively. Prepare to harness the power of SwiftUI to handle dynamic data sets with grace.", url: "", rating: 100.0, isPremiumAccess: false,
//                            tests: [ ]),
//                SubCategory(title: "Navigation and Presentation", description: "In Navigation and Presentation, you’ll navigate the crucial aspect of moving between views in your app. This submodule goes beyond the basics, introducing you to advanced techniques for creating seamless and intuitive user journeys. Learn to manage complex navigation flows and present content in innovative ways, enhancing the overall user experience.", url: "", rating: 100.0, isPremiumAccess: false,
//                            tests: [ ]),
//                SubCategory(title: "Animation and Transitions", description: "Bring your apps to life with Animation and Transitions. This exciting submodule teaches you how to incorporate motion into your UI, making interactions feel more natural and engaging. From subtle transitions to complex animations, you’ll learn how to add a layer of polish that can truly differentiate your apps.", url: "", rating: 100.0, isPremiumAccess: false,
//                            tests: [ ]),
//                SubCategory(title: "Drawing and Custom Graphics", description: "Finally, unleash your artistic side with Drawing and Custom Graphics. Discover how to draw shapes, paths, and create custom graphics that can add a unique visual touch to your apps. This submodule is perfect for those looking to push the boundaries of standard UI components and truly make their mark.", url: "", rating: 100.0, isPremiumAccess: false,
//                            tests: [ ])
//
//            ]),
//            Category(title: "Data Management", subTitle: "", description: " - ", color: "purple", rating: 20.0, subCategory: [
//                SubCategory(title: "Binding and State Management", description: "In the world of SwiftUI, understanding how to manage the state of your app is fundamental. This submodule will guide you through the intricacies of @State, @Binding, @ObservedObject, and more, enabling you to build fluid and interactive user interfaces. Learn how to keep your app’s UI in perfect sync with its underlying data model, making your apps intuitive and delightful to use.", url: "", rating: 100.0, isPremiumAccess: false,
//                            tests: [ ]),
//                SubCategory(title: "Core Data Integration", description: "Dive into the world of persistent data storage with Core Data, Apple’s powerful framework for managing an object graph. This submodule will teach you how to integrate Core Data into your SwiftUI projects, allowing you to store, retrieve, and manipulate data efficiently. From setting up your Core Data stack to performing complex queries, you’ll gain the skills to manage large datasets with ease.", url: "", rating: 100.0, isPremiumAccess: false,
//                            tests: [ ]),
//                SubCategory(title: "JSON Parsing and Networking", description: "In today’s interconnected world, your app needs to communicate with web services and APIs. This submodule focuses on fetching data from the internet, parsing JSON, and handling network requests. You’ll learn how to make your SwiftUI apps talk to RESTful APIs, handle asynchronous tasks, and present data fetched from the web seamlessly to your users.", url: "", rating: 100.0, isPremiumAccess: false,
//                            tests: [ ]),
//                SubCategory(title: "Observable Objects, Published, and Environment", description: "Master the art of reactive programming within SwiftUI by understanding @ObservableObject, @Published, and the @Environment property wrapper. This submodule will show you how to architect your app for scalability and reusability, making your code cleaner and more efficient. Learn how to propagate changes across your app’s components in a seamless and controlled manner.", url: "", rating: 100.0, isPremiumAccess: false,
//                            tests: [ ]),
//                SubCategory(title: "Combine Framework for Reactive Programming", description: "Embrace the power of reactive programming with the Combine framework. This advanced submodule will take you through the concepts of Publishers, Subscribers, and Operators, enabling you to handle complex data flows and asynchronous operations elegantly. By integrating Combine with SwiftUI, you’ll be able to create highly responsive apps that provide a superior user experience.", url: "", rating: 100.0, isPremiumAccess: false,
//                            tests: [ ]),
//
//            ]),
//            Category(title: "App Architecture", subTitle: "", description: " - ", color: "purple", rating: 20.0, subCategory: [
//                SubCategory(title: "MVVM in SwiftUI", description: "The Model-View-ViewModel (MVVM) pattern is a cornerstone of modern SwiftUI development. It promotes a clean separation of concerns, making your code more modular, easier to understand, and test. In this sub-module, you’ll learn how to effectively implement MVVM in your SwiftUI projects, ensuring your UI code remains as lean and maintainable as possible. Prepare to master the art of binding data to your UI, creating dynamic and responsive applications.", url: "", rating: 100.0, isPremiumAccess: false,
//                            tests: [ ]),
//                SubCategory(title: "Coordinator Pattern", description: "Dive into the Coordinator pattern, an advanced architectural concept that takes navigation and flow management out of your view controllers or views. This pattern simplifies the process of managing app-wide navigation logic, making your codebase more modular and navigable. You’ll explore how to implement coordinators in a SwiftUI environment, enhancing the scalability and maintainability of your applications.", url: "", rating: 100.0, isPremiumAccess: false,
//                            tests: [ ]),
//                SubCategory(title: "Dependency Injection", description: "Understanding Dependency Injection (DI) is crucial for building flexible and decoupled iOS applications. This sub-module will guide you through the concepts and practical applications of DI in SwiftUI, allowing you to develop components that are easily testable and maintainable. Learn how to leverage DI to pass dependencies into your views and view models, facilitating a more modular and testable codebase.", url: "", rating: 100.0, isPremiumAccess: false,
//                            tests: [ ]),
//                SubCategory(title: "Modular Design", description: "Embrace the power of Modular Design to build scalable and robust SwiftUI applications. This approach allows you to break down your app into smaller, independent modules, making it easier to manage, develop, and test. Discover strategies for identifying logical modules within your app, and learn how to leverage Swift Package Manager to manage these modules. This sub-module will equip you with the knowledge to build apps that can grow and evolve over time, without becoming unwieldy. By the end of the App Architecture module, you’ll have a deep understanding of the architectural patterns and principles that are essential for building sophisticated and scalable SwiftUI applications. Each sub-module is designed to build upon the last, ensuring you have a comprehensive grasp of how to architect apps that stand the test of time. Dive in, and let’s start shaping the future of your SwiftUI projects!", url: "", rating: 100.0, isPremiumAccess: false,
//                            tests: [ ])
//            ]),
//            Category(title: "Advanced SwiftUI Features", subTitle: "", description: " - ", color: "purple", rating: 20.0, subCategory: [
//                SubCategory(title: "Gestures and Haptics", description: "Gestures are the secret language between your app and users. In this submodule, you’ll learn to implement intuitive gesture controls that make your app feel alive and responsive. From simple taps to complex swipes and pinches, mastering gestures will allow you to craft an interactive user interface that delights at every touch. Haptics add a layer of physical feedback to your digital creations, making interactions tangible. You’ll explore how to integrate haptic feedback in response to gestures, enhancing the user experience with tactile sensations that guide and reassure users in their interactions with your app.", url: "", rating: 100.0, isPremiumAccess: false,
//                            tests: [ ]),
//                SubCategory(title: "Camera and Photo Library Access", description: "Unlock the full potential of the device’s camera and photo library, turning your app into a hub for visual creativity. This submodule covers everything from accessing and displaying photos to capturing new images directly within your app. You’ll learn to implement permissions, handle image data, and create a seamless experience for users who wish to capture and share their moments.", url: "", rating: 100.0, isPremiumAccess: false,
//                            tests: [ ]),
//                SubCategory(title: "MapKit and Core Location", description: "Maps and location services open a world of possibilities for app development. From displaying interactive maps to customizing annotations and tracking user location in real-time, this submodule will guide you through integrating MapKit and Core Location into your SwiftUI app, enabling you to create location-aware features that add immense value to your users.", url: "", rating: 100.0, isPremiumAccess: false,
//                            tests: [ ]),
//                SubCategory(title: "Local Notifications", description: "Stay connected with your users through timely and relevant notifications. This submodule dives into scheduling and managing local notifications, a powerful tool to engage and retain users by providing updates, reminders, or custom alerts right on their device lock screens.", url: "", rating: 100.0, isPremiumAccess: false,
//                            tests: [ ]),
//                SubCategory(title: "SiriKit Integration", description: "Voice is the future of human-computer interaction, and with SiriKit, your app can be a part of that future. Learn to integrate SiriKit to handle voice commands, making your app accessible and convenient to use without even touching the screen. From setting tasks to querying information, voice integration will make your app a personal assistant to your users. As you progress through the “Advanced SwiftUI Features” module, remember that each of these submodules is a stepping stone towards creating an app that not only functions flawlessly but also provides an unparalleled user experience. Dive in with curiosity and creativity, and let’s bring your visionary app ideas to life!", url: "", rating: 100.0, isPremiumAccess: false,
//                            tests: [ ]),
//
//            ]),
//            Category(title: "Testing and Debugging", subTitle: "", description: " - ", color: "purple", rating: 20.0, subCategory: [
//                SubCategory(title: "Unit Testing SwiftUI Apps", description: "Unit testing is your first line of defense against bugs. It allows you to verify that individual parts of your app work as expected. In this submodule, you’ll learn how to write and run unit tests specifically for SwiftUI apps, ensuring your codebase is solid and error-free. We’ll explore the XCTest framework and how to leverage it to test your app’s logic, models, and more.", url: "", rating: 100.0, isPremiumAccess: false,
//                            tests: [ ]),
//                SubCategory(title: "UI Testing", description: "UI testing takes things a step further by simulating user interactions with your app. This submodule will guide you through creating UI tests in SwiftUI, allowing you to automate the process of checking UI elements like buttons, sliders, and text fields. You’ll learn how to use Xcode’s UI Testing framework to ensure your app not only looks good but is also intuitive and accessible to your users.", url: "", rating: 100.0, isPremiumAccess: false,
//                            tests: [ ]),
//                SubCategory(title: "Debugging Techniques", description: "Every developer’s journey involves encountering and solving bugs. This submodule is your guide to mastering the art of debugging in SwiftUI. You’ll learn various techniques and tools available in Xcode to help you quickly identify and fix issues in your code. From breakpoints to the LLDB debugger, you’ll gain the skills to keep your development process smooth and efficient.", url: "", rating: 100.0, isPremiumAccess: false,
//                            tests: [ ]),
//                SubCategory(title: "Performance Optimization", description: "The final piece of the puzzle is ensuring your app runs smoothly across all devices. In this submodule, you’ll dive into performance optimization techniques specific to SwiftUI. Learn how to profile your app using Xcode’s Instruments tool, identify bottlenecks, and implement best practices to enhance your app’s speed and responsiveness. This knowledge is key to delivering a top-notch user experience. By the end of this module, you’ll be equipped with the skills to test, debug, and optimize your SwiftUI apps like a pro. These are indispensable tools in your arsenal, ensuring your projects are not only functional but also polished and professional. Let’s get started and take your SwiftUI apps to the next level!", url: "", rating: 100.0, isPremiumAccess: false,
//                            tests: [ ])
//
//            ]),
//            Category(title: "Cross-Platform Development", subTitle: "", description: " - ", color: "purple", rating: 20.0, subCategory: [
//                SubCategory(title: "Building for macOS", description: "Dive into the realm of macOS development, where the power of SwiftUI enables you to craft stunning desktop applications. This submodule will guide you through the nuances of macOS design patterns, menu bars, and window management, ensuring your apps not only look fantastic but also integrate seamlessly with the macOS ecosystem. Embrace the challenge and expand your app’s reach to the desktop!", url: "", rating: 100.0, isPremiumAccess: false,
//                            tests: [ ]),
//                SubCategory(title: "Building for watchOS", description: "Next, we’ll shrink the canvas but not the ambition, as we explore building for watchOS. Designing for the wrist demands precision and ingenuity. This submodule will teach you how to create compelling, glanceable interfaces that deliver key information and interactions right from the user’s wrist. Learn to leverage the unique features of watchOS, such as complications and the Digital Crown, to provide an intimate and engaging user experience.", url: "", rating: 100.0, isPremiumAccess: false,
//                            tests: [ ]),
//                SubCategory(title: "Building for tvOS", description: "Prepare to go big as we shift our focus to tvOS. Developing for the living room’s centerpiece offers a unique opportunity to craft immersive experiences on a grand scale. This submodule will cover the essentials of tvOS, including navigation, focus management, and the use of the Siri Remote. Discover how to bring your apps to life on the big screen, where they can be enjoyed by everyone in the room.", url: "", rating: 100.0, isPremiumAccess: false,
//                            tests: [ ]),
//                SubCategory(title: "Adaptive Layouts for Different Screen Sizes", description: "The final piece of the cross-platform puzzle is mastering adaptive layouts. In this submodule, you’ll learn the secrets to designing flexible interfaces that look and work beautifully across all device sizes and orientations. From the compact screen of the Apple Watch to the expansive display of the Apple TV, and everything in between, you’ll gain the skills to ensure your apps are accessible, attractive, and user-friendly, no matter where they’re running. By conquering the Cross-Platform Development module, you’ll not only broaden the reach of your applications but also significantly enhance your attractiveness to potential employers. Each platform offers its own set of challenges and opportunities, and mastering them will make you a versatile and valuable asset in the app development world. Let’s get started on this exciting journey to make your apps truly universal!", url: "", rating: 100.0, isPremiumAccess: false,
//                            tests: [ ])
//
//            ]),
//
//        ], level: 3, profession: "IOS Developer")
//
//            let level4 = Level(title: "UIKit", rating: 54.0 ,categories: [
//            Category(title: "UIKit", subTitle: "UIKit Road Map", description: "UIKit - ", color: "blue", rating: 0.0, subCategory: [
//                SubCategory(title: "The Basics", description: "Work with common kinds of data and write basic syntax.", url: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics", rating: 10.0, isPremiumAccess: false,
//                            tests: []),
//                SubCategory(title: "Basic Operators", description: "Perform operations like assignment, arithmetic, and comparison.", url: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/basicoperators", rating: 100.0, isPremiumAccess: false,
//                            tests: []),
//                SubCategory(title: "Strings and Characters", description: "Store and manipulate text.", url: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/stringsandcharacters", rating: 0.0, isPremiumAccess: false,
//                            tests: [])
//            ])
//        ], level: 4, profession: "IOS Developer")
//
//            let level5 = Level(title: "Project", rating: 100 ,categories: [
//                Category(title: "Real-World Project Building", subTitle: "", description: "Real-World Project Building - ", color: "green", rating: 0.0, subCategory: [
//                    SubCategory(title: "Ideation and Prototyping", description: "Before any code is written, the journey of app creation begins with a spark of imagination. In Ideation and Prototyping, you’ll learn how to harness your creativity to generate innovative app ideas. This submodule will guide you through techniques for brainstorming, validating your concepts, and sketching out your ideas. Then, you’ll dive into prototyping tools that bring your sketches to life, allowing you to visualize the flow and feel of your app early in the development process. This stage is crucial for setting a solid foundation for your project, ensuring that your efforts are aligned with a clear vision.", url: "", rating: 0.0, isPremiumAccess: false,
//                                tests: []),
//                    SubCategory(title: "Project Planning and Management", description: "With a prototype in hand, it’s time to plan how to turn it into a fully functioning app. Project Planning and Management introduces you to the methodologies and tools that help you organize, schedule, and track your development process. From Agile and Scrum to Kanban, you’ll discover the project management techniques that best fit your working style and project needs. This submodule emphasizes the importance of effective communication, time management, and collaboration skills, preparing you to lead or contribute to development teams efficiently.", url: "", rating: 0.0, isPremiumAccess: false,
//                                tests: []),
//                    SubCategory(title: "Building a Complete SwiftUI App", description: "Now, the real fun begins. Building a Complete SwiftUI App is where you apply everything you’ve learned to create a fully functional application. This submodule walks you through the development process step by step, from setting up your project in Xcode to writing the last line of code. You’ll integrate UI components, manage data flow, and ensure your app’s architecture is solid and scalable. By the end of this submodule, you’ll have a portfolio-ready app and the confidence to tackle any SwiftUI project that comes your way.", url: "", rating: 0.0, isPremiumAccess: false,
//                                tests: []),
//                    SubCategory(title: "Incorporating Third-Party Libraries and APIs", description: "No app is an island, and in Incorporating Third-Party Libraries and APIs, you’ll learn how to extend the functionality of your apps by leveraging external resources. This submodule covers how to choose the right libraries and APIs for your project, integrate them seamlessly, and handle dependencies. Whether you’re adding authentication, social media integration, or advanced data processing capabilities, this submodule ensures you can build on the work of others to enrich your app’s features and user experience.", url: "", rating: 0.0, isPremiumAccess: false,
//                                tests: []),
//                    SubCategory(title: "User Authentication and Authorization", description: "In today’s digital world, security is paramount. User Authentication and Authorization teaches you how to protect your users and their data. You’ll implement login systems, manage user sessions, and ensure that users can only access the features and data they’re entitled to. This submodule not only covers the technical aspects of authentication and authorization but also introduces best practices for privacy and security, preparing you to build trust with your users from the start.", url: "", rating: 0.0, isPremiumAccess: false,
//                                tests: [])
//                ]),
//                Category(title: "App Distribution", subTitle: "", description: "App Distribution - ", color: "mint", rating: 0.0, subCategory: [
//                    SubCategory(title: "App Store Submission Process", description: "The App Store is the gateway to visibility and success for your iOS app. Understanding the submission process is crucial for a smooth approval journey. This sub-module covers everything from preparing your app for submission, understanding Apple’s guidelines, to navigating the actual submission process. You’ll learn how to make your app stand out and ensure it meets all the necessary criteria for approval.", url: "", rating: 0.0, isPremiumAccess: false,
//                                tests: []),
//                    SubCategory(title: "TestFlight Beta Testing", description: "Before your app makes its grand debut on the App Store, ensuring its quality and user experience is paramount. TestFlight is Apple’s beta testing program that allows you to invite users to test your app and provide valuable feedback. This sub-module will teach you how to set up beta tests, manage feedback, and iterate on your app to perfect it before the official launch.", url: "", rating: 0.0, isPremiumAccess: false,
//                                tests: []),
//                    SubCategory(title: "App Store Optimization (ASO)", description: "With millions of apps on the App Store, standing out is a challenge. App Store Optimization (ASO) is the key to improving your app’s visibility and attracting more downloads. This sub-module delves into strategies for optimizing your app’s title, keywords, description, and screenshots to rank higher in search results and captivate potential users.", url: "", rating: 0.0, isPremiumAccess: false,
//                                tests: []),
//                    SubCategory(title: "Continuous Integration and Continuous Deployment (CI/CD)", description: "In the fast-paced world of app development, efficiency and quality are king. Continuous Integration and Continuous Deployment (CI/CD) practices allow you to automate the testing and deployment of your apps, ensuring that you can quickly release new features while maintaining high standards. This sub-module explores setting up CI/CD pipelines, automating your workflow, and ensuring that your app remains bug-free and up-to-date.", url: "", rating: 0.0, isPremiumAccess: false,
//                                tests: [])
//                ]),
//            ], level: 5, profession: "IOS Developer")
//
//            let level6 = Level(title: "Professional Skills", rating: 100 ,categories: [
//                Category(title: "Резюме", subTitle: "", description: "Резюме - ", color: "green", rating: 0.0, subCategory: [
//                    SubCategory(title: "Фото", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                                tests: []),
//                    SubCategory(title: "Заголовок", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                                tests: []),
//                    SubCategory(title: "Навыки", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                                tests: []),
//                    SubCategory(title: "Обучение", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                                tests: []),
//                    SubCategory(title: "Опыт работы", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                                tests: []),
//                    SubCategory(title: "О себе", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                                tests: []),
//                    SubCategory(title: "Сопроводительное письмо", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                                tests: [])
//                ]),
//                Category(title: "Подготовка к собеседованию", subTitle: "", description: "Подготовка к собеседованию - ", color: "indigo", rating: 0.0, subCategory: [
//                    SubCategory(title: "HR", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                                tests: []),
//                    SubCategory(title: "Техническое интервью", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                                tests: [])
//                ]),
//                Category(title: "Professional Skills and Employment", subTitle: "", description: "Professional Skills and Employment", color: "mint", rating: 0.0, subCategory: [
//                    SubCategory(title: "Building a Portfolio", description: "When you’re venturing into the world of SwiftUI and aiming for employment, one of the most crucial steps you can take is building a compelling portfolio. This is not just a collection of your work; it’s a testament to your skills, creativity, and dedication. It’s what stands between you and your dream job. Let’s dive into how you can build a portfolio that not only showcases your technical prowess but also tells your unique story as a developer.", url: "", rating: 0.0, isPremiumAccess: false,
//                                tests: []),
//                    SubCategory(title: "Open Source Contributions", description: "Contributing to open-source projects is not just about coding. It’s about being part of a community that shares your interests and passions. It’s about learning, growing, and making a difference in the world of technology. Whether you’re fixing bugs, adding new features, or improving documentation, every contribution counts. In this module, we’ll explore the ins and outs of open-source contributions, specifically within the context of SwiftUI and the broader iOS development ecosystem.", url: "", rating: 0.0, isPremiumAccess: false,
//                                tests: []),
//                    SubCategory(title: "Networking and Community Participation", description: "In the realm of software development, especially within the vibrant ecosystem of SwiftUI, networking and community participation are not just beneficial; they are essential. This module will guide you through the intricacies of building meaningful connections, contributing to the community, and leveraging these experiences towards achieving your goal of employment in the field.", url: "", rating: 0.0, isPremiumAccess: false,
//                                tests: []),
//                    SubCategory(title: "Interview Preparation for SwiftUI Developers", description: "Interview preparation is a crucial step towards securing a job as a SwiftUI developer. It’s not just about showcasing your technical skills but also demonstrating your problem-solving abilities, communication skills, and cultural fit for the company. Let’s dive into how you can prepare effectively, making your interview process not just successful but also an opportunity for personal growth.", url: "", rating: 0.0, isPremiumAccess: false,
//                                tests: []),
//                    SubCategory(title: "Negotiating Job Offers", description: "Congratulations on reaching the final stretch of your SwiftUI learning journey! By now, you’ve amassed a wealth of knowledge and skills, making you a prime candidate for numerous exciting opportunities in the tech industry. The last hurdle before you embark on your professional career is mastering the art of negotiating job offers. This module is designed to equip you with the strategies and confidence needed to ensure you not only land a job but secure terms that align with your value and expectations.", url: "", rating: 0.0, isPremiumAccess: false,
//                                tests: [])
//
//                ])
//            ], level: 6, profession: "IOS Developer")
//
//            let levelArray = [level1, level2, level3, level4, level5, level6]
//
//            for level in levelArray {
//                try? await RoadMapManager.shared.uploadLevels(level: level)
//            }
//
//        }
   

//    func uploadRoadMapLevels() async throws {
//        
//        let level1 = Level(title: "Level 1", rating: 10.0 ,categories: [
//            Category(title: "OOP", subTitle: "", description: "OOP -  rnfernk nfkjencv ejnbrjfnrjf", color: "red", rating: 0.0, subCategory: [
//                SubCategory(title: "Наследование", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: [
//                                Quiz(title: "Easy Level", description: "", rating: 0.0, questions: [
//                                    Question(title: "Question 1", description: "description 3", answers: ["Answer 1", "Answer 2", "Answer 3", "Answer 4"], correctAnswer: "Answer 3", clue: Clue(title: "Clue Title", description: "Clue Description", url: "")),
//                                    Question(title: "Question 2", description: "description 2", answers: ["Answer 1", "Answer 2", "Answer 3", "Answer 4"], correctAnswer: "Answer 2", clue: Clue(title: "Clue Title", description: "Clue Description", url: "")),
//                                    Question(title: "Question 3", description: "description 1", answers: ["Answer 1", "Answer 2", "Answer 3", "Answer 4"], correctAnswer: "Answer 1", clue: Clue(title: "Clue Title", description: "Clue Description", url: "")),
//                                    Question(title: "Question 4", description: "description 2", answers: ["Answer 1", "Answer 2", "Answer 3", "Answer 4"], correctAnswer: "Answer 2", clue: Clue(title: "Clue Title", description: "Clue Description", url: "")),
//                                    ]),
//                                Quiz(title: "Medium Level", description: "", rating: 0.0, questions: [
//                                    Question(title: "Question 1", description: "description 3", answers: ["Answer 1", "Answer 2", "Answer 3", "Answer 4"], correctAnswer: "Answer 3", clue: Clue(title: "Clue Title", description: "Clue Description", url: "")),
//                                    Question(title: "Question 2", description: "description 2", answers: ["Answer 1", "Answer 2", "Answer 3", "Answer 4"], correctAnswer: "Answer 2", clue: Clue(title: "Clue Title", description: "Clue Description", url: "")),
//                                    Question(title: "Question 3", description: "description 1", answers: ["Answer 1", "Answer 2", "Answer 3", "Answer 4"], correctAnswer: "Answer 1", clue: Clue(title: "Clue Title", description: "Clue Description", url: "")),
//                                    Question(title: "Question 4", description: "description 2", answers: ["Answer 1", "Answer 2", "Answer 3", "Answer 4"], correctAnswer: "Answer 2", clue: Clue(title: "Clue Title", description: "Clue Description", url: "")),
//                                ]),
//                                Quiz(title: "Hard Level", description: "", rating: 0.0, questions: [ ])
//                            ]),
//                SubCategory(title: "Полиморфизм", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: [ ]),
//                SubCategory(title: "Инкапсуляция", description: "", url: "", rating: 0.0, isPremiumAccess: true,
//                            tests: [ ]),
//            ]),
//            Category(title: "SOLID", subTitle: "", description: "SOLID - ", color: "blue", rating: 0.0, subCategory: [
//                SubCategory(title: "S", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: [ ]),
//                SubCategory(title: "O", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: [ ]),
//                SubCategory(title: "L", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: [ ]),
//                SubCategory(title: "I", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: [ ]),
//                SubCategory(title: "D", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: [ ])
//            ]),
//            Category(title: "Алгоритмы", subTitle: "", description: "Алгоритмы - ", color: "brown", rating: 0.0, subCategory: [
//                SubCategory(title: " ", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: [ ]),
//                SubCategory(title: " ", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: [ ]),
//                SubCategory(title: " ", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: [ ]),
//            ]),
//            Category(title: "XCode", subTitle: "", description: "XCode - mfvlem emrmkv krmfkmek knkfe kewfwf", color: "cyan", rating: 0.0, subCategory: [
//            ]),
//        ])
//        
//        let level2 = Level(title: "Level 2", rating: 54.0 ,categories: [
//        Category(title: "Swift", subTitle: "Swift", description: "Swift - ", color: "orange", rating: 10.0,
//                    subCategory: [
//                        SubCategory(title: "The Basics", description: "Work with common kinds of data and write basic syntax.", url: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics", rating: 55.0, isPremiumAccess: false,
//                        tests: [ ]),
//                        SubCategory(title: "Basic Operators", description: "Perform operations like assignment, arithmetic, and comparison.", url: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/basicoperators", rating: 20.0, isPremiumAccess: false,
//                        tests: [ ]),
//                        SubCategory(title: "Strings and Characters", description: "Store and manipulate text.", url: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/stringsandcharacters", rating: 50.0, isPremiumAccess: false,
//                        tests: [ ]),
//                        SubCategory(title: "Collection Types", description: "Organize data using arrays, sets, and dictionaries.", url: "", rating: 0.0, isPremiumAccess: false,
//                        tests: [ ]),
//                        SubCategory(title: "Control Flow", description: "Structure code with branches, loops, and early exits.", url: "", rating: 100.0, isPremiumAccess: false,
//                        tests: [ ]),
//                        SubCategory(title: "Functions", description: "Define and call functions, label their arguments, and use their return values.", url: "", rating: 0.0, isPremiumAccess: false,
//                        tests: []),
//                        SubCategory(title: "Closures", description: "Group code that executes together, without creating a named function.", url: "", rating: 0.0, isPremiumAccess: false,
//                        tests: []),
//                        SubCategory(title: "Enumerations", description: "Model custom types that define a list of possible values.", url: "", rating: 0.0, isPremiumAccess: false,
//                        tests: []),
//                        SubCategory(title: "Structures and Classes", description: "Model custom types that encapsulate data.", url: "", rating: 100.0, isPremiumAccess: false,
//                        tests: []),
//                        SubCategory(title: "Properties", description: "Access stored and computed values that are part of an instance or type.", url: "", rating: 0.0, isPremiumAccess: false,
//                        tests: []),
//                        SubCategory(title: "Methods", description: "Define and call functions that are part of an instance or type.", url: "", rating: 0.0, isPremiumAccess: false,
//                        tests: []),
//                        SubCategory(title: "Subscripts", description: "Access the elements of a collection.", url: "", rating: 0.0, isPremiumAccess: false,
//                        tests: []),
//                        SubCategory(title: "Inheritance", description: "Subclass to add or override functionality.", url: "", rating: 0.0, isPremiumAccess: false,
//                        tests: []),
//                        SubCategory(title: "Initialization", description: "Set the initial values for a type’s stored properties and perform one-time setup.", url: "", rating: 0.0, isPremiumAccess: false,
//                        tests: []),
//                        SubCategory(title: "Deinitialization", description: "Release resources that require custom cleanup.", url: "", rating: 0.0, isPremiumAccess: false,
//                        tests: []),
//                        SubCategory(title: "Optional Chaining", description: "Access members of an optional value without unwrapping.", url: "", rating: 0.0, isPremiumAccess: false,
//                        tests: []),
//                        SubCategory(title: "Error Handling", description: "Respond to and recover from errors.", url: "", rating: 0.0, isPremiumAccess: false,
//                        tests: []),
//                        SubCategory(title: "Concurrency", description: "Perform asynchronous operations.", url: "", rating: 0.0, isPremiumAccess: false,
//                        tests: []),
//                        SubCategory(title: "Macros", description: "Use macros to generate code at compile time.", url: "", rating: 0.0, isPremiumAccess: false,
//                        tests: []),
//                        SubCategory(title: "Type Casting", description: "Determine a value’s runtime type and give it more specific type information.", url: "", rating: 0.0, isPremiumAccess: false,
//                        tests: []),
//                        SubCategory(title: "Nested Types", description: "Define types inside the scope of another type.", url: "", rating: 100.0, isPremiumAccess: false,
//                        tests: []),
//                        SubCategory(title: "Extensions", description: "Add functionality to an existing type.", url: "", rating: 0.0, isPremiumAccess: false,
//                        tests: []),
//                        SubCategory(title: "Protocols", description: "Define requirements that conforming types must implement.", url: "", rating: 0.0, isPremiumAccess: false,
//                        tests: []),
//                        SubCategory(title: "Generics", description: "Write code that works for multiple types and specify requirements for those types.", url: "", rating: 0.0, isPremiumAccess: false,
//                        tests: []),
//                        SubCategory(title: "Opaque and Boxed Types", description: "Hide implementation details about a value’s type.", url: "", rating: 0.0, isPremiumAccess: false,
//                        tests: []),
//                        SubCategory(title: "Automatic Reference Counting", description: "Model the lifetime of objects and their relationships.", url: "", rating: 0.0, isPremiumAccess: false,
//                        tests: []),
//                        SubCategory(title: "Memory Safety", description: "Structure your code to avoid conflicts when accessing memory.", url: "", rating: 0.0, isPremiumAccess: false,
//                        tests: []),
//                        SubCategory(title: "Access Control", description: "Manage the visibility of code by declaration, file, and module.", url: "", rating: 0.0, isPremiumAccess: false,
//                        tests: []),
//                        SubCategory(title: "Advanced Operators", description: "Define custom operators, perform bitwise operations, and use builder syntax.", url: "", rating: 0.0, isPremiumAccess: false,
//                        tests: [])
//        ]),
//        Category(title: "SwiftUI", subTitle: "SwiftUI Road Map", description: "SwiftUI - ", color: "purple", rating: 20.0, subCategory: [
//            SubCategory(title: "Text", description: "", url: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics", rating: 100.0, isPremiumAccess: false,
//                        tests: [ ]),
//            SubCategory(title: "VStack", description: "", url: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics", rating: 30.0, isPremiumAccess: false,
//                        tests: [ ]),
//            SubCategory(title: "HStack", description: "", url: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics", rating: 0.0, isPremiumAccess: false,
//                        tests: []),
//            SubCategory(title: "ZStack", description: "", url: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics", rating: 10.0, isPremiumAccess: false,
//                        tests: []),
//            SubCategory(title: " ", description: "", url: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics", rating: 0.0, isPremiumAccess: false,
//                        tests: []),
//            SubCategory(title: " ", description: "", url: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics", rating: 0.0, isPremiumAccess: false,
//                        tests: []),
//            SubCategory(title: " ", description: "", url: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics", rating: 0.0, isPremiumAccess: false,
//                        tests: []),
//            SubCategory(title: " ", description: "", url: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics", rating: 0.0, isPremiumAccess: false,
//                        tests: [])
//        ]),
//        Category(title: "UIKit", subTitle: "UIKit Road Map", description: "UIKit - ", color: "blue", rating: 0.0, subCategory: [
//            SubCategory(title: "The Basics", description: "Work with common kinds of data and write basic syntax.", url: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics", rating: 10.0, isPremiumAccess: false,
//                        tests: []),
//            SubCategory(title: "Basic Operators", description: "Perform operations like assignment, arithmetic, and comparison.", url: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/basicoperators", rating: 100.0, isPremiumAccess: false,
//                        tests: []),
//            SubCategory(title: "Strings and Characters", description: "Store and manipulate text.", url: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/stringsandcharacters", rating: 0.0, isPremiumAccess: false,
//                        tests: [])
//        ])
//    ])
//        
//        let level3 = Level(title: "Level 3", rating: 100 ,categories: [
//            Category(title: "Проект", subTitle: "", description: "Проект - ", color: "mint", rating: 0.0, subCategory: [
//                SubCategory(title: "Создание, Реализация и размещение проекта на GitHub", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: []),
//                SubCategory(title: "Размещение проекта в AppStore", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: [])
//            ]),
//            Category(title: "Резюме", subTitle: "", description: "Резюме - ", color: "green", rating: 0.0, subCategory: [
//                SubCategory(title: "Фото", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: []),
//                SubCategory(title: "Заголовок", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: []),
//                SubCategory(title: "Навыки", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: []),
//                SubCategory(title: "Обучение", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: []),
//                SubCategory(title: "Опыт работы", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: []),
//                SubCategory(title: "О себе", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: []),
//                SubCategory(title: "Сопроводительное письмо", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: [])
//            ]),
//            Category(title: "Подготовка к собеседованию", subTitle: "", description: "Подготовка к собеседованию - ", color: "indigo", rating: 0.0, subCategory: [
//                SubCategory(title: "HR", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: []),
//                SubCategory(title: "Техническое интервью", description: "", url: "", rating: 0.0, isPremiumAccess: false,
//                            tests: [])
//            ])
//        ])
//
//        let levelArray = [level1, level2, level3]
//
//        for level in levelArray {
//            try await RoadMapManager.shared.uploadLevels(level: level)
//        }
//
//    }

//    func uploadTips() async throws {
//        let tipArray = [Tip(title: "Если вы хотите овладеть привычкой, ключ в том, чтобы начать с повторения, а не совершенства."), Tip(title: "Когда вы влюбляетесь в процесс, а не в конечный результат, вам не нужно ждать, чтобы дать себе разрешение быть счастливым."), Tip(title: ""), Tip(title: ""), Tip(title: ""), Tip(title: ""), Tip(title: ""), Tip(title: ""), Tip(title: ""), Tip(title: ""), Tip(title: ""), Tip(title: ""), Tip(title: ""), Tip(title: ""), Tip(title: ""), Tip(title: ""), Tip(title: ""), Tip(title: ""), Tip(title: ""), Tip(title: ""), Tip(title: ""), Tip(title: ""), Tip(title: ""), Tip(title: ""), Tip(title: ""), Tip(title: ""), Tip(title: ""), Tip(title: ""), Tip(title: ""), Tip(title: ""), Tip(title: ""), Tip(title: ""), Tip(title: ""), Tip(title: ""), Tip(title: ""), Tip(title: "")]
//
//               for tip in tipArray {
//                   try await RoadMapManager.shared.uploadTips(tip: tip)
//               }
//    }
