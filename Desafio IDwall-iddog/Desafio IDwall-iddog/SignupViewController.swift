//
//  SignupViewController.swift
//  Desafio IDwall-iddog
//
//  Created by Davison Dantas on 30/09/2018.
//  Copyright © 2018 Davison. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var passwordConfirmedText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createAccount(_ sender: Any) {
        //Recovered data
        if let emailR = self.emailText.text{
            if let passwordR = self.passwordText.text{
                if let passwordConfirmedR = self.passwordConfirmedText.text{
                    
                    let payload = ["email": emailR] as [String: Any]
                    if let jsonData = try? JSONSerialization.data(withJSONObject: payload, options: .prettyPrinted){
                        let url = URL(string: "https://api-iddog.idwall.co/signup")
                        var request = URLRequest(url: url!)
                        request.httpMethod = "POST"
                        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                        request.httpBody = jsonData
                        
                        URLSession.shared.dataTask(with: request) { (data, response, error) in
                            if error == nil{
                                if let dataReturned = data{
                                    do{
                                        if let objectJson = try JSONSerialization.jsonObject(with: dataReturned, options: []) as? [String: AnyObject]{
                                            print(objectJson)
                                            if let user = objectJson["user"]{
                                                if let token = user["token"]{
                                                    
                                                    print("Usuário criado com sucesso")
                                                    let destVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                                                    destVC.passToken = token as! String
                                                    DispatchQueue.main.async {
                                                        self.navigationController?.pushViewController(destVC, animated: true)
                                                    }
                                                }
                                            }
                                        }
                                    }catch{
                                        print("Erro ao formatar o retorno")
                                    }
                                }
                            } else{
                                print(error!.localizedDescription)
                                return
                            }
                        }.resume()
                    }
                }
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
