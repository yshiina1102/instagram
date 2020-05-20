//
//  PostViewController.swift
//  Instagram
//
//  Created by Yusuke Shiina on 2020/05/06.
//  Copyright © 2020 Yusuke Shiina. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SVProgressHUD

class PostViewController: UIViewController {
    var image: UIImage!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 受け取った画像をImageViewに設定する
        imageView.image = image

        // Do any additional setup after loading the view.
    }
    
    @IBAction func handlePostButton(_ sender: Any) {
        // ImageViewから画像を取得する
        let imageData = imageView.image!.jpegData(compressionQuality: 0.5)
        let imageString = imageData!.base64EncodedString(options: .lineLength64Characters)
        
        // postDataに必要な情報を取得しておく
        let time = Date.timeIntervalSinceReferenceDate
        let name = Auth.auth().currentUser?.displayName
        let userID = Auth.auth().currentUser?.uid
        // 辞書を作成してFirebaseに保存する
        let postRef = Database.database().reference().child(Const.PostPath)
        let postDic = ["caption": textField.text!, "image": imageString, "time": String(time), "name": name!, "uid":userID!] as [String:Any]
        postRef.childByAutoId().setValue(postDic)
        
        // HUDで投稿完了を表示する
        SVProgressHUD.showSuccess(withStatus: "投稿しました")
        
             // 投稿処理が完了したので先頭画面に戻る
             UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func handleCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
