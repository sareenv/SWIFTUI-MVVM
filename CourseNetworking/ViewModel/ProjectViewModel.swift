//
//  ProjectViewModel.swift
//  CourseNetworking
//
//  Created by DataBunker on 2022-10-28.
//

import Foundation

class ProjectViewModel: ObservableObject {

    @Published var projects: [Project]
    
    var dataManager: ProjectManager?
    
    init() {
        self.projects = [Project]()
        self.dataManager = ProjectNetworkingManager()
    }
    
    @MainActor
    func fetchProjects() {
        Task {
            do {
                let projectsData = try await dataManager?.downloadProjects()
                self.projects = projectsData!
                projects.sort { projecta, projectb in
                    if #available(iOS 17, *) {
                        return projecta.id > projectb.id
                    } else {
                        // Fallback on earlier versions
                        return false
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
