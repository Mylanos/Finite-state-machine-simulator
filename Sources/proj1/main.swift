//
//  main.swift
//  proj1
//
//  Created by Filip Klembara on 17/02/2020.
//

import Foundation

// MARK: - Main
func main() -> Result<Void, RunError> {
    // *******************
    // * NOT IMPLEMENTED *
    // *******************
    return .failure(.stringNotAccepted)
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
