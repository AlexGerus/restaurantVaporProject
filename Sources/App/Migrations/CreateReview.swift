import Foundation
import Vapor
import Fluent
import FluentPostgresDriver

struct CreateReview: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("reviews")
            .id()
            .field("title", .string)
            .field("body", .string)
            .field("restaurant_id", .uuid, .references("restaurant", "id"))
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("reviews").delete()
    }
}
