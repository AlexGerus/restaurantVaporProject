//
//  File.swift
//  
//
//  Created by Alexander Gerus on 02.09.2023.
//

import Vapor

//struct VersionHeaderMiddleware: Middleware {
//    func respond(to request: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {
//        next.respond(to: request).map { response in
//            response.headers.add(name: "Version", value: "v2.5")
//            return response
//        }
//    }
//}

struct VersionHeaderMiddleware: AsyncMiddleware {
    func respond(to request: Request, chainingTo next: AsyncResponder) async throws -> Response {
        let response = try await next.respond(to: request)
        response.headers.add(name: "Version", value: "v2.5")
        return response
    }
}
