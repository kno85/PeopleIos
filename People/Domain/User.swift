//
//  Users.swift
//  People
//
//  Created by AntonioCano on 06/08/2024.
//

import Foundation

struct User: Identifiable, Codable {
    let id: UUID
    let name: Name
    let email: String?
    let phone: String?
    let picture: Picture
    
    struct Name: Codable {
        let first: String
        let last: String
    }
    
    struct Picture: Codable {
        let large: String
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "login"
        case name
        case email
        case phone
        case picture
    }
    
    enum LoginCodingKeys: String, CodingKey {
        case uuid
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let loginContainer = try container.nestedContainer(keyedBy: LoginCodingKeys.self, forKey: .id)
        id = UUID(uuidString: try loginContainer.decode(String.self, forKey: .uuid))!
        name = try container.decode(Name.self, forKey: .name)
        email = try container.decodeIfPresent(String.self, forKey: .email)
        phone = try container.decodeIfPresent(String.self, forKey: .phone)
        picture = try container.decode(Picture.self, forKey: .picture)
    }
}
