import SwiftUI


/// Экран с эмодзи
struct EmojiRatingView: View {
  
  /// Рейтинг
  let rating: Int16
  
  var body: some View {
    
    //      Описание различных рейтингов и их вывод на экран
    switch rating {
    case 1:
      return Text("1")
    case 2:
      return Text("2")
    case 3:
      return Text("3")
    case 4:
      return Text("4")
    default:
      return Text("5")
    }
  }
}

struct EmojiRatingView_Previews: PreviewProvider {
  static var previews: some View {
    EmojiRatingView(rating: 3)
  }
}
