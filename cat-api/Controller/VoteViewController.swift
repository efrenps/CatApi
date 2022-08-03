//
//  VoteViewController.swift
//  cat-api
//
//  Created by Carlos Perez on 3/8/22.
//

import UIKit
import SDWebImage
import CoreData

class VoteViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var catImageView: UIImageView!
    
    @IBOutlet weak var noButton: UIImageView!
    @IBOutlet weak var yesButton: UIImageView!
    
    var categories: [BreedListResponse] = []
    var currentIndex = 0
    var currentName = ""
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let placeholderImage = UIImage(named: "placeholder")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.handleButtons(enabled: true)
    
        yesButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onYesButton(_:))))
        noButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onNoButton(_:))))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Resultados", style: .plain, target: self, action: #selector(onShowResults))
        self.loadBreeds()
    }
    
    func loadBreeds() {
        WSAPI.shared().loadBreeds() { response, error in
            if (error == nil) {
                if let list = response {
                    self.categories = list
                    self.showData()
                }
            }
        }
    }
    
    func showData(){
        let currentData = categories[currentIndex]
        self.titleLabel.text = currentData.name
        
        if let currentImage = currentData.image {
            self.catImageView.sd_setImage(with: URL(string: currentImage.url), placeholderImage: placeholderImage)
        } else {
            self.catImageView.image =  placeholderImage
        }
    }
    
    func handleButtons(enabled: Bool) {
        self.noButton.isUserInteractionEnabled = enabled
        self.yesButton.isUserInteractionEnabled = enabled
    }
    
    @objc func onShowResults(_ sender: Any) {
        self.showResultsView()
    }
    
    @objc func onYesButton(_ sender: Any) {
        self.handleOption(liked: true)
    }
    
    @objc func onNoButton(_ sender: Any) {
        self.handleOption(liked: false)
    }
    
    func handleOption(liked: Bool){
        self.handleButtons(enabled: false)
        let currentData = categories[currentIndex]
        
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "CategoryUser", in: context)
        let newData = NSManagedObject(entity: entity!, insertInto: context)
        
        newData.setValue(currentData.id, forKey: "categoryid")
        newData.setValue(currentData.name, forKey: "categoryname")
        newData.setValue(self.currentName, forKey: "user")
        newData.setValue(liked, forKey: "liked")
        newData.setValue(Date(), forKey: "date")

        do {
            try context.save()
            
            if (currentIndex < categories.count) {
                currentIndex = currentIndex + 1
                self.showData()
                self.handleButtons(enabled: true)
            } else {
                self.showResultsView()
            }
         } catch {
          print("Error saving")
        }
    }
    
    func showResultsView() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        vc.categories = self.categories
        self.navigationController?.show(vc, sender: true)
    }

}
