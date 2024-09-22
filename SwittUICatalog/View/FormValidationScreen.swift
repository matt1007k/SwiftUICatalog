//
//  FormValidationScreen.swift
//  SwittUICatalog
//
//  Created by Max Meza on 9/12/24.
//

import SwiftUI
import Combine

struct FormValidationScreen: View {
    
    enum FocusableField: Hashable {
        case firstName
        case email
        case emailConfirmation
        case phone
    }
    
    
    @StateObject var viewModel = FormValidationViewModel()
    @FocusState private var focus: FocusableField?
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                TextInputField("FirstName", text: $viewModel.firstName, isValid:  $viewModel.isFirstName)
                    .focused($focus, equals: .firstName)
                    .isMandatory()
                    .onSubmit {
                        self.focus = .email
                    }
                    .autocapitalization(.none)
        
                TextInputField("Email", text:  $viewModel.email, isValid:  $viewModel.isEmailValid)
                    .focused($focus, equals: .email)
                    .keyboardType(.emailAddress)
                    .isMandatory()
                    .onValidate { value in
                        value.isEmail()
                        ? .success(true)
                        : .failure(.init(message: "\(value.description) is not a valid email address"))
                    }
                    .onSubmit {
                        self.focus = .phone
                    }
                    .autocapitalization(.none)
                
                TextInputField("Email confirmation", text:  $viewModel.emailConfirmation, isValid:  $viewModel.isEmailConfirmationValid)
                    .focused($focus, equals: .emailConfirmation)
                    .keyboardType(.emailAddress)
                    .isMandatory()
                    .onValidate { value in
                        value.isEmail()
                        ? .success(true)
                        : .failure(.init(message: "\(value.description) is not a valid email address"))
    
                    }
                    .onSubmit {
                        self.focus = .phone
                    }
                    .autocapitalization(.none)
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .font(.footnote)
                        .foregroundStyle(.red)
                }
                
                TextInputField("Phone", text:  $viewModel.phone, isValid:  $viewModel.isPhone)
                    .focused($focus, equals: .phone)
                    .keyboardType(.phonePad)
                    .isMandatory()
                    .autocapitalization(.none)
            }
          
            Button("Submit") {
              viewModel.presentSuccessMessage.toggle()
               print("Submit")
            }
            .buttonStyle(.bordered)
            .frame(maxWidth: .infinity)
            .disabled(!viewModel.isFormValid)
            
            
        }
        .padding()
        .background(Color.white)
        .alert("Success", isPresented: $viewModel.presentSuccessMessage) {
              Button("OK") { }
            } message: {
              Text("You entered: \(viewModel.email)")
            }
        
    }
    
}

#Preview {
    FormValidationScreen()
}

extension String {
    func isEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
}

struct TextInputField: View {
    private var title: String
    @Binding private var text: String
    
    @Environment(\.isMandatory) var isMandatory
    @Environment(\.validationHandler) var validationHandler
    
    @Binding private var isValidBinding: Bool
    @State private var isValid: Bool = true {
        didSet {
            isValidBinding = isValid
        }
    }
    @State var validationMessage: String = ""
    
    init(_ title: String, text: Binding<String>, isValid isValidBinding: Binding<Bool>? = nil) {
        self.title = title
        self._text = text
        self._isValidBinding = isValidBinding ?? .constant(true)
    }
    
    fileprivate func validate(_ value: String) {
        isValid = true
        if isMandatory {
            isValid = value.count > 1
            validationMessage = isValid ? "" : "This is a mandatory field"
        }
        if isValid {
            guard let validationHandler = self.validationHandler else { return }
            let validationResult = validationHandler(value)
            if case .failure(let error) = validationResult {
                isValid = false
                self.validationMessage = "\(error.localizedDescription)"
            }
            else if case .success(let isValid) = validationResult {
                self.isValid = isValid
                self.validationMessage = ""
            }
        }
    }
    
    var body: some View {
        

            VStack(alignment: .leading) {
                ZStack(alignment: .leading) {
                    
                    if (!text.isEmpty || !isValid) {
                            Text(title)
                            .padding()
                              .foregroundColor(text.isEmpty ? Color(.placeholderText) : .accentColor)
                              .offset(y: text.isEmpty ? 0 : -25)
                              .scaleEffect(text.isEmpty ? 1 : 0.8, anchor: .leading)
                    }
                    
                    TextField("", text: $text)
                        .padding()
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .background {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(text.isEmpty || isValid ? Color(.placeholderText) : .accentColor, lineWidth: 1)
                                .foregroundStyle(text.isEmpty || isValid ? Color(.placeholderText) : .accentColor)
                            
                        }
                        .onAppear {
                            validate(text)
                        }
                        .onChange(of: text) { value in
                            validate(value)
                        }
                      
            }
            
            if !isValid {
                HStack {
                    Text(validationMessage)
                        .foregroundStyle(.red)
                        .font(.footnote)
//                        .scaleEffect(0.8, anchor: .leading)
                }
            }
        }
        .padding(.top, 15)
        .animation(.default, value: text)
        
    }
}

extension View {
    func isMandatory(_ value: Bool = true) -> some View {
        environment(\.isMandatory, value)
    }
}

public struct ValidationError: Error {
  public init(message: String) {
    self.message = message
  }
  let message: String
}

extension ValidationError: LocalizedError {
  public var errorDescription: String? {
    return NSLocalizedString("\(message)", comment: "Message for generic validation errors.")
  }
}

private struct TextInputFieldMandatory: EnvironmentKey {
    static var defaultValue: Bool = false
}

private struct TextInputFieldValidationHandler: EnvironmentKey {
    static var defaultValue: ((String) -> Result<Bool, ValidationError>)?
}

extension EnvironmentValues {
    var isMandatory: Bool {
        get { self[TextInputFieldMandatory.self] }
        set { self[TextInputFieldMandatory.self] = newValue}
    }
    var validationHandler: ((String) -> Result<Bool, ValidationError>)? {
        get { self[TextInputFieldValidationHandler.self] }
        set { self[TextInputFieldValidationHandler.self] = newValue }
    }
}

extension View {
    func onValidate(validationHandler: @escaping (String) -> Result<Bool, ValidationError>) -> some View {
        environment(\.validationHandler, validationHandler)
    }
}



class FormValidationViewModel: ObservableObject {
    @Published var firstName = ""
    @Published var email = ""
    @Published var phone = ""
    
    @Published var emailConfirmation = ""
      
    @Published var isFirstName = false
    @Published var isEmailValid = false
    @Published var isEmailConfirmationValid = false
    @Published var isPhone = false
      
    @Published var errorMessage = ""
    @Published var isInternalFormValid = false
    @Published var presentSuccessMessage = false
    @Published var isFormValid = false
    
    init() {
        let emailsMatchPublisher =
           Publishers.CombineLatest($email, $emailConfirmation)
             .map { $0 == $1 }
             .share()
        emailsMatchPublisher
              .map { $0 ? "" : "Emails don't match" }
              .assign(to: &$errorMessage)
        emailsMatchPublisher
             .combineLatest($isEmailValid, $isEmailConfirmationValid)
             .map { $0 && $1 && $2 }
             .assign(to: &$isInternalFormValid)
        
        let allPublishers = [$isFirstName, $isEmailValid, $isEmailConfirmationValid, $isInternalFormValid, $isPhone]
            Publishers
                .MergeMany(allPublishers)
                .allSatisfy { $0 }
                .assign(to: &$isFormValid)
    }
    
    
}
