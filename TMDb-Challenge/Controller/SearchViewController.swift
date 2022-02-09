//
//  SearchViewController.swift
//  TMDb-Challenge
//
//  Created by John Allen Santos Coimbra on 07/02/22.
//

import UIKit

class SearchViewController: UIViewController {
    // MARK: - Properties
    /// UI Background Image
    private lazy var movieImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = UIImage(named: "backgroundMovies")
        iv.backgroundColor = .black
        return iv
    }()
    
    /// UI Text
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = "Enter the name of the favorite movie to search for information or select button for results all movies"
        label.textColor = .white
        label.numberOfLines = 4
        label.textAlignment = .center
        return label
    }()
    
    /// UI View
    private lazy var searchContainerView: UIView = {
        let image = #imageLiteral(resourceName: "search_unselected")
        let view = Utilities().inputContainerView(withImage: image, textField: searchTextField)
        return view
    }()
    
    /// UI TextField
    private let searchTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Enter name movie...")
        return tf
    }()
    
    /// UI Button Search
    private let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Search now", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .mobile2you
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleSearch), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    @objc func handleSearch() {
        let controller = ResultSearchViewController(collectionViewLayout: UICollectionViewFlowLayout())
        
        if searchTextField.text != "" {
            controller.name = searchTextField.text
            navigationController?.pushViewController(controller, animated: true)
        } else {
            showAlert()
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "The Movie DB", message: "Enter the movie name", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Ao abrir a bar search, o textField já estará com o cursor
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .black
        
        title = "Search Movies"
        
        view.addSubview(movieImageView)
        movieImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        view.addSubview(infoLabel)
        infoLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 24, paddinRight: 24)
        
        let stack = UIStackView(arrangedSubviews: [searchContainerView, searchButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.anchor(top: infoLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 16, paddinRight: 16)
    }
}
