//
class EditNoteViewController: UIViewController {
    
    @IBOutlet var textBody: UITextView!
    
    private let db = Firestore.firestore()
   public var textView: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textBody.text = textView
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    @IBAction func text(_ sender: UIBarButtonItem) {
        sendData(getNotesTitile())
    }
    
    
    func sendData (_:String) {
        if let noteBody = textBody.text {
            db.collection(K.FStore.collectionName).addDocument(data: [
              K.FStore.bodyField: noteBody,
                K.FStore.titleField: title ?? "note",
            K.FStore.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error {
                    print("There was an issue saving data to firestore, \(e)")
                } else {
                    print("Successfully saved data.")
    }
}
}
    }
    
    private  func getNotesTitile() -> String{
          let components = textBody.text.components(separatedBy: "\n")
          for components in components{
              if components.trimmingCharacters(in: CharacterSet.whitespaces).count > 0{
                  return components
              }
          }
          return navigationItem.title ?? "note"
      }
      
    
}
//  EditNoteViewController.swift
//  NoteApp
//
//  Created by Станислав Москальцов  on 02.02.2022.
//

import UIKit
import Firebase
