//
//  File.swift
//  DocDocs2
//
//  Created by Евгений Солохин on 29.05.2023.
//

import Foundation

struct DocVisitModel: Identifiable {
    let id: String = UUID().uuidString
    let docName: String
    let date: String
    let images: [String]
}
