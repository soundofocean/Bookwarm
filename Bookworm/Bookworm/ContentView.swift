import SwiftUI


struct ContentView: View {
  
  //  Запись данных из глобального хранилища в локальный параметр ( ссылка на сам Environment) (для того, чтобы MOC можно было передать из AddBookView)
  @Environment(\.managedObjectContext) var moc
  
  //Запрос в Coredata, без сортировки и запись полученного ответа в переменную + сортировка в алфавитном порядке заголовка
  //  @FetchRequest(entity: Book.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Book.tittle, ascending: true)]) var books: FetchedResults<Book>
  
  // Название книги было отсортировано первым по возрастанию, а затем автор книги - вторым:
  @FetchRequest(entity: Book.entity(), sortDescriptors: [
    NSSortDescriptor(keyPath: \Book.tittle, ascending: true),
    NSSortDescriptor(keyPath: \Book.author, ascending: true)
  ]) var books: FetchedResults<Book>
  
  /// Переменная, отвечающая за показ экрана добавления книги
  @State private var showingAddScreen = false
  var body: some View {
    
    NavigationView {
      List {
        ForEach(books, id: \.self) { book in
          NavigationLink(destination: DetailView(book: book)) {
            EmojiRatingView(rating: book.rating)
              .font(.largeTitle)
            
            VStack(alignment: .leading) {
              Text(book.title ?? "Unknown Title")
                .font(.headline)
              Text(book.author ?? "Unknown Author")
                .foregroundColor(.secondary)
            }
          }
        }
        .onDelete(perform: deleteBooks)
      }
      
      //  Заголовок панели навигации этого представления с локализованной строкой
      .navigationBarTitle("Bookworm")
      
      // Заголовок панели навигации с настройкой кнопки, в которой проиходит переключение логистической переменной "экрана добавления книги" и картинка с плюсиком
      .navigationBarItems(leading: EditButton(), trailing: Button(action: {
        self.showingAddScreen.toggle()
      }) {
        Image(systemName: "plus")
      })
      
      // Представляет лист, когда выполняется заданное условие
      .sheet(isPresented: $showingAddScreen) {
        AddBookView().environment(\.managedObjectContext, self.moc)
      }
    }
  }
  
  func deleteBooks(at offsets: IndexSet) {
    for offset in offsets {
      
      // Поиск книги в запросе на получение
      let book = books[offset]
      
      // Удаление книги из контектса
      moc.delete(book)
      
    }
    // Сохранение контекста
    try? moc.save()
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
