import Foundation
import Fluent
import FluentPostgresDriver

struct CreateRestaurant: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("restaurant")
            .id()
            .field("title", .string)
            .field("poster", .string)
            .field("address", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("restaurant").delete()
    }
}
