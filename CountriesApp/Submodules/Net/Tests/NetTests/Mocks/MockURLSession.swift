import Net
import Foundation

class MockDataTask: URLSessionTaskProtocol {
    
    var isCancelCalled = false
    var isResumeCalled = false

    func resume() {
        isResumeCalled = true
    }

    func cancel() {
        isCancelCalled = true
    }
}

struct MockURLSession: URLSessionProtocol {

    var output: DataTaskOutput?

    init(output: DataTaskOutput? = nil) {
        self.output = output
    }

    func dataTask(
        with urlRequest: URLRequest,
        completion: @escaping DataTaskCompletion
    ) -> URLSessionTaskProtocol {
        if let output = output {
            completion(
                output.0,
                output.1,
                output.2
            )
        }

        return MockDataTask()
    }
}
