//
//  ChatViewController.swift
//  APP-FlashChat
//
//  Created by José Eduardo Rodríguez Reyes on 04/07/21.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var sendMessageText: UITextField!
    @IBOutlet weak var myTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func sendMessagePressed(_ sender: UIButton) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
