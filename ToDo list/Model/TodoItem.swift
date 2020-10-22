import Foundation

struct TodoItem {
    var name: String
    var detail: String
    var items: [TodoItem]
    
    init(name: String = "", detail: String = "") {
        self.name = name
        self.detail = detail
        self.items = []
    }
    
    // MARK: Load items from direct
    
    init(dictionary: NSDictionary) {
        self.name = dictionary.object(forKey: "name") as! String
        self.detail = dictionary.object(forKey: "detail") as! String
        self.items = dictionary.object(forKey: "items") as! [TodoItem]
    }
}
