import Foundation

enum URLStringBuilder {
    static func build(url: String, replacingParameters parameters: [String: String]) -> String {
        url.buildURLReplaced(parameters: parameters)
    }
}

private extension String {
    func replacingUrlParameter(_ parameter: String, with value: String) -> String {
        let placeholder = ":\(parameter)"
        return self.replacingOccurrences(of: placeholder, with: value)
    }
    
    func buildURLReplaced(parameters: [String: String]) -> String {
        var updatedURL = self
        for (key, value) in parameters {
            updatedURL = updatedURL.replacingUrlParameter(key, with: value)
        }
        return updatedURL
    }
}
