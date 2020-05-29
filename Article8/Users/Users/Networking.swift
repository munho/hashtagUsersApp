//
//  Networking.swift
//  Users
//
//  Created by Dhruvik Chevli on 31/03/20.
//  Copyright © 2020 Dhruvik Chevli. All rights reserved.
//

import Foundation
enum UserError:Error{
    case NoDataAvailable
    case CanNotProcessData
    case invalidURL
}
struct Networking{
    static let sharedInstance = Networking()
    let session = URLSession.shared
    
    let userURL = "https://jsonplaceholder.typicode.com/users"
    
    func getUsers(completion: @escaping(Result<[User],UserError>)->Void) {
        guard let UserURL=URL(string: userURL) else {
            completion(.failure(.invalidURL))
            return
        }
        let dataTask=session.dataTask(with: UserURL){data,_,_ in
            guard let jsonData = data else{
                completion(.failure(.NoDataAvailable))
                return
            }
            do{
                let decoder = JSONDecoder()
                let userResponse = try decoder.decode([User].self,from:jsonData)
                completion(.success(userResponse))
            }
            catch{
                completion(.failure(.CanNotProcessData))
            }
        }
        dataTask.resume()
    }
}


