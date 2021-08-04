//
//  Note.swift
//  ToDo
//
//  Created by Дмитрий Радиванович on 3.08.21.
//

import Foundation
import RealmSwift


class Note: Object{
    @objc dynamic var body = ""
    @objc dynamic var title = ""
}

class Todo{
    
    static var shared = Todo()
    private let realm = try! Realm()
    
    func write(title: String, body: String)  {
        let note = Note()
        note.body = body
        note.title = title
        try! realm.write{
            realm.add(note)
        }
    }
    func update(note: Note, title: String, body: String)  {
        try! realm.write{
            note.body = body
            note.title = title
            realm.add(note)
        }
    }
    
    func read() -> [Note] {
        var noteArr: [Note] = []
        let allNotes = realm.objects(Note.self)
        for data in allNotes{
            noteArr.append(data)
        }
        return noteArr
    }
    
    func remove(note: Note){
        try! realm.write{
        realm.delete(note)
        }
    }
    func overflowMemory() -> Bool {
        let path = realm.configuration.fileURL!.path
        let attributes = try! FileManager.default.attributesOfItem(atPath: path)
        let fileSize = attributes[FileAttributeKey.size] as! NSNumber
        print(fileSize)
        if fileSize.intValue >= 1572864 {
            return true
        }
        else{
            return false
        }
    }
}
    
    
