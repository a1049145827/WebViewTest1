//
//  ViewController.swift
//  WebView
//
//  Created by LiuBruce on 15/11/26.
//  Copyright © 2015年 LiuBruce. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {

    var button        = UIButton.init(type: UIButtonType.Custom)
    var backbutton    = UIButton.init(type: UIButtonType.Custom)
    var forwardbutton = UIButton.init(type: UIButtonType.Custom)
    var refresh       = UIButton.init(type: UIButtonType.Custom)
    var textField     = UITextField.init()
    var webView       = UIWebView.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        
        
        textField.frame = CGRectMake(15, 24, self.view.frame.size.width - 100, 32)
        textField.text = "http://"
        textField.borderStyle = UITextBorderStyle.RoundedRect
        self.view.addSubview(textField)
        
        
        button.frame = CGRectMake(textField.frame.origin.x + textField.frame.size.width + 10, textField.frame.origin.y, 60, 32)
        button.setTitle("打开", forState: UIControlState.Normal)
        button.backgroundColor = UIColor.redColor()
        button.addTarget(self, action: Selector("buttonClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
        
        self.webView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 100)
        webView.backgroundColor = UIColor.whiteColor()
        webView.delegate = self
        self.view.addSubview(webView)
        
        backbutton.frame = CGRectMake(15, self.view.frame.size.height - 28, 50, 24)
        backbutton.setBackgroundImage(UIImage(named: "menu_bg_64"), forState: UIControlState.Normal)
        backbutton.setTitle("后退", forState: UIControlState.Normal)
        backbutton.addTarget(self, action: Selector("goback:"), forControlEvents: UIControlEvents.TouchUpInside)
        backbutton.enabled = false
        self.view.addSubview(backbutton)
        
        forwardbutton.frame = CGRectMake(self.view.frame.size.width - 65, self.view.frame.size.height - 28, 50, 24)
        forwardbutton.setTitle("前进", forState: UIControlState.Normal)
        forwardbutton.addTarget(self, action: Selector(goforward(forwardbutton)), forControlEvents: UIControlEvents.TouchUpInside)
        forwardbutton.enabled = false
        forwardbutton.setBackgroundImage(UIImage(named: "menu_bg_64"), forState: UIControlState.Normal)
        self.view.addSubview(forwardbutton)
        
        refresh.frame = CGRectMake(self.view.frame.size.width/2.0 - 25, self.view.frame.size.height - 28, 50, 24)
        refresh.setTitle("刷新", forState: UIControlState.Normal)
        refresh.setBackgroundImage(UIImage(named: "menu_bg_64"), forState: UIControlState.Normal)
        refresh.addTarget(self, action: "webViewRefresh:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(refresh)
    }
    
    func buttonClick(sender:UIButton) {
        self.view.endEditing(true)
        
        if (textField.text?.isEmpty == false) { // textField.text(isEqual("")
            
            let url = NSURL(string :textField.text!)
            let request = NSURLRequest(URL: url!)
            self.webView.loadRequest(request)
            
        }else {
            
            let alertController = UIAlertController(title: "提醒", message: "请输入网址", preferredStyle: UIAlertControllerStyle.Alert)
            
            let cancelAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Cancel, handler: nil)
            alertController.addAction(cancelAction)
            
//            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
//            [alertController addAction:okAction];
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func webViewRefresh(sender:UIButton) {
        self.webView.reload()
    }
    
    func goback(sender:UIButton) {
        self.webView.goBack()
    }
    
    func goforward(sender:UIButton) {
        webView.goForward()
    }
    
    func buttonEnable() {
        self.backbutton.enabled = self.webView.canGoBack
        self.forwardbutton.enabled = self.webView.canGoForward
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        buttonEnable()
        print("webViewDidFinishLoad")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

