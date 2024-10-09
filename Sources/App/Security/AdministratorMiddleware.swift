//
//  AdministratorMiddleware.swift
//  
//
//  Created by Alexander Gerus on 02.09.2023.
//

import Vapor

//struct AdministrationMiddleware: Middleware {
//    func respond(to request: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {
//        guard let adminUser = request.auth.get(User.self), adminUser.role = .admin else {
//            throw Abort(.unauthorized)
//        }
//        return try await next.respond(to: request)
//    }
//}
