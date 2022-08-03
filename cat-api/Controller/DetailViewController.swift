//
//  DetailViewController.swift
//  cat-api
//
//  Created by Carlos Perez on 3/8/22.
//

import UIKit
import CoreData
import Cosmos

class DetailViewController: UIViewController {

    
    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var dislikesCountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    
    @IBOutlet weak var intelligenceStarView: CosmosView!
    @IBOutlet weak var adaptabilityStarView: CosmosView!
    @IBOutlet weak var groomingStarView: CosmosView!
    
    @IBOutlet weak var reactionTableView: UITableView!
    
    var categoryId: String!
    var url: String!
    var reactions: [UserReaction] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let dateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadBreedDetail()
        self.reactionTableView.dataSource = self
        dateFormatter.dateFormat = "dd 'de' MMMM 'de' yyyy"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    }

    func loadBreedDetail() {
        WSAPI.shared().loadBreedDetail(breedId: self.categoryId) { response, error in
            if (error == nil) {
                if let record = response {
                    let placeholderImage = UIImage(named: "placeholder")
                    self.loadReactions()
                    
                    self.nameLabel.text = record.name
                    self.descriptionLabel.text = record.description
                    self.catImageView.sd_setImage(with: URL(string: self.url), placeholderImage: placeholderImage)
                    self.intelligenceStarView.rating = Double(record.intelligence)
                    self.adaptabilityStarView.rating = Double(record.adaptability)
                    self.groomingStarView.rating = Double(record.grooming)

                }
            }
        }
    }
    
    
    func loadReactions () {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CategoryUser")
        request.predicate = NSPredicate(format: "categoryid = %@", self.categoryId)
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            var likesCount = 0
            var disLikesCount = 0
            for record in result as! [NSManagedObject] {
                let name = record.value(forKey: "user") as! String
                let liked = record.value(forKey: "liked") as! Bool
                let date = record.value(forKey: "date") as! Date
                
                reactions.append(.init(name: name, date: date, liked: liked))
                if liked {
                    likesCount += 1
                } else {
                    disLikesCount += 1
                }
            }
            
            self.likesCountLabel.text = "\(likesCount)"
            self.dislikesCountLabel.text = "\(disLikesCount)"
            self.reactionTableView.reloadData()
        } catch {
            print("Error Reading")
        }
    }

}


extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let data = reactions[indexPath.row]
        
        cell.imageView?.image = data.liked ? UIImage(named: "ic_yes") : UIImage(named: "ic_no")
        cell.textLabel?.text = data.name
        cell.detailTextLabel?.text = dateFormatter.string(from: data.date)
                
        return cell
    }
}
