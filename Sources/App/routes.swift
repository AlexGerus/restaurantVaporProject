import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.routes.defaultMaxBodySize = "5mb"
    //    let group = app.grouped(VersionHeaderMiddleware())
    
    app.webSocket("chat") { req, ws in
        ws.onText { ws, text in
            // This block is called when a text message is received from the client
            print("Received text: \(text)")

            // Send a response back to the client
            ws.send("You said: \(text)")
        }

        ws.onClose.whenComplete { _ in
            // This block is called when the WebSocket connection is closed
            print("WebSocket closed")
        }
    }
    
    app.get { req async throws in
        try await req.view.render("index", ["title": "Hello Vapor!"])
    }
    
    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    try app.register(collection: RestaurantController())
    try app.register(collection: ReviewController())
}
