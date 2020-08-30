//
//  ListDetailVC.swift
//  light-spotter
//
//  Created by Abhijit Gite on 29/8/20.
//  Copyright © 2020 Abhijit Gite. All rights reserved.
//

import UIKit

class ListDetailVC: UIViewController {

    @IBOutlet weak var lblCameraid: UILabel!
    @IBOutlet weak var lblTimestamp: UILabel!
    @IBOutlet weak var imgViewLight: UIImageView!
    var camera: Cameras?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if self.camera != nil  {
            imgViewLight.load(url: URL(string: (camera?.image)!)!)
            lblCameraid.text = camera?.camera_id
            lblTimestamp.text = camera?.timestamp
        }
        
        
    }

    func setDefault(){
        lblCameraid.text = "-"
        lblTimestamp.text = "-"
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

//Extention to accept URL as input to image view
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url ) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
