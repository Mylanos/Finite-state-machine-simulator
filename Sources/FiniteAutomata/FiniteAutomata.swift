//
//  FiniteAutomata.swift
//  FiniteAutomata
//
//  Created by Filip Klembara on 17/02/2020.
//
import Foundation
/// Finite automata

public struct FiniteAutomata {
    public var states: [String]
    public var symbols: [String]
    public var initialState: String
    public var transitions: [Transition]
    public var finalStates: [String]


    init(states: [String], symbols: [String], initialState: String, finalStates: [String], transitions: [Transition]) {
        self.states = states
        self.symbols = symbols
        self.transitions = transitions
        self.initialState = initialState
        self.finalStates = finalStates
    }
    
    public func isUndefinedErrors() throws  {
        for finalState in finalStates {
            if !states.contains(finalState) {
                throw FiniteAutomataError.UndefinedStatesError
            }
        }
        for transition in transitions {
            if !states.contains(transition.from) ||
                !states.contains(transition.to) {
                throw FiniteAutomataError.UndefinedStatesError
            }
            if !symbols.contains(transition.with){
                throw FiniteAutomataError.UndefinedSymbolsError
            }
        }
        if !states.contains(initialState){
            throw FiniteAutomataError.UndefinedStatesError
        }
    }
}

public enum FiniteAutomataError: Error {
    case UndefinedStatesError
    case UndefinedSymbolsError
}

struct FiniteAutomataRaw: Decodable {
    var states: [String]
    var symbols: [String]
    var initialState: String
    var transitions: [Transition]
    var finalStates: [String]
}

public struct Transition: Decodable {
    public var with: String
    public var to: String
    public var from: String
}

extension FiniteAutomata: Decodable {

    public init(from decoder: Decoder) throws {
        let finiteAutomata = try FiniteAutomataRaw(from: decoder)
        let states = finiteAutomata.states
        let symbols = finiteAutomata.symbols
        let transitions = finiteAutomata.transitions
        let initialState = finiteAutomata.initialState
        let finalStates = finiteAutomata.finalStates


        self.init(states: states, symbols: symbols, initialState: initialState, finalStates: finalStates, transitions: transitions) // initializing our struct
    }
}
