Object {
	property bool busy;

	setOptions(options): { this._options = options }

	startListening(callback): {
		this.busy = true
		var speechRecognition = window.plugins.speechRecognition
		var ctx = this._context
		var self = this
		speechRecognition.hasPermission(ctx.wrapNativeCallback(function() {
			log("I got permissin")
			speechRecognition.startListening(
				ctx.wrapNativeCallback(function(data) {
					log("Got recognized words", data)
					self.busy = false
					callback(data)
				}),
				ctx.wrapNativeCallback(function(err) {
					log("Failed to get recognized words", err)
					speechRecognition.requestPermission(
						ctx.wrapNativeCallback(function(req) { log("Request permission"); self.busy = false }),
						ctx.wrapNativeCallback(function(err) { log("Failed to get permission", err); self.busy = false })
					)
					self.busy = false
				}), this._options
			)
		}), ctx.wrapNativeCallback(function() {
			log("No i don't")
			speechRecognition.requestPermission(
				ctx.wrapNativeCallback(function(req) { log("Request permission"); self.busy = false }),
				ctx.wrapNativeCallback(function(err) { log("Failed to get permission", err); self.busy = false })
			)
			self.busy = false
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
