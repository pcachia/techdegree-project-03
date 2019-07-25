//
//  BrowserFunctions.swift
//  BoutTime
//
//  Created by Phil Cachia on 7/25/19.
//  Copyright © 2019 Phil Cachia. All rights reserved.
//

import SafariServices

let urlString = "https://www.hackingwithswift.com"

if let url = URL(string: urlString) {
    let vc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
    vc.delegate = self
    
    present(vc, animated: true)
}


