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
    
    public func undeterministicErrors() throws {
        var transitionSymbols: [String] = []
        var symbolCount: Int = 0
        for state in states{
            for transition in transitions{
                if(state == transition.from){
                    transitionSymbols.insert(transition.with, at: transitionSymbols.endIndex)
                }
            }
            if transitionSymbols.count > 1{
                for symbol in transitionSymbols{
                    transitionSymbols.forEach{ x in if x == symbol { symbolCount += 1}}
                    if(symbolCount > 1){
                        throw FiniteAutomataError.undeterministicAutomata
                    }
                    symbolCount = 0
                }
            }
            transitionSymbols.removeAll()
        }
    }
    
    public func undefinedErrors() throws  {
        for finalState in finalStates {
            if !states.contains(finalState) {
                throw FiniteAutomataError.undefinedStatesError
            }
        }
        for transition in transitions {
            if !states.contains(transition.from) ||
                !states.contains(transition.to) {
                throw FiniteAutomataError.undefinedStatesError
            }
            if !symbols.contains(transition.with){
                throw FiniteAutomataError.undefinedSymbolsError
            }
        }
        if !states.contains(initialState){
            throw FiniteAutomataError.undefinedStatesError
        }
    }
}

public enum FiniteAutomataError: Error {
    case undefinedStatesError
    case undefinedSymbolsError
    case undeterministicAutomata
}

public struct Transition: Decodable {
    public var with: String
    public var to: String
    public var from: String
}

extension FiniteAutomata: Decodable {

    
}
