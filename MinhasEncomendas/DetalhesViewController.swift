//
//  DetalhesViewController.swift
//  MinhasEncomendas
//
//  Created by Victor on 16/12/20.
//

import UIKit
import CoreData

class DetalhesViewController: UIViewController {
    var context : NSManagedObjectContext!
    var pedidoObj : NSManagedObject!

    @IBOutlet weak var pedido: UILabel!
    @IBOutlet weak var loja: UILabel!
    @IBOutlet weak var data: UILabel!
    @IBOutlet weak var previsao: UILabel!
    @IBOutlet weak var descricao: UILabel!
    @IBOutlet weak var status: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if pedidoObj != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            
            if let pedidoRec = pedidoObj.value(forKey: "pedido") {
                self.pedido.text = String(describing: pedidoRec)
            }
            if let lojaRec = pedidoObj.value(forKey: "loja") {
                self.loja.text = String(describing: lojaRec)
            }
            if let dataRec = pedidoObj.value(forKey: "data") {
                self.data.text = String(describing: dateFormatter.string(from: dataRec as! Date))
            }
            if let previsaoRec = pedidoObj.value(forKey: "previsao") {
                self.previsao.text = String(describing: dateFormatter.string(from: previsaoRec as! Date))
            }
            if let descricaoRec = pedidoObj.value(forKey: "descricao") {
                self.descricao.text = String(describing: descricaoRec)
            }
            if pedidoObj.value(forKey: "recebido") as! Bool == true {
                self.status.text = "Recebido"
            } else {
                self.status.text = "A caminho"
            }
            
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            context = appDelegate.persistentContainer.viewContext
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editPedido" {
            let viewEdit = segue.destination as! ViewController
            
            viewEdit.pedidoObj = self.pedidoObj
        }
    }

}
