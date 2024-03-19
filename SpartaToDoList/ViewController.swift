//
//  ViewController.swift
//  SpartaToDoList
//
//  Created by 밀가루 on 3/19/24.
//

import UIKit

struct TodoItems {
    var id: Int
    var title: String
    var isCompleted: Bool
}

let todo1 = TodoItems(id: 1, title: "장보기", isCompleted: false)
let todo2 = TodoItems(id: 2, title: "운동하기", isCompleted: true)
let todo3 = TodoItems(id: 3, title: "책 읽기", isCompleted: false)

var todos = [todo1, todo2, todo3]

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var table: UITableView!
    
    // 데이터 배열
    var todos = [TodoItems]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 데이터 초기화
        initializeData()
        
        // 테이블 뷰의 delegate와 dataSource 설정
        table.delegate = self
        table.dataSource = self
        
        // 셀 등록
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    // 데이터 초기화
    func initializeData() {
        let todo1 = TodoItems(id: 1, title: "장보기", isCompleted: false)
        let todo2 = TodoItems(id: 2, title: "운동하기", isCompleted: true)
        let todo3 = TodoItems(id: 3, title: "책 읽기", isCompleted: false)
        
        todos = [todo1, todo2, todo3]
    }
    
    // MARK: - UITableViewDataSource Methods
    
    // 셀 수 반환
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    // 각 셀에 대한 설정 및 반환
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let todo = todos[indexPath.row]
        cell.textLabel?.text = todo.title
        
        let mySwitch = UISwitch()
        mySwitch.isOn = todo.isCompleted
        mySwitch.tag = indexPath.row
        mySwitch.addTarget(self, action: #selector(didChangeSwitch(_:)), for: .valueChanged)
        cell.accessoryView = mySwitch
        
        // 완료 여부에 따라 텍스트 색상 설정
        cell.textLabel?.textColor = todo.isCompleted ? .gray : .black
        
        return cell
    }

    @objc func didChangeSwitch(_ sender: UISwitch) {
        let index = sender.tag
        let toggledTodo = todos[index]
        todos[index].isCompleted = !todos[index].isCompleted

        if sender.isOn {
            print("user turned on the switch for: \(toggledTodo)")
        } else {
            print("user turned off the switch for: \(toggledTodo)")
        }
        
        table.reloadData()
    }
}
