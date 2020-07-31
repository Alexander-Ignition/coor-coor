import AWSLambdaRuntime
import AWSLambdaEvents

typealias Completion = (Result<APIGateway.V2.Response, Error>) -> Void

Lambda.run { (_, request: APIGateway.V2.Request, completion: @escaping Completion) in
    let http = request.context.http
    let body = "\(http.method) \(http.path) Hello!"
    let response = APIGateway.V2.Response(statusCode: .ok, body: body)
    completion(.success(response))
}
