import Fluent
import Vapor

final class Restaurant: Model, Content {
    static let schema = "restaurant"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String
    
    @Field(key: "poster")
    var poster: String
    
    @Field(key: "address")
    var address: String
    
    @Children(for: \.$restaurant)
    var reviews: [Review]

    init() { }

    init(id: UUID? = nil, title: String, poster: String, address: String) {
        self.id = id
        self.title = title
        self.poster = poster
        self.address = address
    }
}
