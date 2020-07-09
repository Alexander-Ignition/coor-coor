import AWSLambdaRuntime

Lambda.run { (context, string: String, callback) in
    callback(.success("It works! \(string) ?"))
}
