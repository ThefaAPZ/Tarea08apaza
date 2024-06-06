//
//  ViewController.swift
//  apazaTarea08
//
//  Created by Mireya Esthefany Apaza Cuicapuza  on 6/06/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBAction func agregarCurso(_ sender: Any) {
        performSegue(withIdentifier: "agregarSegue", sender: nil)
    }
    
    var cursos:[Curso] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        //cursos = crearCursos()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cursos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let curso = cursos[indexPath.row]
        cell.textLabel?.text = curso.nombre
        cell.detailTextLabel?.text = String(format: "%.2f", curso.promFinal)

        // Cambiar el color de la celda según si el curso está aprobado o reprobado
        if curso.promFinal >= 14.0 {
            cell.backgroundColor = .green
            cell.detailTextLabel?.textColor = .white
        } else {
            cell.backgroundColor = .red
            cell.detailTextLabel?.textColor = .white
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let cursoAEliminar = cursos[indexPath.row]
            context.delete(cursoAEliminar)
            do {
                try context.save()
            } catch {
                print("Error al eliminar curso de Core Data: \(error.localizedDescription)")
            }
            cursos.remove(at: indexPath.row)
            tableView.reloadData()
        } else if editingStyle == .insert {
            // create
        }
    }
    
    /*
    func crearCursos() -> [Curso] {
        let curso1 = Curso()
        curso1.nombre = "Matemáticas"
        
        let curso2 = Curso()
        curso2.nombre = "Comunicación"
        
        let curso3 = Curso()
        curso3.nombre = "Arte"
        
        return [curso1,curso2,curso3]
    }
     */
    
    func obtenerCursos() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        cursos.removeAll()
        do {
            cursos = try context.fetch(Curso.fetchRequest()) as! [Curso]
        } catch {
            print("Error al leer entidad de CoreData")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let siguienteVC = segue.destination as! ViewControllerCrearCurso
        siguienteVC.anteriorVC = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        obtenerCursos()
        tableView.reloadData()
    }

}

