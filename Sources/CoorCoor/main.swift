import AWSLambdaRuntime

Lambda.run { (context: Lambda.InitializationContext) -> Lambda.Handler in
    Joke(host: "https://icanhazdadjoke.com", eventLoop: context.eventLoop)
}
