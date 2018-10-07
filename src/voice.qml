Item {
	anchors.fill: context;

	VoiceRecognition { id: voiceRecognition; }

	Text {
		id: recognizedText;
		width: 100%;
		anchors.bottom: voiceButton.top;
		horizontalAlignment: Text.AlignHCenter;
		font.pixelSize: 32;
		color: "#000";
	}

	WebItem {
		id: voiceButton;
		width: 200;
		height: 50;
		anchors.centerIn: parent;
		color: "red";

		onClicked: {
			voiceRecognition.startListening(function(result) {
				recognizedText.text = result && result.length > 0 ? result[0] : "Failed to recognized"
			})
		}
	}
}
