Object {

	setOptions(options): { this._options = options }

	startListening(callback): {
		var speechRecognition = window.plugins.speechRecognition
		var ctx = this._context
		speechRecognition.hasPermission(ctx.wrapNativeCallback(function() {
			log("I got permissin")
			speechRecognition.startListening(
				ctx.wrapNativeCallback(function(data) {
					log("Got recognized words", data)
					callback(data)
				}),
				ctx.wrapNativeCallback(function(err) {
					log("Failed to get recognized words", err)
					speechRecognition.requestPermission(
						ctx.wrapNativeCallback(function(req) { log("Request permission") }),
						ctx.wrapNativeCallback(function(err) { log("Failed to get permission", err) })
					)
				}), this._options
			)
		}), ctx.wrapNativeCallback(function() {
			log("No i don't")
			speechRecognition.requestPermission(
				ctx.wrapNativeCallback(function(req) { log("Request permission") }),
				ctx.wrapNativeCallback(function(err) { log("Failed to get permission", err) })
			)
		}))
	}

	onCompleted: {
		this._options = {
			language: "ru-RU",
			matches: 10,
			showPopup: false,
			showPartial: false
		}
	}
}
