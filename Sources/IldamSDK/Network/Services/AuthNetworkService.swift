//
//  AuthNetworkService.swift
//  Ildam
//
//  Created by applebro on 09/12/23.
//

// AuthService.swift
import Foundation
import Core

public protocol AuthServiceProtocol: Sendable {
    func sendOTP(username: String) async throws -> OTPResponse?
    func validate(username: String, code: String) async -> ValidationResponse?
    func getUserInfo() async -> UserInfoResponse?
    func updateProfile(request: ProfileUpdateRequest) async -> Bool
    func logout() async -> Bool
    func register(request: RegistrationRequest) async -> Bool?
    func changeAvatar(profileAvatar: Data) async -> (success: Bool, result: AvatarResponse?)
}

public final class AuthService: AuthServiceProtocol, @unchecked Sendable {
    public static let shared: AuthServiceProtocol = AuthService()
    
    private let sendOTPUseCase: SendOTPUseCaseProtocol
    private let validateOTPUseCase: ValidateOTPUseCaseProtocol
    private let getMeInfoUseCase: GetMeInfoUseCaseProtocol
    private let updateProfileUseCase: UpdateProfileUseCaseProtocol
    private let logoutUseCase: LogoutUseCaseProtocol
    private let registerUseCase: RegisterUseCaseProtocol
    private let changeAvatarUseCase: ChangeAvatarUseCaseProtocol
    
    public init(
        sendOTPUseCase: SendOTPUseCaseProtocol = SendOTPUseCase(),
        validateOTPUseCase: ValidateOTPUseCaseProtocol = ValidateOTPUseCase(),
        getMeInfoUseCase: GetMeInfoUseCaseProtocol = GetMeInfoUseCase(),
        updateProfileUseCase: UpdateProfileUseCaseProtocol = UpdateProfileUseCase(),
        logoutUseCase: LogoutUseCaseProtocol = LogoutUseCase(),
        registerUseCase: RegisterUseCaseProtocol = RegisterUseCase(),
        changeAvatarUseCase: ChangeAvatarUseCaseProtocol = ChangeAvatarUseCase()
    ) {
        self.sendOTPUseCase = sendOTPUseCase
        self.validateOTPUseCase = validateOTPUseCase
        self.getMeInfoUseCase = getMeInfoUseCase
        self.updateProfileUseCase = updateProfileUseCase
        self.logoutUseCase = logoutUseCase
        self.registerUseCase = registerUseCase
        self.changeAvatarUseCase = changeAvatarUseCase
    }
    
    public func sendOTP(username: String) async throws -> OTPResponse? {
        return try await sendOTPUseCase.execute(username: username)
    }
    
    public func validate(username: String, code: String) async -> ValidationResponse? {
        return await validateOTPUseCase.execute(username: username, code: code)
    }
    
    public func getUserInfo() async -> UserInfoResponse? {
        return await getMeInfoUseCase.execute()
    }
    
    public func updateProfile(request: ProfileUpdateRequest) async -> Bool {
        return await updateProfileUseCase.execute(request: request)
    }
    
    public func logout() async -> Bool {
        return await logoutUseCase.execute()
    }
    
    public func register(request: RegistrationRequest) async -> Bool? {
        return await registerUseCase.execute(request: request)
    }
    
    public func changeAvatar(profileAvatar: Data) async -> (success: Bool, result: AvatarResponse?) {
        return await changeAvatarUseCase.execute(profileAvatar: profileAvatar)
    }
}
