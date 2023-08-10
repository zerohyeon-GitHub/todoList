//
//  ListTableViewCell.swift
//  Todo_myDreams
//
//  Created by t2023-m0059 on 2023/08/07.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    let storyboardID = "listCell"
    
    var cellIndex: Int = 0
    
    @IBOutlet weak var cellStackView: UIStackView!
    
    @IBOutlet weak var todoName: UILabel!
    @IBOutlet weak var completedSwitch: UISwitch!
    
    override func awakeFromNib() { // 호출하는 타이밍
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLabel() {
        todoName.backgroundColor = .blue
    }
    
    func setSwich(){
        completedSwitch.isOn = false
        completedSwitch.backgroundColor = .yellow
        
        completedSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
    }
    
    func setStackView(){
        cellStackView.alignment = .fill
        cellStackView.distribution = .fill
        
        cellStackView.spacing = 30
        cellStackView.backgroundColor = .green
    }
    
    @IBAction func switchChange(_ sender: Any) {
        if completedSwitch.isOn {
            todoName.attributedText = todoName.text?.strikeThrough()
            
            User.userTodo[cellIndex].complete = true
        } else {
            todoName.attributedText = todoName.text?.clear()
            
            User.userTodo[cellIndex].complete = false
        }
    }
}

extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
    func clear() -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, 0))
        return attributeString
    }
}
