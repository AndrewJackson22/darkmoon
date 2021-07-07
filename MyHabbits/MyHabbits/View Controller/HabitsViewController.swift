//
//  ViewController.swift
//  MyHabbits
//
//  Created by Андрей Михайлов on 23.06.2021.
//

import UIKit

class HabitsViewController: UIViewController {

    private let layout = UICollectionViewFlowLayout()
    private lazy var habitsCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
    let store = HabitsStore.shared
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
        tabBarController?.tabBar.tintColor = UIColor(named: "Purple Color")
        setupUIView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.prefersLargeTitles = true
        habitsCollection.reloadData()
    }

   
    func setupUIView() {
        view.addSubview(habitsCollection)
        habitsCollection.toAutoLayout()
        habitsCollection.backgroundColor = UIColor(named: "Habits Background")
        habitsCollection.dataSource = self
        habitsCollection.delegate = self
        habitsCollection.register(HabitViewCollection.self, forCellWithReuseIdentifier: String(describing: HabitViewCollection.self))
        habitsCollection.register(ProgressViewCollection.self, forCellWithReuseIdentifier: String(describing: ProgressViewCollection.self))

        let constraints = [
            habitsCollection.topAnchor.constraint(equalTo: view.topAnchor),
            habitsCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            habitsCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            habitsCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                ]

        NSLayoutConstraint.activate(constraints)
                
    }

}

extension HabitsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        default:
            return store.habits.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let progressCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProgressViewCollection.self), for: indexPath) as! ProgressViewCollection
            progressCell.updateProgress()
            return progressCell
        default:
            let habitCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HabitViewCollection.self), for: indexPath) as! HabitViewCollection
            
            habitCell.habit = store.habits[indexPath.item]
            habitCell.isCheck = { self.habitsCollection.reloadData() }
            
            return habitCell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1: let vc = HabitDetailViewController()
            vc.habit = (collectionView.cellForItem(at: indexPath) as! HabitViewCollection).habit
            navigationController?.pushViewController(vc, animated: true)
        default: break
            
        }
    }
    
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        switch indexPath.section {
        case 0:
            return CGSize(width: (habitsCollection.frame.width - 33), height: 60)
        default:
            return  CGSize(width: (habitsCollection.frame.width - 33), height: 130)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return UIEdgeInsets(top: 22, left: .zero, bottom: .zero, right:.zero)
        default:
            return UIEdgeInsets(top: 18, left: .zero, bottom: .zero, right: .zero)
        }
    }
}

