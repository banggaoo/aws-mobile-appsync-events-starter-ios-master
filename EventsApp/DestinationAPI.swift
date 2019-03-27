//
//  DestinationAPI.swift
//  EventsApp
//
//  Created by James Lee on 27/03/2019.
//  Copyright © 2019 Dubal, Rohan. All rights reserved.
//

import AWSAppSync

public final class DestinationQuery: GraphQLQuery {
    
    public static let operationString =
    "query getAllDestinations {\n  getAllDestinations {\n     id\n    city\n  }\n    }"
    
    public init() {
    }
    
    public struct Data: GraphQLSelectionSet {
        public static let possibleTypes = ["Query"]
        
        public static let selections: [GraphQLSelection] = [
            GraphQLField("getAllDestinations", type: .list(.object(Destination.selections)))
        ]
        
        public var snapshot: Snapshot
        
        public init(snapshot: Snapshot) {
            self.snapshot = snapshot
        }
        
        public init(getAllDestinations: [Destination]? = nil) {
            self.init(snapshot: ["__typename": "Query", "getAllDestinations": getAllDestinations.flatMap { $0.map { $0.snapshot } }])
        }
    }
    
    public struct Destination: GraphQLSelectionSet {
        public static let possibleTypes = ["Destination"]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
            self.snapshot = snapshot
        }
        
        public init(id: GraphQLID? = nil, city: String? = nil)  {
            self.init(snapshot: ["id": id, "city": city])
        }

        public static let selections: [GraphQLSelection] = [
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("city", type: .nonNull(.scalar(String.self))),
        ]
    }
}


