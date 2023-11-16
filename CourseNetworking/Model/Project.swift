//
//  Course.swift
//  CourseNetworking
//
//  Created by DataBunker on 2022-10-28.
//

import Foundation

struct Project: Decodable, Identifiable {
    let id = UUID()
    let projectName: String
    var thumbnail: String
    let description: String
    let github: String
}

struct Projects: Decodable {
    let Items: [Project]
}
