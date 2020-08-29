import Foundation

struct TodoItem {
    var name: String
    var detail: String

    init(name: String = "", detail: String = "") {
        self.name = name
        self.detail = detail
    }
    
    // MARK: Save items in direct
    
    init(dictionary: NSDictionary) {
        self.name = dictionary.object(forKey: "name") as! String
        self.detail = dictionary.object(forKey: "detail") as! String
    }
}
