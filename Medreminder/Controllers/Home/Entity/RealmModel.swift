//
//  RealmModel.swift
//  Medreminder
//
//  Created by MacOS on 15/08/2023.
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
