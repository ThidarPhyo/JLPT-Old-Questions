
//
//  PDFVocabularyViewController.swift
//  sideMenu
//
//  Created by Thidar Phyo on 11/1/19.
//  Copyright © 2019 Thidar Phyo. All rights reserved.
//

import UIKit

class PDFVocabularyViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var pdfViewVoca: UIWebView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pdfViewVoca.delegate = self
        spinner.hidesWhenStopped = true
        
        let path = URL(fileURLWithPath: Bundle.main.path(forResource: "JLPT-N3-Practice-Test-vocabulary-section", ofType: "pdf")!)
        let request = URLRequest(url: path)
        pdfViewVoca.loadRequest(request)
    }
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        spinner.startAnimating()
        return true
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        spinner.stopAnimating()
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        spinner.stopAnimating()
        print("Something went wrong")
    }

}
