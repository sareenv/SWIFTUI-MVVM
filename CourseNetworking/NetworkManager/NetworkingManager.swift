//
//  NetworkingManager.swift
//  CourseNetworking
//
//  Created by DataBunker on 2023-11-15.
//

import Foundation

/// A protocol which specifies if the networking operations to perform.
protocol ProjectManager {
    
    // A method responsible for downloading the project from APi.
    func downloadProjects() async throws -> [Project]
}

enum NetworkingError: Error {
    case decodingError
    case networkError
    case statusCodeError
    case unknownError
}

/// A class responsible for performing networking operations to get the projects.
class ProjectNetworkingManager: ProjectManager {
    
    /// An object to the URL session to make the network requests.
    private var session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    /// Constants used in the file to make the network requests.
    private enum Constants {
        static let baseUrl: String = "https://api.sareenv.com/api/v1"
        static var projectPath: String { baseUrl + "/projects" }
    }
    
    /// A method responsible for downloading all the projects from the APi.
    /// - Returns: returns an array of projects.
    func downloadProjects() async throws -> [Project] {
        guard let projectsUrl = URL(string: Constants.projectPath) else { throw NSError() }
        do {
            let (data, response) = try await session.data(from: projectsUrl)
            guard let response = response as? HTTPURLResponse else { throw NSError() }
            guard response.statusCode == 200 else { throw NetworkingError.networkError }
            guard let projects = try? JSONDecoder().decode(Projects.self, from: data) else { throw NetworkingError.decodingError }
            return projects.Items
        } catch {
            if error is DecodingError { print("Error decoding the data") }
            throw error
        }
    }
}



