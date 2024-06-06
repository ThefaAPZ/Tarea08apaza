//
//  ViewControllerCrearCurso.swift
//  apazaTarea08
//
//  Created by Mireya Esthefany Apaza Cuicapuza  on 6/06/24.
//

import UIKit

class ViewControllerCrearCurso: UIViewController {
    
    var anteriorVC = ViewController()
    
    @IBOutlet weak var txtNombreCurso: UITextField!
    @IBOutlet weak var txtPromPracticas: UITextField!
    @IBOutlet weak var txtPromLaboratorios: UITextField!
    @IBOutlet weak var txtExamFinal: UITextField!
    
    @IBAction func agregar(_ sender: Any) {
        //let curso = Curso()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let curso = Curso(context: context)
        curso.nombre = txtNombreCurso.text!
        curso.promPracticas = txtPromPracticas.text!
        curso.promLaboratorios = txtPromLaboratorios.text!
        curso.examFinal = txtExamFinal.text!
        
        // Calcular el promedio final
        guard let practicas = Double(txtPromPracticas.text ?? "0"),
              let laboratorios = Double(txtPromLaboratorios.text ?? "0"),
              let examFinal = Double(txtExamFinal.text ?? "0") else {
            return
        }
        let promFinal = (practicas + laboratorios + examFinal) / 3.0
        curso.promFinal = promFinal
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        //anteriorVC.cursos.append(curso)
        //anteriorVC.tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
