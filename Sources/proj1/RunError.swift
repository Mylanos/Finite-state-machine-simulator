//
//  RunError.swift
//  proj1
//
//  Created by Filip Klembara on 17/02/2020.
//

public enum RunError: Error {
    // *******************
    // * NOT IMPLEMENTED *
    // *******************
    case stringNotAccepted
    case wrongArguments
    case fileWorkError
    case automataDecodingError
    case undefinedStateInAutomata
    case undefinedSymbolInAutomata
    case undeterministicAutomata
    case otherError
}

// MARK: - Return codes
extension RunError {
    var code: Int {
        switch self {
        case .stringNotAccepted:
            return 6;
        case .wrongArguments:
            return 11;
        case .fileWorkError:
            return 12;
        case .automataDecodingError:
            return 20;
        case .undefinedStateInAutomata:
            return 21;
        case .undefinedSymbolInAutomata:
            return 22;
        case .undeterministicAutomata:
            return 23;
        case .otherError:
            return 99;
        }
    }
}

// MARK:- Description of error
extension RunError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .stringNotAccepted:
            return "String was not accepted by the automata!"
        case .wrongArguments:
            return "Passed arguments were incorrect!"
        case .fileWorkError:
            return "File work error!"
        case .automataDecodingError:
            return "There was an error while decoding Automata!"
        case .undefinedStateInAutomata:
            return "Undefined state in automata!"
        case .undefinedSymbolInAutomata:
            return "Undefined symbol in automata!"
        case .undeterministicAutomata:
            return "Undeterministic automata!"
        case .otherError:
            return "Some other error appeared!"
        }
    }
}
