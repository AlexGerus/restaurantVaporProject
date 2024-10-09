import Fluent
import Vapor

struct RestaurantController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let restaurants = routes.grouped("restaurants")
        restaurants.get(use: getAll)
        restaurants.post(use: create)
        restaurants.group(":restaurantID") { restaurant in
            restaurant.get(use: getById)
            restaurant.delete(use: delete)
        }
    }

    func getAll(req: Request) async throws -> [Restaurant] {
        try await Restaurant.query(on: req.db).all()
    }
    
    func getById(req: Request) async throws -> Restaurant {
        guard let restaurant = try await Restaurant.find(req.parameters.get("restaurantID"), on: req.db) else {
            throw Abort(.notFound)
        }
        return restaurant
    }

    func create(req: Request) async throws -> Restaurant {
        let restaurant = try req.content.decode(Restaurant.self)
        try await restaurant.save(on: req.db)
        return restaurant
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let restaurant = try await Restaurant.find(req.parameters.get("restaurantID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await restaurant.delete(on: req.db)
        return .noContent
    }
}
