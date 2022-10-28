//
//  CourseViewModel.swift
//  CourseNetworking
//
//  Created by DataBunker on 2022-10-28.
//

import Foundation

class CourseViewModel: ObservableObject {
    @Published var message: String = "project"
    @Published var projects: [Project] = [Project]()
    
    func fetchProjects() {
        let urlString = "https://api.sareenv.com/api/v1/projects"
        let session = URLSession.shared
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            } else {
                DispatchQueue.main.async {
                    guard let projects = try? JSONDecoder().decode(Projects.self, from: data!) else { return }
                    self.projects = projects.Items
                }
                
            }
        }.resume()
    }
    
}
