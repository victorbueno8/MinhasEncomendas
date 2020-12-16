//
//  ViewController.swift
//  MinhasEncomendas
//
//  Created by Victor on 13/12/20.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var context : NSManagedObjectContext!
    var pedidoObj : NSManagedObject!

    @IBOutlet weak var pedido: UILabel!
    @IBOutlet weak var loja: UILabel!
    @IBOutlet weak var data: UILabel!
    @IBOutlet weak var previsao: UILabel!
    @IBOutlet weak var descricao: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if pedidoObj != nil {
            if let pedidoRec = pedidoObj.value(forKey: "pedido") {
                self.pedido.text = String(describing: pedidoRec)
            }
            if let lojaRec = pedidoObj.value(forKey: "loja") {
                self.loja.text = String(describing: lojaRec)
            }
            if let dataRec = pedidoObj.value(forKey: "data") {
                self.data.text = String(describing: dataRec)
            }
            if let previsaoRec = pedidoObj.value(forKey: "previsao") {
                self.previsao.text = String(describing: previsaoRec)
            }
            if let descricaoRec = pedidoObj.value(forKey: "descricao") {
                self.descricao.text = String(describing: descricaoRec)
            }
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }


}

