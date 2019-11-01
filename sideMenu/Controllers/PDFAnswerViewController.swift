//
//  PDFAnswerViewController.swift
//  sideMenu
//
//  Created by Thidar Phyo on 11/1/19.
//  Copyright © 2019 Thidar Phyo. All rights reserved.
//

import UIKit

class PDFAnswerViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var pdfView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        pdfView.delegate = self
        spinner.hidesWhenStopped = true
        
        let path = URL(fileURLWithPath: Bundle.main.path(forResource: "JLPT-N3-Practice-Test-grammar-section", ofType: "pdf")!)
        let request = URLRequest(url: path)
        pdfView.loadRequest(request)
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
