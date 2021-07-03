import CoreData

import SwiftUI

struct ContentView: View {
 
// Запись данных из глобального хранилища в локальный параметр ( ссылка на сам Environment)
  @Environment(\.managedObjectContext) var moc
  
  //Запрос в Coredata, без сортировки и запись полученного ответа в переменную
  @FetchRequest(entity: Student.entity(), sortDescriptors: []) var students: FetchedResults<Student>
  
  
  var body: some View {
    VStack {
      
      List {
        ForEach(students, id: \.id) { student in
          Text(student.name ?? "Unknown")
        }
      }
      
      Button("Add") {
        
        let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
        
        let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]
        
        
        let chosenFirstName = firstNames.randomElement()!
        
        let chosenLastName = lastNames.randomElement()!
        
        
        /// Объект записи БД
        let student = Student(context: self.moc)
        
        student.id = UUID()
        
        student.name = "\(chosenFirstName) \(chosenLastName)"
        
//        Попытка сохранения в контейнер всей информации
        try? self.moc.save()
        
      }
    }
  }
}





//// Два класса размеров по горизонтали и вертикали, которые называются «компактный» и «обычный». Вот и все - он охватывает все размеры экрана, от самого большого iPad Pro в альбомной ориентации до самого маленького iPhone в портретной ориентации.
//struct ContentView: View {
//  @Environment(\.horizontalSizeClass) var sizeClass
//  
//  var body: some View {
//    if sizeClass == .compact {
//      return AnyView {
//      Text ("Active class is:")
//      Text("COMPACT")
//      }
//    .font(.largeTitle)
//    } else {
//      return AnyView {
//        Text ("Active class is:")
//        Text("REGULAR")
//      }
//    .font(.largeTitle)
//    }
//  }
//}


//// Новый вид кнопки, которая остается нажатой после нажатия, но пока мы не воспользовались Binding происходит следующее: односторонний поток данных
//// ContentView имеет свое логическое значение RememberMe, которое используется для создания PushButton - кнопка имеет начальное значение, предоставляемое ContentView. Однако, как только кнопка была создана, она берет на себя управление значением: она переключает свойство isOn между true и false внутри кнопки, но не передает это изменение обратно в ContentView.
//  struct  PushButton: View {
//    let title: String
//
////    @Binding позволяет нам создавать двустороннее соединение между PushButton и всем, что его использует, так что при изменении одного значения меняет другое.
//    @Binding var isOn: Bool
//
//    var onColors = [Color.red, Color.yellow]
//    var offColors = [Color(white: 0.6), Color(white: 0.4)]
//
//    var body: some View {
//      Button(title) {
//        self.isOn.toggle()
//      }
//      .padding()
//
////      Задний вид
//      .background(LinearGradient(gradient: Gradient(colors: isOn ? onColors : offColors), startPoint: .top, endPoint: .bottom))
//
////      Передний план
//      .foregroundColor(.white)
//
////      Форма кнопки
//      .clipShape(Capsule())
//
////      Наличие тени
//      .shadow(radius: isOn ? 0 : 5)
//    }
//  }
//
//struct ContentView: View {
//  @State private var rememberMe = false
//
//  var body: some View {
//    VStack {
//
////      Необходимо использовать $ - передача самой привязки, а не логического значения внутри
//      PushButton(title: "Remember me", isOn: $rememberMe)
//      Text(rememberMe ? "On" : "Off")
//    }
//  }
//}


