//
//  main.swift
//  proj1
//
//  Created by Filip Klembara on 17/02/2020.
//

import Foundation
import FiniteAutomata
import Simulator

// MARK: - Main
func main() -> Result<Int, RunError> {
    // *******************
    // * NOT IMPLEMENTED *
    // *******************
    let location: String
    let inputString: String
    let automata: FiniteAutomata
    if CommandLine.argc == 3{
        inputString = CommandLine.arguments[1]
        location = CommandLine.arguments[2]
    }
    else{
        return .failure(.wrongArguments)
    }
    let path = URL(fileURLWithPath: location)
    guard let fileContent = try? String(contentsOf: path) else{
        return .failure(.fileWorkError)
    }
    let data = fileContent.data(using: .utf8)!
    do{
        automata = try JSONDecoder().decode(FiniteAutomata.self, from: data)
        try automata.undefinedErrors()
        try automata.undeterministicErrors()
    } catch FiniteAutomataError.undeterministicAutomata{
        return .failure(.undeterministicAutomata)
    } catch FiniteAutomataError.undefinedStatesError{
        return .failure(.undefinedStateInAutomata)
    } catch FiniteAutomataError.undefinedSymbolsError{
        return .failure(.undefinedSymbolInAutomata)
    } catch{
        return .failure(.automataDecodingError)
    }
    let sim = Simulator(finiteAutomata: automata)
    let result = sim.simulate(on: inputString)
    if result == []{
        return .failure(.stringNotAccepted)
    }
    result.forEach{ print($0) }
    return .success(0)
}

// MARK: - program body
let result = main()

switch result {
case .success:
    break
case .failure(let error):
    var stderr = STDERRStream()
    print("Error:", error.description, to: &stderr)
    exit(Int32(error.code))
}
