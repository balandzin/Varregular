//
//  Verb.swift
//  StudyingIrregularVerbs
//
//  Created by Антон Баландин on 7.03.24.
//

import Foundation

struct Verb {
    let infinitive: String
    let pastSimple: String
    let participle: String
    var translation: String {
        NSLocalizedString(self.infinitive, comment: "")
    }
}
