//
//  MenuViewController.swift
//  PizzaHot
//
//  Created by Dima Zhiltsov on 22.06.2023.
//

import UIKit

protocol MenuViewProtocol: UIViewController {    
    func reloadData()
}

final class MenuViewController: UIViewController {
    
    private let presenter: MenuPresenterProtocol
    
    private let tableView = UITableView()
    
    init(_ presenter: MenuPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.updateFoods()
        setupView()
        setupConstraints()
    }
}

extension MenuViewController {
    private func setupView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FoodCell.self, forCellReuseIdentifier: R.Identifiers.foodCell)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension MenuViewController: MenuViewProtocol {
    func reloadData() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.Identifiers.foodCell, for: indexPath) as? FoodCell
        else { fatalError("Failed downcasting to FoodCell") }
        
        presenter.configure(cell: cell, at: indexPath.row)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableHeight = tableView.bounds.height
        let cellHeight = tableHeight / 4
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? FoodCell else { fatalError("Failed downcasting to FoodCell") }
        presenter.willDisplay(cell: cell, at: indexPath.row)
    }
}
