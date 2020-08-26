import Foundation

struct TodoItem {
    var name: String
    var detail: String
    
    var subItems = [TodoItem]()

    init(name: String, detail: String = "") {
        self.name = name
        self.detail = detail
    }
//    init(name: String) {
//        self.name = name
//        self.detail = ""
//    }
    
    // MARK: Save items in direct
    init(dictionary: NSDictionary) {
        self.name = dictionary.object(forKey: "name") as! String
        self.detail = dictionary.object(forKey: "detail") as! String
        //self.isComplete = ((dictionary.object(forKey: "isComplete") ) != nil)
        
        self.subItems = []
        
        let arraySubToDos = dictionary.object(forKey: "subToDos") as! NSArray
        for subToDoDic in arraySubToDos {
            
            self.subItems.append(TodoItem(dictionary: subToDoDic as! NSDictionary))
        }
    }
    
    mutating func addSubItem(subItem: TodoItem){
        subItems.append(subItem)
    }
    
    mutating func removeSubItem(index: Int){
        subItems.remove(at: index)
    }
    
    mutating func renameSubItem(subItem: TodoItem, index: Int){
        subItems[index] = subItem
    }
    

}
