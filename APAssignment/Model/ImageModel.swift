//
//  ImageModel.swift
//  APAssignment
//
//  Created by Amit Arya iOS Dev on 17/12/25.
//
struct ImageModel: Decodable{
    var id: String
    var thumbnail: Thumbnail
    var imageUrl: String{
        get{ return thumbnail.domain + "/" + thumbnail.basePath + "/0/" + thumbnail.key}
    }
}

struct Thumbnail: Decodable{
    var domain: String
    var basePath: String
    var key: String
}
