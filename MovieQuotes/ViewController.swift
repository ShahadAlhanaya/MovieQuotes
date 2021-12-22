//
//  ViewController.swift
//  MovieQuotes
//
//  Created by Shahad Nasser on 19/12/2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies: [MovieItem] = [
        MovieItem(movie: Movie(title: "Elf", image: "elf",
                              quotes: ["elf1","elf2"])),
        MovieItem(movie: Movie(title: "Hamilton", image: "hamilton",
                               quotes: ["hamilton1","hamilton2"])),
        MovieItem(movie: Movie(title: "Joker", image: "joker",
                               quotes: ["joker1","joker2"])),
        MovieItem(movie: Movie(title: "Leon The Professional", image: "leon",
                               quotes: ["leon1","leon2"])),
        MovieItem(movie: Movie(title: "Lion", image: "lion",
                               quotes: ["lion1","lion2"])),
        MovieItem(movie: Movie(title: "Mulan", image: "mulan",
                               quotes: ["mulan1","mulan2"]))
    ]
    
    var selectedMovies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeCollectionView()
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft(gesture: )))
        leftSwipe.direction = .left
        self.view.addGestureRecognizer(leftSwipe)
    }
    
    @objc func swipeLeft(gesture: UISwipeGestureRecognizer){
        if !selectedMovies.isEmpty{
            performSegue(withIdentifier: "QuotesQuizSegue", sender: self)
        }else{
            let alert = UIAlertController(title: "Select Movies", message: "Please select one movie or more to start Quotes Quiz", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let quizViewController = segue.destination as! QuizViewController
        quizViewController.movies = selectedMovies
    }
    
    func customizeCollectionView(){
        collectionView.backgroundColor = UIColor(named: "bgColor")
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = layout.minimumInteritemSpacing
        layout.itemSize = CGSize(width: 110, height: 183)
    }
    
}


extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
        cell.movieLabel.text = movies[indexPath.row].movie.title
        cell.movieImageView.image = UIImage(named: movies[indexPath.row].movie.image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        if( movies[indexPath.row].selected){
            movies[indexPath.row].selected = false
            cell?.isSelected = false
            
            removeFromSelectedMovies(movie: movies[indexPath.row].movie)
            
            cell?.layer.borderColor = UIColor.black.cgColor
            cell?.layer.borderWidth = 0
            cell?.backgroundColor = UIColor.black
        }else{
            movies[indexPath.row].selected = true
            cell?.isSelected = true
            
            addToSelectedMovies(movie: movies[indexPath.row].movie)
            
            cell?.layer.borderColor = UIColor(named: "selectionColor")?.cgColor
            cell?.layer.borderWidth = 3
            cell?.backgroundColor = UIColor(named: "selectionColor")
        }
    }
    
    func addToSelectedMovies(movie: Movie){
        if selectedMovies.contains(where: { $0.title == movie.title }) {
            print("movie already selected")
        } else {
            selectedMovies.append(movie)
            print("i added")
        }
    }
    
    func removeFromSelectedMovies(movie: Movie){
        selectedMovies.removeAll(where: { $0.title == movie.title })
        print("i removed")
    }
    
}




