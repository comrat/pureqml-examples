Object {

	setOptions(options): { this._options = options }

	startListening(callback): {
		var speechRecognition = window.plugins.speechRecognition
		var ctx = this._context
		speechRecognition.hasPermission(function() {
			log("I got permissin")
			speechRecognition.startListening(
				function(data) {
					ctx._processActions()
				}, function(err) {
					log("Err", err)
					speechRecognition.requestPermission(
						function(req) { log("Request permission") },
						function(err) { log("Failed to get permission", err) })
					)
					ctx._processActions()
				}, this._options
			)
			ctx._processActions()
		}, function() {
			log("No i don't")
			speechRecognition.requestPermission(
				function(req) { log("Request permission") },
				function(err) { log("Failed to get permission", err) })
			ctx._processActions()
		})
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
