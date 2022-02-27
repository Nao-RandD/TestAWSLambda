//
//  ViewController.swift
//  TestAWSLambda
//
//  Created by Naoyuki Kan on 2022/02/12.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var outputTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func tappedGetButton(_ sender: Any) {
        // HTTP通信でAWSからデータを取得する
        getAccount()
    }
}

extension ViewController {
    private func getAccount() {
        let url = URL(string: "https://p7zi9li1wg.execute-api.ap-northeast-1.amazonaws.com/demo")!  //URLを生成
        let request = URLRequest(url: url)               //Requestを生成
        let session = URLSession.shared.dataTask(with: request) { (data, response, error) in  //非同期で通信を行う
            guard let data = data else {
                print("取得したデータは空でした")
                return }
            do {
                let object = try JSONSerialization.jsonObject(with: data)  // DataをJsonに変換
                print(object)

//                self.outputTextView.text = String(dump(object))
                // HTTPヘッダの取得
                print("Content-Type: \(response?.mimeType ?? "")")
                // HTTPステータスコード
                print("statusCode: \(String(describing: response))")

                DispatchQueue.main.async {
                    // メインスレッドで実行 UIの処理など
                    self.outputTextView.text = String(data: data, encoding: String.Encoding.utf8) ?? ""
                }
            } catch let error {
                print(error)
            }
        }
        session.resume()
    }
}
