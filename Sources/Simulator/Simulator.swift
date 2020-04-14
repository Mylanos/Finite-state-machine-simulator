//
//  Simulator.swift
//  Simulator
//
//  Created by Filip Klembara on 17/02/2020.
//

import FiniteAutomata
/// Simulator
public struct Simulator {
    /// Finite automata used in simulations
    private let finiteAutomata: FiniteAutomata

    /// Initialize simulator with given automata
    /// - Parameter finiteAutomata: finite automata
    public init(finiteAutomata: FiniteAutomata) {
        self.finiteAutomata = finiteAutomata
    }

    private func getNextState(actualSymbol: String, actualState: String) -> String {
        var nextState: String = ""
        for transition in finiteAutomata.transitions {
            if transition.from == actualState && transition.with == actualSymbol {
                nextState = transition.to
            }
        }
        return nextState
    }

    /// Simulate automata on given string
    /// - Parameter string: string with symbols separated by ','
    /// - Returns: Empty array if given string is not accepted by automata,
    ///     otherwise array of states
    public func simulate(on string: String) -> [String] {
        // checkUndefinedErrors()
        let stringSymbols = string.split(separator: ",")
        var currentState = finiteAutomata.initialState
        let finalStates = finiteAutomata.finalStates
        var accepted: [String] = [finiteAutomata.initialState]
        for actualSymbol in stringSymbols {
            let nextState = getNextState(actualSymbol: String(actualSymbol), actualState: currentState)
            if !nextState.isEmpty{
                currentState = nextState
                accepted.insert(currentState, at: accepted.endIndex)
            }
            else{
                return []
            }
        }
        if finalStates.contains(currentState) {
            return accepted
        }
        return []
    }
}

