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
    if CommandLine.argc == 3{
        inputString = CommandLine.arguments[1]
        location = CommandLine.arguments[2]
    }
    else{
        return .failure(.wrongArguments)
    }
    let path = URL(fileURLWithPath: location)
    guard let fileContent = try? String(contentsOf: path) else{
        return .failure(.automataDecodingError)
    }
    let data = fileContent.data(using: .utf8)!
    let automata: FiniteAutomata
    do{
        automata = try JSONDecoder().decode(FiniteAutomata.self, from: data)
        try automata.isUndefinedErrors()
        
    } catch FiniteAutomataError.UndefinedStatesError{
        return .failure(.undefinedStateInAutomata)
    } catch FiniteAutomataError.UndefinedSymbolsError{
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
