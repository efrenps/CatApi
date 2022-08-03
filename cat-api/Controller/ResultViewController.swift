//
//  ResultViewController.swift
//  cat-api
//
//  Created by Carlos Perez on 3/8/22.
//

import UIKit
import CoreData

class ResultViewController: UITableViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var categories: [BreedListResponse] = []
    let placeholderImage = UIImage(named: "placeholder")

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getCategoryCount (categoryId: String, liked: Bool) -> Int {
        let context = appDelegate.persistentContainer.viewContext

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CategoryUser")
        
        let idKeyPredicate = NSPredicate(format: "categoryid = %@", categoryId)
        let likedKeyPredicate = NSPredicate(format: "liked = %@", NSNumber(booleanLiteral: liked))
        let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [idKeyPredicate, likedKeyPredicate])
        request.predicate = andPredicate
        
        do {
            let result = try context.count(for: request)
            return result
        } catch {
            print("Error Reading")
        }
        return 0
    }
    
    
    /* Data source section */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultViewCell", for: indexPath) as! ResultViewCell
        let data = categories[indexPath.row]
        
        cell.nameLabel.text = data.name
        
        if let currentImage = data.image {
            cell.catImage.sd_setImage(with: URL(string: currentImage.url), placeholderImage: placeholderImage)
        } else {
            cell.catImage.image =  placeholderImage
        }
        
        cell.likedLabel.text = "\(self.getCategoryCount(categoryId: data.id, liked: true))"
        cell.noLikedLabel.text = "\(self.getCategoryCount(categoryId: data.id, liked: false))"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    /* Delegate section */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController

        vc.categoryId = categories[indexPath.row].id
        vc.url = categories[indexPath.row].image?.url
        self.navigationController?.show(vc, sender: true)
    }

}


