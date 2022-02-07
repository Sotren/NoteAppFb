//
//  Constants.swift
//  NoteApp
//
//  Created by Станислав Москальцов  on 02.02.2022.
//

import Foundation

struct K {
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "NoteCell"
    static let editNoteSegue = "editNoteSegue"
  

 
    struct FStore {
        static let collectionName = "notes"
        static let titleField = "title"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
