//
//  NetworkRequest.swift
//  TrendingArticles
//
//  Created by Mustafa.saify on 23/10/2022.
//
import Foundation

protocol NetworkRequest {
    var urlRequest: URLRequest { get }
}
