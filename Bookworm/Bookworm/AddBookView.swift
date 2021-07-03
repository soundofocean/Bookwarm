import SwiftUI

/// Экран добавления книги
struct AddBookView: View {
  
  //  Запись данных из глобального хранилища в локальный параметр ( ссылка на сам Environment)
  @Environment(\.managedObjectContext) var moc
  
  //   Отслеживание текущего режима презентации
  @Environment(\.presentationMode) var presentationMode
  
  /// Заголовок
  @State private var tittle = ""
  
  /// Автор
  @State private var author = ""
  
  /// Рейтинг
  @State private var rating = 3
  
  /// Жанр
  @State private var genre = ""
  
  /// Резюме
  @State private var review = ""
  
  var body: some View {
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    NavigationView {
      Form {
        Section {
          
          TextField("Name of book", text: $tittle)
          
          TextField("Author's name", text: $author)
          
          Picker("Genre", selection: $genre) {
            
            ForEach(genres, id: \.self) {
              Text($0)
            }
          }
        }
        
        //        Вторая секция с открытием экрана с рейтингом и текстовое поле с описанием ревью
        Section {
          RatingView(rating: $rating)
          TextField("Write a review", text: $review)
        }
        
        Section {
          Button("Save") {
            
            /// Объект записи БД
            let newBook = Book(context: self.moc)
            
            //            Копируем все значения из формы
            newBook.tittle = self.tittle
            newBook.author = self.author
            newBook.rating = Int16(self.rating)
            newBook.genre = self.genre
            newBook.review = self.review
            
            //            Сохранение в контейнер информации
            try? self.moc.save()
            
            //          Отклонение представления, если оно есть в данный момент.
            self.presentationMode.wrappedValue.dismiss()
            
          }
        }
      }
      
      //      Заголовок панели навигации этого представления с локализованной строкой
      .navigationBarTitle("Add Book")
    }
  }
}

struct AddBookView_Previews: PreviewProvider {
  static var previews: some View {
    AddBookView()
  }
}
