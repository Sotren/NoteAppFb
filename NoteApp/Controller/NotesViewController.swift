//
//  NotesViewController.swift
//  NoteApp
//
//  Created by Станислав Москальцов  on 02.02.2022.
//

import UIKit
import Firebase

class NotesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadMessages()
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    public var notes: [Note] = []
    public let db = Firestore.firestore()
    
   
    //MARK: - FairBaseLogic
    func loadMessages() {
        
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in
            
            self.notes = []
            
            if let e = error {
                print("There was an issue retrieving data from Firestore. \(e)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let noteTitle = data[K.FStore.titleField] as? String, let noteBody = data[K.FStore.bodyField] as? String {
                            let newNote = Note(title: noteTitle, body: noteBody)
                            self.notes.append(newNote)
                            
                            DispatchQueue.main.async {
                                   self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.notes.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    }



//MARK: - UITableViewDataSource
extension NotesViewController: UITableViewDataSource{
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].title
        cell.detailTextLabel?.text = notes[indexPath.row].body
        return cell
    }
    

}

    //MARK: - UITableViewDelegate
extension NotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.editNoteSegue, sender: nil)
    }
    
    
}
    
    
    
    
 
