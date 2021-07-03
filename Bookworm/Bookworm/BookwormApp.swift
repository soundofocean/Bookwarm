import CoreData
import SwiftUI

@main
struct BookwormApp: App {
  
  /// Создание объекта, в котором хранится контейнер с именем Data Model
  let container = NSPersistentContainer(name: "Bookworm")
  var body: some Scene {
    
    WindowGroup {
      ContentView()
        
        // Добавление ключа managedObjectContext в environment со значением container view context
        .environment(\.managedObjectContext, container.viewContext)
      
    }
  }
  
  init() {
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
  }
}
