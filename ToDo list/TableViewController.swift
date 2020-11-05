import UIKit
import CoreData
class TableViewController: UITableViewController {
    
    var todoItem = [Tasks]()
    
    var context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        return context
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let fetchRequest: NSFetchRequest<Tasks> = Tasks.fetchRequest()
        do {
            todoItem = try context.fetch(fetchRequest)
        } catch let err as NSError {
            print(err.localizedDescription)
        }
    }
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
                
                self.saveTasks(name: alert.textFields![0].text!, detail: alert.textFields![1].text!)
                self.tableView.reloadData()
                
                print("TableView did save and reload Data")
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
//                        let newItem = Tasks()
//                        newItem.name = alert.textFields![0].text!
//                        newItem.detail = alert.textFields![1].text!
//                        self.todoItem[indexPath.row] = newItem
                        
//                        self.direct.saveData()
//                        self.tableView.reloadData()
                        
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
    // MARK: - Save in Core Data
    func saveTasks(name: String, detail: String){
        guard let entity = NSEntityDescription.entity(forEntityName: "Tasks", in: context) else {return}
        let taskObject = Tasks(entity: entity, insertInto: context)
        taskObject.name = name
        taskObject.detail = detail
        do {
            try context.save()
            todoItem.append(taskObject)
        } catch let err as NSError {
            print(err.localizedDescription)
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(todoItem)
        return todoItem.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let itemForCell = todoItem[indexPath.row]
        cell.textLabel?.text = itemForCell.name
        cell.detailTextLabel?.text = itemForCell.detail
        return cell
    }
    
    // MARK: - Delete cell
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todoItem.remove(at: indexPath.row)
            //save
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
