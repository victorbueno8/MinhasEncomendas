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

    @IBOutlet weak var pedido: UITextField!
    @IBOutlet weak var loja: UITextField!
    @IBOutlet weak var previsao: UIDatePicker!
    @IBOutlet weak var descricao: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if pedidoObj != nil {
            if let pedidoRec = pedidoObj.value(forKey: "pedido") {
                self.pedido.text = String(describing: pedidoRec)
            }
            if let lojaRec = pedidoObj.value(forKey: "loja") {
                self.loja.text = String(describing: lojaRec)
            }
            if let previsaoRec = pedidoObj.value(forKey: "previsao") {
                self.previsao.date = previsaoRec as! Date
            }
            if let descricaoRec = pedidoObj.value(forKey: "descricao") {
                self.descricao.text = String(describing: descricaoRec)
            }
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    
    @IBAction func salvar(_ sender: Any) {
        if pedidoObj == nil {
            self.salvarPedido()
        } else {
            self.atualizarPedido()
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func salvarPedido() {
        let novoPedido = NSEntityDescription.insertNewObject(forEntityName: "Pedidos", into: context)
        
        novoPedido.setValue(self.pedido.text, forKey: "pedido")
        novoPedido.setValue(self.loja.text, forKey: "loja")
        novoPedido.setValue(self.previsao.date, forKey: "previsao")
        novoPedido.setValue(self.descricao.text, forKey: "descricao")
        novoPedido.setValue(Date(), forKey: "data")
        novoPedido.setValue(false, forKey: "recebido")
        
        do {
            try context.save()
            print("Pedido salvo com sucesso!")
        } catch let erro {
            print("Erro ao salvar pedido: \(erro.localizedDescription)")
        }
    }
    
    func atualizarPedido(){
        pedidoObj.setValue(self.pedido.text, forKey: "pedido")
        pedidoObj.setValue(self.loja.text, forKey: "loja")
        pedidoObj.setValue(self.previsao.date, forKey: "previsao")
        pedidoObj.setValue(self.descricao.text, forKey: "descricao")
        pedidoObj.setValue(Date(), forKey: "data")
        
        do {
            try context.save()
            print("Sucesso ao atualizar pedido")
        } catch let erro {
            print("Erro ao atualizar pedido: \(erro.localizedDescription)")
        }
    }
    

}

