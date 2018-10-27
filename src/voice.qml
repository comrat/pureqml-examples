Item {
	anchors.fill: context;

	VoiceRecognition { id: voiceRecognition; }

	Text {
		id: recognizedText;
		x: 5%;
		width: 90%;
		anchors.bottom: voiceButton.top;
		anchors.bottomMargin: 20;
		horizontalAlignment: Text.AlignHCenter;
		wrapMode: Text.WordWrap;
		font.pixelSize: 32;
		text: voiceRecognition.available ? "Voice Recognition is not available pn this device" : "";
		color: "#000";
	}

	WebItem {
		id: voiceButton;
		property bool enabled;
		width: 200;
		height: 200;
		anchors.centerIn: parent;
		radius: width / 2;
		color: "#ccc";
		border.width: voiceRecognition.busy ? 4 : 0;
		border.color: "red";
		border.type: Border.Outer;
		enabled: voiceRecognition.available;
		opacity: enabled ? 1.0 : 0.5;

		Image {
			width: 80%;
			height: 80%;
			anchors.centerIn: parent;
			source: "res/voice.png";
		}

		onClicked: {
			if (!this.enabled) {
				log("Voice recognition isn't available on this device")
				return
			}
			voiceRecognition.startListening(function(result) {
				recognizedText.text = result && result.length > 0 ? result[0] : "Failed to recognized"
			})
		}
	}
}
