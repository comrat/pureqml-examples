Object {
	property bool busy;
	property bool available;

	setOptions(options): { this._options = options }

	startListening(callback): {
		this.busy = true
		var speechRecognition = window.plugins.speechRecognition
		var ctx = this._context
		var self = this
		speechRecognition.hasPermission(ctx.wrapNativeCallback(function() {
			log("I got permissin", self._options)
			speechRecognition.startListening(
				ctx.wrapNativeCallback(function(data) {
					log("Got recognized words", data)
					self.busy = false
					callback(data)
				}),
				ctx.wrapNativeCallback(function(err) {
					log("Failed to get recognized words", err)
					speechRecognition.requestPermission(
						ctx.wrapNativeCallback(function(req) { log("Request permission", req); self.busy = false }),
						ctx.wrapNativeCallback(function(err) { log("Failed to get permission", err); self.busy = false })
					)
					self.busy = false
				}),
				self._options
			)
		}), ctx.wrapNativeCallback(function() {
			log("No i don't")
			speechRecognition.requestPermission(
				ctx.wrapNativeCallback(function(req) { log("Request permission, req"); self.busy = false }),
				ctx.wrapNativeCallback(function(err) { log("Failed to get permission", err); self.busy = false })
			)
			self.busy = false
		}))
	}

	onCompleted: {
		this._options = {
			language: "ru-RU",
			matches: 10,
			showPopup: true,
			showPartial: false
		}

		var self = this
		window.plugins.speechRecognition.isRecognitionAvailable(function(res) { self.available = res }, function(e) {log("GetAvailable flag error",e)})
	}
}
