import Foundation

struct User: Identifiable, Codable {
    let id: UUID?
    let name: Name?
    let email: String?
    let phone: String?
    let picture: Picture?
    let gender: String?
    let location: Location?

    struct Name: Codable {
        let title: String?
        let first: String?
        let last: String?
    }

    struct Picture: Codable {
        let large: String?
    }
    
    struct Location: Codable {
        var street: Street?
        let city: String?
        let state: String?
        let country: String?
        let coordinates: Coordinates?
        let timezone: Timezone?

        struct Street: Codable {
            let name: String?
        }

        struct Coordinates: Codable {
            let latitude: String?
            let longitude: String?
        }

        struct Timezone: Codable {
            let offset: String?
            let description: String?
        }
    }

    enum CodingKeys: String, CodingKey {
        case id = "login"
        case name
        case email
        case phone
        case picture
        case gender
        case location
    }

    enum LoginCodingKeys: String, CodingKey {
        case uuid
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let loginContainer = try container.nestedContainer(keyedBy: LoginCodingKeys.self, forKey: .id)
        id = UUID(uuidString: try loginContainer.decode(String.self, forKey: .uuid))

        name = try container.decodeIfPresent(Name.self, forKey: .name)
        email = try container.decodeIfPresent(String.self, forKey: .email)
        phone = try container.decodeIfPresent(String.self, forKey: .phone)
        picture = try container.decodeIfPresent(Picture.self, forKey: .picture)
        gender = try container.decodeIfPresent(String.self, forKey: .gender)
        location = nil
        }

}
