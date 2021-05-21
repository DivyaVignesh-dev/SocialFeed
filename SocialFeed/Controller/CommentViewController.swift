//
//  CommentViewController.swift
//  SocialFeed
//
//  Created by Divya on 21/05/21.
//  Copyright © 2021 Divya. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class CommentViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var commentTF: UITextField!
    let modelcomment = CommentModelDataModel.sharedInstance
    var modelsocialFeed = SocialFeed()
    var arrComments = [CommentModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        commentTF.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        arrComments = modelcomment.arrCommentFeed.filter {$0.socialFeedID == modelsocialFeed.id}
    }
    
    
    @IBAction func BtnAction(_ sender: UIButton) {
        let modelData = CommentModel(socialFeedID: modelsocialFeed.id, commentID: "\(modelcomment.arrCommentFeed.count + 1)", title: commentTF.text!)
        print(modelData)
        modelcomment.arrCommentFeed.append(modelData)
        arrComments.append(modelData)
        tableView.reloadData()
        
        commentTF.resignFirstResponder()
    }
    
    
}
extension CommentViewController
{
    static func sharedInstance() -> CommentViewController
    {
        CommentViewController.instantiateFromStoryBoard()
    }
}
extension CommentViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       arrComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = arrComments[indexPath.row].title
        return cell
    }
    
    
}
