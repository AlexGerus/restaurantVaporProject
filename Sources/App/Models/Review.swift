import Foundation
import Vapor
import Fluent
import FluentPostgresDriver

final class Review: Model, Content {
    static let schema = "reviews"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String
    
    @Field(key: "body")
    var body: String
    
    @Parent(key: "restaurant_id")
    var restaurant: Restaurant

    init() { }

    init(id: UUID? = nil, title: String, body: String, userId: UUID) {
        self.id = id
        self.title = title
        self.body = body
        self.$restaurant.id = userId
    }
}
