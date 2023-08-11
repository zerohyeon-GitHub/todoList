//
//  CompleteTableViewCell.swift
//  Todo_myDreams
//
//  Created by t2023-m0059 on 2023/08/03.
//

import UIKit

class CompleteTableViewCell: UITableViewCell {

    let storyboardID = "completeCell"
    
    @IBOutlet weak var completedStackView: UIStackView!
    @IBOutlet weak var todoName: UILabel!
    @IBOutlet weak var todoDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setLabel() {
//        todoName.backgroundColor = .blue

//        todoDate.backgroundColor = .yellow
    }
    
    func setStackView(){
        completedStackView.alignment = .fill
        completedStackView.distribution = .fillEqually
        
        completedStackView.spacing = 30
//        completedStackView.backgroundColor = .green
    }
}
