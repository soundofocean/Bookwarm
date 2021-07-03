import SwiftUI

/// Экран с рейтингом
struct RatingView: View {
  
  //  binding для того, чтобы мы могли сообщать о выборе пользователя
  @Binding var rating: Int
  
  /// Заголовк
  var label = ""
  
  /// Максимальный рейтинг
  var maximumRating = 5
  
  /// Выключеное изображение
  var offImage: Image?
  
  /// Включенное изображение в виде звездочи
  var onImage = Image(systemName: "star.fill")
  
  /// Цвет выключения
  var offColor = Color.gray
  
  /// Цвет включения
  var onColor = Color.yellow
  
  var body: some View {
    HStack {
      
      //      Если заголовк не пустой, используем его
      if label.isEmpty == false {
        Text(label)
      }
      
      //       Цикл от 1 до максимального рейтинга
      ForEach(1..<maximumRating + 1) { number in
        
        //        Вызываем изображение
        self.image(for: number)
          
          //          Цвет переднего плана в зависимости от рейтинга
          .foregroundColor(number > self.rating ? self.offColor : self.onColor)
          .
          //          Жест касания, который рейтинг изменяет
          onTapGesture {
            self.rating = number
          }
      }
    }
  }
  
  
  /// Метод выбора изображения для показа -
  /// - Parameter number: переданное число
  /// - Returns: изображения
  func image(for number: Int) -> Image {
    
    //    Если переданное число больше текущего рейтинга, верните выключенное изображение, если оно было установлено, в противном случае верните включенное изображение.
    if number > rating {
      return offImage ?? onImage
    } else {
      
      //      Если переданное число равно или меньше текущего рейтинга, верните включенное изображение.
      return onImage
    }
  }
}

struct RatingView_Previews: PreviewProvider {
  static var previews: some View {
    RatingView(rating: .constant(4))
  }
}

