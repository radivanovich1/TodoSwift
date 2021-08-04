//
//  NoteViewController.swift
//  ToDo
//
//  Created by Дмитрий Радиванович on 4.08.21.
//

import UIKit

class NoteViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var bodyTextView: UITextView!
    var note: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextView.text = note?.title
        bodyTextView.text = note?.body
        self.titleTextView.delegate = self
        self.bodyTextView.delegate = self
        saveButton.isEnabled = false
        if note == nil {
            titleTextView.text = "Title"
            bodyTextView.text = "Note"
            titleTextView.textColor = UIColor.lightGray
            bodyTextView.textColor = UIColor.lightGray
            deleteButton.isEnabled = false
        }
        else {
            deleteButton.isEnabled = true
        }
        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if titleTextView.textColor == UIColor.lightGray {
            titleTextView.text = nil
            bodyTextView.text = nil
            if #available(iOS 13.0, *) {
                titleTextView.textColor = UIColor.label
            } else {
                // Fallback on earlier versions
            }
            if #available(iOS 13.0, *) {
                bodyTextView.textColor = UIColor.label
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
      @IBAction func save(_ sender: Any) {
        if !Todo.shared.overflowMemory(){
        if note == nil{
            Todo.shared.write(title: titleTextView.text, body: bodyTextView.text)
            _ = navigationController?.popViewController(animated: true)
        }
        else{
        Todo.shared.update(note: note!, title: titleTextView.text, body: bodyTextView.text)
            _ = navigationController?.popViewController(animated: true)
        }
        }
        else {
            let message = "Memory overflow"
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            self.present(alert, animated: true)
            let duration: Double = 5
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
                alert.dismiss(animated: true)
            }
        }
    }
    @IBAction func del(_ sender: Any) {
        if let n = note{
        Todo.shared.remove(note: n)
        _ = navigationController?.popViewController(animated: true)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        if textView == titleTextView{
            if numberOfChars == 0 {
                saveButton.isEnabled = false
            }
            else {
                saveButton.isEnabled = true
            }
            return numberOfChars < 250
        }
        else {
            if titleTextView.text.count > 0{
                saveButton.isEnabled = true
            }
            return numberOfChars < 1000
        }
    }
    
}
