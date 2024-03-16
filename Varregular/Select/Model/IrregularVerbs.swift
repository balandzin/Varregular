//
//  IrregularVerbs.swift
//  StudyingIrregularVerbs
//
//  Created by Антон Баландин on 7.03.24.
//

import Foundation

class IrregularVerbs {
    
    // MARK: - Singleton
    static var shared = IrregularVerbs()
    private init() {
        configureVerbs()
    }
    
    // MARK: - Properties
    var selectedVerbs: [Verb] = []
    private(set) var verbs: [Verb] = []
    
    // MARK: - Methods
    private func configureVerbs() {
        verbs = [
            Verb(infinitive: "be", pastSimple: "was", participle: "been"),
            Verb(infinitive: "do", pastSimple: "did", participle: "done"),
            Verb(infinitive: "go", pastSimple: "went", participle: "gone"),
            Verb(infinitive: "have", pastSimple: "had", participle: "had"),
            Verb(infinitive: "want", pastSimple: "wanted", participle: "wanted"),
            Verb(infinitive: "write", pastSimple: "wrote", participle: "written"),
            Verb(infinitive: "come", pastSimple: "came", participle: "come"),
            Verb(infinitive: "feel", pastSimple: "felt", participle: "felt"),
            Verb(infinitive: "get", pastSimple: "got", participle: "got"),
            Verb(infinitive: "know", pastSimple: "knew", participle: "known"),
            Verb(infinitive: "see", pastSimple: "saw", participle: "seen"),
            Verb(infinitive: "think", pastSimple: "thought", participle: "thought"),
            Verb(infinitive: "try", pastSimple: "tried", participle: "tried"),
            Verb(infinitive: "use", pastSimple: "used", participle: "used"),
            Verb(infinitive: "say", pastSimple: "said", participle: "said"),
            Verb(infinitive: "make", pastSimple: "made", participle: "made"),
            Verb(infinitive: "take", pastSimple: "took", participle: "taken"),
            Verb(infinitive: "get", pastSimple: "got", participle: "got"),
            Verb(infinitive: "know", pastSimple: "knew", participle: "known")
        ]
    }
}
