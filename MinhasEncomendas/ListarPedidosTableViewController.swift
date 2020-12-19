//
//  ListarPedidosTableViewController.swift
//  MinhasEncomendas
//
//  Created by Victor on 13/12/20.
//

import UIKit
import CoreData

class ListarPedidosTableViewController: UITableViewController {
    var context : NSManagedObjectContext!
    var pedidos : [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        pegarPedidos()
    }
    
    func pegarPedidos() {
        let requisicao = NSFetchRequest<NSFetchRequestResult>(entityName: "Pedidos")
        let orderStatus = NSSortDescriptor(key: "recebido", ascending: true)
        let orderDate = NSSortDescriptor(key: "previsao", ascending: true)
        
        requisicao.sortDescriptors = [orderStatus,orderDate]
        
        do {
            let pedidosLista = try context.fetch(requisicao)
            self.pedidos = pedidosLista as! [NSManagedObject]
            
            self.tableView.reloadData()
        } catch let erro {
            print("Erro ao pegar dados: \(erro.localizedDescription)")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pedidos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath)

        let pedido = self.pedidos[indexPath.row]
        let tituloPedidoListado = pedido.value(forKey: "pedido")
        let previsaoListada = pedido.value(forKey: "previsao")
        let recebidoListado = pedido.value(forKey: "recebido")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let novaPrevisao = dateFormatter.string(from: previsaoListada as! Date)
        
        cell.textLabel?.text = tituloPedidoListado as? String
        cell.detailTextLabel?.text = String(describing: "Previsto para " + novaPrevisao)
        
        if recebidoListado as! Bool == true {
            cell.contentView.backgroundColor = UIColor.systemGreen
            cell.textLabel?.textColor = UIColor.white
            cell.detailTextLabel?.textColor = UIColor.white
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        let pedido = self.pedidos[indexPath.row]
        
        self.performSegue(withIdentifier: "verPedido", sender: pedido)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let pedido = self.pedidos[indexPath.row]
            self.context.delete(pedido)
            
            self.pedidos.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            do {
                try self.context.save()
            } catch let erro {
                print("Erro ao remover item: \(erro.localizedDescription)")
            }
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "verPedido" {
            let viewDetail = segue.destination as! DetalhesViewController
            
            viewDetail.pedidoObj = sender as? NSManagedObject
        }
    }

}
