//
//  mealCollectionViewController.swift
//  mealLog
//
//  Created by Jianli He on 8/12/19.
//  Copyright © 2019 Jianli He. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class mealCollectionViewController: UICollectionViewController {
    //MARK: properties
    var meals = [meal] ()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleMeals()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return meals.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier="mealTableViewCell"
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? mealTableViewCell else {
            fatalError("cannot return cell")
        }
        
        let meal=meals[indexPath.row]
        cell.nameLabel.text=meal.name
        cell.photoImageView.image=meal.photo
        cell.ratingControl.rating=meal.rating
        
        
        
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    //MARK: private functions
    private func loadSampleMeals() {
        let photo1=UIImage(named:"sample1")
        let photo2=UIImage(named:"sample2")
        let photo3=UIImage(named:"sample3")
        
        guard let meal1 = meal(name:"Salad",photo: photo1,rating: 4) else {
            fatalError("cannot creat meal 1")
        }
        
        guard let meal2 = meal(name: "chilcken", photo: photo2, rating: 5) else {
            fatalError("cannot creat meal 2")
        }
        
        guard let meal3 = meal(name: "pasta", photo: photo3, rating: 3) else {
            fatalError("cannot creat meal 3")
        }
        
        meals += [meal1,meal2,meal3]
    }

}
