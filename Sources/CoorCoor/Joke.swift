import AWSLambdaRuntime
import AWSLambdaEvents
import AsyncHTTPClient
import Foundation
import NIO

struct Joke: EventLoopLambdaHandler {
    typealias In = APIGateway.V2.Request
    typealias Out = APIGateway.V2.Response

    private let url: URL
    private let httpClient: HTTPClient

    init(host: String, eventLoop: EventLoop) {
        url = URL(string: host)!
        httpClient = HTTPClient(eventLoopGroupProvider: .shared(eventLoop))
    }

    // MARK: - EventLoopLambdaHandler

    func handle(context: Lambda.Context, event: APIGateway.V2.Request) -> EventLoopFuture<APIGateway.V2.Response> {
        do {
            let request = try HTTPClient.Request(
                url: url,
                method: .GET,
                headers: ["Accept": "application/json"])

            return httpClient.execute(request: request, deadline: .now() + .seconds(10)).map { response in
                APIGateway.V2.Response(
                    statusCode: HTTPResponseStatus(code: response.status.code),
                    headers: [String: String](uniqueKeysWithValues: response.headers.map { $0 }),
                    body: response.body.flatMap { String(bytes: $0.readableBytesView, encoding: .utf8) })
            }
        } catch {
            return context.eventLoop.makeFailedFuture(error)
        }
    }

    func shutdown(context: Lambda.ShutdownContext) -> EventLoopFuture<Void> {
        try? httpClient.syncShutdown()
        return context.eventLoop.makeSucceededFuture(())
    }
}
