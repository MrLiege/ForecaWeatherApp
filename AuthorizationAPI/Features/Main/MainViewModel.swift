//
//  MainViewModel.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 08.08.2024.
//

import Foundation
import Combine
import CombineExt

final class MainViewModel: ObservableObject {
    let input: Input
    
    private var authService = AuthAPIService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.input = Input()
        bind()
    }
}


private extension MainViewModel {
    func bind() {
        //MARK: - request Token
        let requestToken = input.onAppear.first()
            .filter { UserStorage.shared.token == nil}
            .map { [unowned self] in
                self.authService.postToken()
                    .materialize()
            }
            .switchToLatest()
            .share()
        
        requestToken.failures()
            .sink { error in
                print(error)
            }
            .store(in: &cancellables)
        
        requestToken.values()
            .sink { value in
                UserStorage.shared.token = value.accessToken
            }
            .store(in: &cancellables)
    }
}

extension MainViewModel {
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
    }
}
