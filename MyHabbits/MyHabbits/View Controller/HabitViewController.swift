//
//  HabitsViewController.swift
//  MyHabbits
//
//  Created by Андрей Михайлов on 23.06.2021.
//

import UIKit

class HabitViewController: UIViewController {
    
 
    var habit: Habit? {
        didSet{
            creatHabit()
        }
    }
    private let scrollView = UIScrollView()
    
    private let habitsView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.toAutoLayout()
        return view
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Semibold", size: 13)
        label.text = "НАЗВАНИЕ"
        label.toAutoLayout()
        return label
    }()
    
    private let nameTextField: UITextField = {
        let text = UITextField()
        text.font = UIFont(name: "SFProText-Semibold", size: 17)
        text.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        text.textColor = .black
        text.toAutoLayout()
        return text
    }()
    
    private let colorLabel: UILabel = {
        let color = UILabel()
        color.text = "ЦВЕТ"
        color.font = UIFont(name: "SFProText-Semibold", size: 13)
        color.toAutoLayout()
        return color
    }()
    
    private let colorButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.backgroundColor = .orange
        button.addTarget(self, action: #selector(colorTapButton), for: .touchDown)
        button.toAutoLayout()
        return button
    }()
    
    let colorPicker = UIColorPickerViewController()
    
    private let timeLabel: UILabel = {
        let time = UILabel()
        time.font = UIFont(name: "SFProText-Semibold", size: 13)
        time.text = "ВРЕМЯ"
        time.toAutoLayout()
        return time
    }()
    
    private let timeTextLabel: UILabel = {
        let time = UILabel()
        time.text = "Каждый день в "
        time.font = UIFont(name: "SFProText-Semibold", size: 17)
        time.toAutoLayout()
        return time
    }()
    private let timeCheckLabel: UILabel = {
        let timeCheck = UILabel()
        timeCheck.text = ""
        timeCheck.font = UIFont(name: "SFProText-Semibold", size: 17)
        timeCheck.textColor = UIColor(named: "Purple Color")
        timeCheck.toAutoLayout()
        return timeCheck
    }()
    private let timePickerLabel: UIDatePicker = {
        let date = UIDatePicker()
        date.datePickerMode = .time
        date.preferredDatePickerStyle = .wheels
        date.addTarget(self, action: #selector(createTime), for: .valueChanged)
        date.toAutoLayout()
        return date
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(allertController), for: .touchUpInside)
        button.toAutoLayout()
        return button
    }()
    
    override func viewDidLoad() {
        nameTextField.delegate = self
        colorPicker.delegate = self
        navigationItem.title = "Создать"
        navigationController?.navigationBar.prefersLargeTitles = false
        setupUILabel()
        creatHabit()
        createButton()
    }
    
    func setupUILabel() {
        tabBarController?.tabBar.tintColor = UIColor(named: "Purple Color")
        scrollView.toAutoLayout()
        view.addSubview(scrollView)
        scrollView.addSubview(habitsView)
        habitsView.addSubViews(nameLabel, nameTextField, colorLabel, colorButton, timeLabel, timeTextLabel, timePickerLabel, timeCheckLabel, deleteButton)
        
        let constrains = [
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                        
            habitsView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            habitsView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            habitsView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            habitsView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            habitsView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                        
            nameLabel.topAnchor.constraint(equalTo: habitsView.topAnchor, constant: 21),
            nameLabel.leadingAnchor.constraint(equalTo: habitsView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: habitsView.trailingAnchor, constant: -285),
                        
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 7),
            nameTextField.leadingAnchor.constraint(equalTo: habitsView.leadingAnchor, constant: 15),
            nameTextField.trailingAnchor.constraint(equalTo: habitsView.trailingAnchor, constant: -65),
                        
            colorLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            colorLabel.leadingAnchor.constraint(equalTo: habitsView.leadingAnchor, constant: 16),
            colorLabel.trailingAnchor.constraint(equalTo: habitsView.trailingAnchor, constant: -323),
                        
            colorButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 7),
            colorButton.leadingAnchor.constraint(equalTo: habitsView.leadingAnchor, constant: 16),
            colorButton.widthAnchor.constraint(equalToConstant: 30),
            colorButton.heightAnchor.constraint(equalTo: colorButton.widthAnchor),
                        
            timeLabel.topAnchor.constraint(equalTo: colorButton.bottomAnchor, constant: 15),
            timeLabel.leadingAnchor.constraint(equalTo: habitsView.leadingAnchor, constant: 16),
            timeLabel.trailingAnchor.constraint(equalTo: habitsView.trailingAnchor, constant: -312),
                        
            timeTextLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 7),
            timeTextLabel.leadingAnchor.constraint(equalTo: habitsView.leadingAnchor, constant: 16),
            timeTextLabel.trailingAnchor.constraint(equalTo: timeCheckLabel.leadingAnchor, constant: -1),
                        
            timeCheckLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 7),
                        
            timePickerLabel.topAnchor.constraint(equalTo: timeCheckLabel.bottomAnchor, constant: 15),
            timePickerLabel.leadingAnchor.constraint(equalTo: habitsView.leadingAnchor),
            timePickerLabel.trailingAnchor.constraint(equalTo: habitsView.trailingAnchor),
            timePickerLabel.bottomAnchor.constraint(equalTo: habitsView.bottomAnchor),
            
            deleteButton.topAnchor.constraint(equalTo: timePickerLabel.bottomAnchor, constant: 270),
            deleteButton.centerXAnchor.constraint(equalTo: habitsView.centerXAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: habitsView.bottomAnchor)
            
        ]
        NSLayoutConstraint.activate(constrains)
    }
    
    @objc func allertController() {
        guard habit != nil else {
            return
        }
        let alertController = UIAlertController(title: "Удалить привычку", message: "Вы действительно хотите удалить привычку?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        let confirm = UIAlertAction(title: "Удалить", style: .default, handler: { (action: UIAlertAction) in
            self.removeHabit()
            self.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(cancel)
        alertController.addAction(confirm)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func removeHabit() {
        HabitsStore.shared.habits.removeAll {$0 == self.habit }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: ""), object: nil)
    }
    func creatHabit() {
        if let changeHabit = habit {
            nameTextField.text = changeHabit.name
            nameTextField.textColor = changeHabit.color
            nameTextField.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
            colorButton.backgroundColor = changeHabit.color
            timePickerLabel.date = changeHabit.date
            navigationItem.title = "Править"
            deleteButton.isHidden = false
        } else {
            nameTextField.text = ""
            colorButton.backgroundColor = .orange
            timePickerLabel.date = Date()
            navigationItem.title = "Создать"
            deleteButton.isHidden = true
        }
    }
    func createButton() {
        
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = UIColor(named: "Purple Color")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(returnBack))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveHabit))
    }
    
    @objc func returnBack() {
    self.dismiss(animated: true, completion: nil)
    }
    
    @objc func saveHabit() {
        if let changedHabit = self.habit {
            changedHabit.name = nameTextField.text ?? ""
            changedHabit.date = timePickerLabel.date
            changedHabit.color = colorButton.backgroundColor ?? .white
        } else {
            let newHabit = Habit(name: nameTextField.text ?? "",
                                 date: timePickerLabel.date,
                                 color: colorButton.backgroundColor ?? .white)
            
            let store = HabitsStore.shared
            store.habits.append(newHabit)
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeTitle"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
       }
       
    override func viewDidDisappear(_ animated: Bool) {
           super.viewDidDisappear(animated)
           
           NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
       }
    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
           if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
               
               scrollView.contentInset.bottom = keyboardSize.height
               scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
           }
       }
       
    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
           scrollView.contentInset.bottom = .zero
           scrollView.verticalScrollIndicatorInsets = .zero
       }
    
    @objc func colorTapButton() {
        
        self.present(colorPicker, animated: true, completion: nil)
        
    }
    
    @objc func createTime(paramdatePicker: UIDatePicker) {
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            formatter.dateStyle = .none
            
            timeCheckLabel.text = formatter.string(from: timePickerLabel.date)
        }

}
extension HabitViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        colorButton.backgroundColor = viewController.selectedColor
    }
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        colorButton.backgroundColor = viewController.selectedColor
    }
}

extension UIView {
    func toAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    func addSubViews(_ subviews: UIView...) {
        subviews.forEach{ addSubview($0) }
    }
}

