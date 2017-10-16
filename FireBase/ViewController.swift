//
//  ViewController.swift
//  FireBase
//
//  Created by Luis José Sánchez Carrasco on 15/10/17.
//  Copyright © 2017 Luis José Sánchez Carrasco. All rights reserved.
//  en podfile

/*
 # Uncomment the next line to define a global platform for your project
 platform :ios, ’10.0’
 
 target 'FireBase' do
 # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
 use_frameworks!
 pod 'Firebase/Core'
 pod 'Firebase/Auth'
 pod 'Firebase/Database'
 pod 'Firebase/Storage'
 # Pods for FireBase
 end
 */

import UIKit
import FirebaseCore
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    var ref:DatabaseReference?
    
    var myList:[String] = []
    
    var handle:DatabaseHandle?
    
    @IBOutlet weak var texto: UITextField!
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref=Database.database().reference()
        handle = ref?.child("nombres").observe(.childAdded, with: { (DataSnapshot) in
            if let item = DataSnapshot.value as? String
            {
                self.myList.append(item)
                self.myTableView.reloadData()
            }
            
        })
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text=myList[indexPath.row]
        return cell
    }

    @IBAction func save(_ sender: Any) {
        
        if texto.text != "" {
            ref?.child("nombres").childByAutoId().setValue(texto.text)
            
        }
    }

}
