//
//  ViewController.swift
//  MyHabbits
//
//  Created by Андрей Михайлов on 23.06.2021.
//

import UIKit

class HabitsViewController: UIViewController {

    let apperance = UINavigationBarAppearance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Habits Background")
        apperance.configureWithDefaultBackground()
        apperance.backgroundColor = .white
        navigationItem.title = "Сегодня"
        navigationController?.navigationBar.prefersLargeTitles = true
        UINavigationBar.appearance().scrollEdgeAppearance = apperance
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.backBarButtonItem?.tintColor = UIColor(named: "Purple Color")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func setupUIView() {
       
    }

}

