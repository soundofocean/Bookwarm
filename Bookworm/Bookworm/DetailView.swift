import CoreData
import SwiftUI

struct DetailView: View {
  
  let book: Book
  
  // Хранение контекста управляемого объекта Core Data (для удаления данных)
  @Environment(\.managedObjectContext) var moc
  
  // Хранение нашего режима View ( выталкивание View из стека навигации)
  @Environment(\.presentationMode) var presentationMode
  
  // Контроль, показываем ли  предупреждение о подтверждении удаления или нет
  @State private var showingDeleteAlert = false
  
  var body: some View {
    GeometryReader { geometry in
      VStack {
        
        // Название жанра в нижний правый угол ZStack с цветом фона, жирным шрифтом и небольшим отступом, чтобы выделить его.
        ZStack {
          Image(self.book.genre ?? "Fantasy")
            
            // Границы рамки изображения
            .frame(maxWidth: geometry.size.width)
          
          Text(self.book.genre? .uppercased() ?? "FANTASY")
            
            // Установка шрифта заголовка
            .font(.caption)
            
            // Установка толщины шрифта
            .fontWeight(.black)
            .padding(8)
            
            // Цвет переднего плана
            .foregroundColor(.white)
            
            // Цвет заднего плана
            .background(Color.black.opacity(0.75))
            
            // Форма кнопки
            .clipShape(Capsule())
            
            // Смещение по горизонтали и вертикали
            .offset(x: -5, y: -5)
        }
        
        Text(self.book.author ?? "Unknow author")
          .font(.title)
          .foregroundColor(.secondary)
        
        Text(self.book.review ?? "No review")
          .padding()
        
        RatingView(rating: .constant(Int(self.book.rating)))
          .font(.largeTitle)
        
        Spacer()
      }
    }
    
    .navigationBarTitle(Text(book.tittle ?? "Unknow Book"), displayMode: .inline)
    
    .alert(isPresented: $showingDeleteAlert) {
      Alert(title: Text("Delete book"), message: Text("Are you sure?"),
            primaryButton: .destructive(Text("Delete")) {
        self.deleteBook()
      }, secondaryButton: .cancel()
      )
    }
    
    .navigationBarItems(trailing: Button(action: {
      self.showingDeleteAlert = true
    }) {
      Image(systemName: "trash")
    })
  }
  
  /// Удаление текущей книги
  func deleteBook() {
    moc.delete(book)
    
    // Отклонение текущего View
    presentationMode.wrappedValue.dismiss()
  }
}

struct DetailView_Previews: PreviewProvider {
  
  static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
  static var previews: some View {
    
    let book = Book(context: moc)
    book.tittle = "Test book"
    book.author = "Test author"
    book.genre = "Fantasy"
    book.rating = 4
    book.review = "This was a great book; I really enjoyed it."
    return NavigationView {
      DetailView(book: book)
    }
  }
}
