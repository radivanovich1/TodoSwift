//
//  ViewController.swift
//  ToDo
//
//  Created by Дмитрий Радиванович on 3.08.21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var notes: [Note] = []
    var selectedNote: Note?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool){
        notes = Todo.shared.read()
        tableView.reloadData()
    }
       
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? NoteViewController, segue.identifier == "ShowNote"{
            vc.note = selectedNote
        }
    }
    
}
extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell") as! NoteTableViewCell
        cell.titleLabel.text = notes[indexPath.row].title
        cell.bodyLabel.text = notes[indexPath.row].body
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedNote = notes[indexPath.row]
        print(indexPath.row)
        performSegue(withIdentifier: "ShowNote", sender: self)
                
    }
}

