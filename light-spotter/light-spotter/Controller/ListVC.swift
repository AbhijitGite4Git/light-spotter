//
//  ListVC.swift
//  light-spotter
//
//  Created by Abhijit Gite on 29/8/20.
//  Copyright © 2020 Abhijit Gite. All rights reserved.
//

import UIKit

class ListVC: UIViewController {

    @IBOutlet weak var tblLights: UITableView!
     var viewModelLights = LightsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        //viewModelLights.vc = self
       // viewModelLights.getAllCameras()
        // Do any additional setup after loading the view.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if let destination = segue.destination as? ListDetailVC {
            let index = tblLights.indexPathForSelectedRow?.row
            if (index != nil){
                destination.camera = viewModelLights.resultCameras[index!]
                tblLights.deselectRow(at: tblLights.indexPathForSelectedRow!, animated: true)
            }
           

         }
     }

}

extension ListVC : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return viewModelLights.resultCameras.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomLight", for: indexPath) as? CustomLight
        
        //let camera = viewModelLights.resultCameras[indexPath.row]
        //cell?.lblRight.text = "\(String(describing: camera.camera_id!))"
        //cell?.lblLeft.text =  "\(String(describing: camera.timestamp!))"
       return cell!
    }
    
}

extension ListVC : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("You selected cell #\(indexPath.row)!")
            performSegue(withIdentifier: "showImage", sender: self)

    }
    
}
