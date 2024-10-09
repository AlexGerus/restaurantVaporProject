import NIOSSL
import Fluent
import FluentPostgresDriver
import Leaf
import Vapor
import APNS

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.middleware.use(VersionHeaderMiddleware(), at: .beginning)

    app.databases.use(DatabaseConfigurationFactory.postgres(configuration: .init(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? SQLPostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "alexandergerus",
        password: Environment.get("DATABASE_PASSWORD") ?? "",
        database: Environment.get("DATABASE_NAME") ?? "restaurantdb",
        tls: .prefer(try .init(configuration: .clientDefault)))
    ), as: .psql)

//    app.migrations.add(CreateTodo())
    app.migrations.add(CreateRestaurant())
    app.migrations.add(CreateReview())

    app.views.use(.leaf)

//    let apnsConfig = APNSClientConfiguration(
//        authenticationMethod: .jwt(
//            privateKey: try .loadFrom(filePath: "<#path to .p8#>")!,
//            keyIdentifier: "<#key identifier#>",
//            teamIdentifier: "<#team identifier#>"
//        ),
//        environment: .sandbox
//    )
//    app.apns.containers.use(
//        apnsConfig,
//        eventLoopGroupProvider: .shared(app.eventLoopGroup),
//        responseDecoder: JSONDecoder(),
//        requestEncoder: JSONEncoder(),
//        backgroundActivityLogger: app.logger,
//        as: .default
//    )
    

    // register routes
    try routes(app)
}
