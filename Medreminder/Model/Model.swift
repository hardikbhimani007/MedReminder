//
//  Model.swift
//  Medreminder
//
//  Created by MacOS on 28/07/2023.
//

import Foundation

// MARK: - passing Data
struct Medicine: Codable {
    var medicineName: String?

    init(medicineName: String) {
        self.medicineName = medicineName
    }

    init() {}
}

// MARK: - Medicine Name & Strength
struct medicineType {
    var nameAndStrength: String
}

// MARK: - Medicine NAme using API
struct MedicineName: Codable {
    let term: String
}

struct MedicineResponse: Codable {
    let results: [MedicineName]
}

// MARK: - Scheduling
struct MedicineSchedul {
    var time: String
}
