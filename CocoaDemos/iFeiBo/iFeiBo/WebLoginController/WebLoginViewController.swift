//
//  WebLoginViewController.swift
//  iFeiBo
//
//  Created by Alexcai on 2017/9/17.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

import Cocoa
import WebKit

class WebLoginViewController: NSViewController {

    @IBOutlet weak var webView: WebView!
    
    lazy var session = URLSession.shared
    var dataTask : URLSessionDataTask!
    
    var codeForToken = "" {
        didSet{
            if codeForToken == oldValue {return}
            
            let url = URL(string: WBTokenURL + codeForToken)!
            dataTask = session.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return  }
                
                print("data = \(String(describing:  String(data: data, encoding: .utf8))); error = \(String(describing: error?.localizedDescription))")
            }
            dataTask.resume()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        let requestURL = URL(string:WBOAuth2URL)
        let request = URLRequest(url: requestURL!)

        webView.mainFrame.load(request)
    }
    
}


extension WebLoginViewController : WebPolicyDelegate{
    func webView(_ webView: WebView!, decidePolicyForNavigationAction actionInformation: [AnyHashable : Any]!, request: URLRequest!, frame: WebFrame!, decisionListener listener: WebPolicyDecisionListener!) {
        
        print(request.url?.host ?? "")
        if request.url?.host == "alexiuce.github.io" {
            guard let host = request.url?.absoluteString else { return }
            let hostString = host as NSString
            let range = hostString.range(of: "code=")
            codeForToken = hostString.substring(from: range.location + range.length)
            listener.ignore()
        }
        listener.use()
    }
}
