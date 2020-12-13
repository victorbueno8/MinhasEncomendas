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
        // todo: ordenar por recebido ou nao tambem
        let order = NSSortDescriptor(key: "previsao", ascending: true)
        
        requisicao.sortDescriptors = [order]
        
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
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let novaPrevisao = dateFormatter.string(from: previsaoListada as! Date)
        
        cell.textLabel?.text = String(describing: tituloPedidoListado)
        cell.detailTextLabel?.text = String(describing: novaPrevisao)

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
