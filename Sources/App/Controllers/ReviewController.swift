import Fluent
import Vapor

struct ReviewController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let reviews = routes.grouped("reviews")
        reviews.get(use: getAll)
        reviews.post(use: create)
        reviews.group(":reviewID") { review in
            review.get(use: getById)
            review.delete(use: delete)
        }
    }
    
    func getAll(req: Request) async throws -> [Review] {
        if let restaurantId = req.query[UUID.self, at: "restaurantId"] {
            return try await Review.query(on: req.db)
                .filter(\.$restaurant.$id == restaurantId)
                .with(\.$restaurant)
                .all()
        } else {
            return try await Review.query(on: req.db).all()
        }
    }
    
    func getById(req: Request) async throws -> Review {
        guard let review = try await Review.find(req.parameters.get("reviewID"), on: req.db) else {
            throw Abort(.notFound)
        }
        return review
    }
    
    func create(req: Request) async throws -> Review {
        let review = try req.content.decode(Review.self)
        try await review.save(on: req.db)
        return review
    }
    
    func delete(req: Request) async throws -> HTTPStatus {
        guard let review = try await Review.find(req.parameters.get("reviewID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await review.delete(on: req.db)
        return .noContent
    }
}
