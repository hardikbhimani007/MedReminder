//
//  Database.swift
//  Medreminder
//
//  Created by MacOS on 31/07/2023.
//

import Foundation
import RealmSwift

// MARK: - Realm data stroe structure
class MedicineDetalis: Object {
    @Persisted var medicineName: String?
    @Persisted var medicineType: String?
    @Persisted var firstDose: String?
    @Persisted var hr: Int?
    @Persisted var min: Int?
    @Persisted var sec: Int?
}

// MARK: - Data transfer
struct MedDetalis: Codable {
    var medName: String
    var medType: String
    var firstDose: String
    var hr: Int
    var min: Int
    var sec: Int
}

// MARK: - Get data from Realm
struct GetData: Codable {
    var medName: String?
    var medType: String?
    var firstDose: String?
    var hr: String?
    var index: Int?
    
    init(medName: String, medType: String, firstDose: String, hr: String, index: Int?) {
        self.medName = medName
        self.medType = medType
        self.firstDose = firstDose
        self.hr = hr
        self.index = index
    }
    
    init() {}
}
