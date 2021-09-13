//
//  AthleteViewModel.swift
//  KitmanApp
//
//  Created by Fabio Dantas on 13/09/2021.
//

import Foundation

protocol AthleteViewModelDelegate: AnyObject {
    func onAthletesArrived(athletes: [Athlete])
    func onFetchFailed()
}

class AthleteViewModel: NSObject {
    
    weak var delegate: AthleteViewModelDelegate?
    
    private var squads = [Squad]()
    
    override init() {
        super.init()
    }
    
    func bootstrap() {
        
        fetchAthletes { [weak self] athletes, error in
            if let athletes = athletes {
                self?.fetchSquads { squads, error in
                    if let squads = squads {
                        self?.squads = squads
                        self?.delegate?.onAthletesArrived(athletes: athletes)
                    } else {
                        self?.delegate?.onFetchFailed()
                    }
                }
            } else {
                self?.delegate?.onFetchFailed()
            }
        }
    }
    
    private func fetchAthletes(completion: @escaping (_ result: [Athlete]?, _ error: Error?) -> Void) {
        guard let url = URL(string: API.shared.getAthletes) else {
            print("Unable to get a valid  Athletes endpoint")
            return
        }
        NetworkManager.get(url: url) { result in
            switch result {
            case .failure(let error):
                print("Login Failed. Error: \(error.localizedDescription)")
                completion(nil, error)
            case .success(let data):
                JsonParser.parseData(data) { (result: ParseResult<AthletesResult>) in
                    switch result {
                    case .failure(let error):
                        print("JSON Parsing failed: \(error)")
                        completion(nil, error)
                    case .success(let result):
                        completion(result.athletes, nil)
                    }
                }
            }
        }
    }
    
    private func fetchSquads(completion: @escaping (_ result: [Squad]?, _ error: Error?) -> Void) {
        guard let url = URL(string: API.shared.getSquads) else {
            print("Unable to get a valid  Athletes endpoint")
            return
        }
        NetworkManager.get(url: url) { result in
            switch result {
            case .failure(let error):
                print("Login Failed. Error: \(error.localizedDescription)")
                completion(nil, error)
            case .success(let data):
                JsonParser.parseData(data) { (result: ParseResult<SquadResult>) in
                    switch result {
                    case .failure(let error):
                        print("JSON Parsing failed: \(error)")
                        completion(nil, error)
                    case .success(let result):
                        completion(result.squads, nil)
                    }
                }
            }
        }
    }
    
    func getSquadsNamesForAthlete(ids: [Int]) -> [String] {
        
        var dic  = [Int:Bool]()
        var squadsArray = [String]()
        
        for id in ids {
            dic[id] = true
        }
        
        for squad in squads {
            if dic[squad.id] != nil {
                squadsArray.append(squad.name)
            }
        }
        return squadsArray
    }
}
