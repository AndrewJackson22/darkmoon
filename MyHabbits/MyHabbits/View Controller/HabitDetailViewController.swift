//
//  HabitDetailViewController.swift
//  MyHabbits
//
//  Created by Андрей Михайлов on 04.07.2021.
//

import UIKit

class HabitDetailViewController: UIViewController {
    
    var habit: Habit
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    let cellID = "cellID"
    
    init(habit: Habit){
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupViews()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        NotificationCenter.default.addObserver(self, selector: #selector(habitsVC), name: NSNotification.Name(rawValue: "habitsVC"), object: nil)
    }
    func setupNavigation() {
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = UIColor(named: "Purple Color")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(tapEditButton))
    }
    @objc func tapEditButton() {
        
        let habitVC = HabitViewController()
        habitVC.habit = habit
        let navController = UINavigationController(rootViewController: habitVC)
        present(navController, animated: true, completion: nil)
    }
    func setupViews() {
        
        view.addSubview(tableView)
        tableView.toAutoLayout()
                
        let constraints = [
                    
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
                
        NSLayoutConstraint.activate(constraints)
    }
    @objc func habitsVC() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        navigationItem.title = habit.name
        NotificationCenter.default.addObserver(self, selector: #selector(changeTitle), name: NSNotification.Name(rawValue: "changeTitle"), object: nil)
    }
    
    @objc func changeTitle() {
        navigationItem.title = habit.name
    }
    
}

extension HabitDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension HabitDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        HabitsStore.shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let datesTracked = HabitsStore.shared.dates.count - indexPath.item - 1
        cell.textLabel?.text = "\(HabitsStore.shared.trackDateString(forIndex: datesTracked) ?? "")"
        cell.tintColor = UIColor(named: "Purple Color")
        
        let selectedHabit = self.habit
        let date = HabitsStore.shared.dates[datesTracked]
        if HabitsStore.shared.habit(selectedHabit, isTrackedIn: date) {
            cell.accessoryType = .checkmark
        }else {
            cell.accessoryType = .none
        }
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Активность"
    }
    
}
