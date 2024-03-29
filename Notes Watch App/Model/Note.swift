//
//  Note.swift
//  Notes Watch App
//
//  Created by Shazeen Thowfeek on 28/03/2024.
//

import Foundation

struct Note: Identifiable,Codable{
    let id: UUID
    let text: String
}
