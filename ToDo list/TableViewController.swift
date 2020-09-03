import UIKit

class TableViewController: UITableViewController {
    
    var direct = Direct()
    var todoItem = TodoItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Load view")
        navigationItem.title = "ToDo-list"
    }
    
    @IBAction func pushAddAction(_ sender: Any) {
        
        let alert = UIAlertController(title: "Create new item", message: "", preferredStyle: .alert)
        alert.addTextField { (textName) in
            textName.placeholder = "Title 1/250"
        }
        alert.addTextField { (textDetail) in
            textDetail.placeholder = "Message 1/1000"
        }
        
        let alertActionCrate = UIAlertAction(title: "Create", style: .default) { (_) in
            if alert.textFields![0].text != ""{
                
                let newItem = TodoItem(name: alert.textFields![0].text!, detail: alert.textFields![1].text!)
                self.todoItem.items.append(newItem)
                
                self.direct.saveData()
                self.tableView.reloadData()
                
                print("Save create")
            }
        }
        let alertActionCancel = UIAlertAction(title: "Cancel", style: .default) { (_) in}
        alert.addAction(alertActionCrate)
        alert.addAction(alertActionCancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func longPressEditAction(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let pointPress = sender.location(in: tableView)
            print(pointPress)
            if let indexPath = tableView.indexPathForRow(at: pointPress){
                print(indexPath)
            let cell = tableView.cellForRow(at: indexPath)
                
                let alert = UIAlertController(title: "Edit post", message: "", preferredStyle: .alert)
                alert.addTextField { (textName) in
                    if let name = cell?.textLabel?.text {
                        textName.text = name
                    }
                }
                alert.addTextField { (textDetail) in
                    if let detail = cell?.detailTextLabel?.text {
                        textDetail.text = detail
                    }
                }
        
                let alertActionEdit = UIAlertAction(title: "Edit", style: .default) { (_) in
                    if alert.textFields![0].text != ""{
                        let newItem = TodoItem(name: alert.textFields![0].text!, detail: alert.textFields![1].text!)
                        self.todoItem.items[indexPath.row] = newItem
                        
                        self.direct.saveData()
                        self.tableView.reloadData()
                        
                        print("Save edit")
                    }
                }
                let alertActionCancel = UIAlertAction(title: "Cancel", style: .default) { (_) in}
                alert.addAction(alertActionEdit)
                alert.addAction(alertActionCancel)
                
                present(alert, animated: true, completion: nil)
            }
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(todoItem)
        return todoItem.items.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let itemForCell = todoItem.items[indexPath.row]
        cell.textLabel?.text = itemForCell.name
        cell.detailTextLabel?.text = itemForCell.detail
        return cell
    }
    
    // MARK: - Delete cell
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todoItem.items.remove(at: indexPath.row)
                direct.saveData()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
