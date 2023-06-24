//
//  MenuViewController.swift
//  PizzaHot
//
//  Created by Dima Zhiltsov on 22.06.2023.
//

import UIKit

protocol MenuViewProtocol: UIViewController {
    func scrollTable(to section: Int)
    func reloadData()
}

final class MenuViewController: UIViewController {
    
    private let presenter: MenuPresenterProtocol
    
    private let locationButton = LocationButton()
    private let bannersView = BannersCollectionView()
    private let categoriesView = CategoriesView()
    private let tableView = UITableView()
    
    private var lastVisibleSection = -1
        
    init(_ presenter: MenuPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppearance()
        setupViews()
        setupConstraints()
        presenter.updateFoods()
    }
}

extension MenuViewController {
    
    private func setupAppearance() {
        view.backgroundColor = .lightGray
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupViews() {
        [locationButton, bannersView, categoriesView, tableView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        categoriesView.presenter = presenter
        tableView.backgroundColor = .systemBackground
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FoodCell.self, forCellReuseIdentifier: R.Identifiers.foodCell)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            locationButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            locationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            bannersView.topAnchor.constraint(equalTo: locationButton.bottomAnchor, constant: 20),
            bannersView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannersView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bannersView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/7),
            
            categoriesView.topAnchor.constraint(equalTo: bannersView.bottomAnchor, constant: 20),
            categoriesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoriesView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoriesView.heightAnchor.constraint(equalToConstant: 40),
            
            tableView.topAnchor.constraint(equalTo: categoriesView.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)            
        ])
    }
}

// MARK: - MenuViewProtocol

extension MenuViewController: MenuViewProtocol {
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            tableView.reloadData()
            categoriesView.reloadData()
            categoriesView.didSelectCategory(0)
        }
    }
    
    func scrollTable(to section: Int) {
        let indexPath = IndexPath(row: 0, section: section)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension MenuViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.Identifiers.foodCell, for: indexPath) as? FoodCell
        else { fatalError("Failed downcasting to FoodCell") }
        
        presenter.configure(cell: cell, at: indexPath)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableHeight = view.bounds.height
        let cellHeight = tableHeight / 5
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? FoodCell else { fatalError("Failed downcasting to FoodCell") }
        presenter.willDisplay(cell: cell, at: indexPath)
    }
}

// MARK: - UIScrollViewDelegate

extension MenuViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let topIndexPath = tableView.indexPathsForVisibleRows?.first {
            let currentSection = topIndexPath.section
            if currentSection != lastVisibleSection {
                lastVisibleSection = currentSection
                categoriesView.didSelectCategory(currentSection)
            }
        }
    }
}

