//
//  PopupViewController.swift
//  Instagram
//
//  Created by Yusuke Shiina on 2020/05/19.
//  Copyright © 2020 Yusuke Shiina. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SVProgressHUD

class PopupViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var commentField: UITextField!
    var name: String!
    //var comments: String!
    var uid: String?
    var postdata: PostData!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
    }
    
    @IBAction func goButton(_ sender: Any) {
        let _ = Date.timeIntervalSinceReferenceDate
        let name = Auth.auth().currentUser?.displayName
        
        var postRef = Database.database().reference().child(Const.PostPath)
        if((commentField.text?.count)! < 1) {
            return
        }
        
        //let postDic = ["comment": commentField.text!, "time": String(time), "name": name!,"post_id": post_id]
        //postRef.childByAutoId().setValue(postDic)
        //ここはappendで追加したい
        //data = [name!,commentField.text!]
        postdata.comments.append(["name":name!,"comment":commentField.text!])
        //postdata.comments.append([commentField.text!])
        postRef = Database.database().reference().child(Const.PostPath).child(postdata.id!)
        let comments = ["comments": postdata.comments]
        postRef.updateChildValues(comments)

        SVProgressHUD.showSuccess(withStatus: "コメント投稿しました")
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
