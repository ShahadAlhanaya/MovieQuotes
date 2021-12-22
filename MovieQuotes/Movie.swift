//
//  Movie.swift
//  MovieQuotes
//
//  Created by Shahad Nasser on 19/12/2021.
//

import Foundation

class MovieItem{
    let movie: Movie
    var selected: Bool
    
    init(movie: Movie){
        self.movie = movie
        selected = false
    }
}

struct Movie{
    let title: String
    let image: String
    let quotes: [String]
}
