Item {
	anchors.fill: context;

	VoiceRecognition { id: voiceRecognition; }

	Text {
		id: recognizedText;
		width: 100%;
		anchors.bottom: voiceButton.top;
		anchors.bottomMargin: 20;
		horizontalAlignment: Text.AlignHCenter;
		font.pixelSize: 32;
		color: "#000";
	}

	WebItem {
		id: voiceButton;
		width: 200;
		height: 200;
		anchors.centerIn: parent;
		radius: width / 2;
		color: "#ccc";
		border.width: voiceRecognition.busy ? 4 : 0;
		border.color: "red";
		border.type: Border.Outer;

		Image {
			width: 80%;
			height: 80%;
			anchors.centerIn: parent;
			source: "res/voice.png";
		}

		onClicked: {
			voiceRecognition.startListening(function(result) {
				recognizedText.text = result && result.length > 0 ? result[0] : "Failed to recognized"
			})
		}
	}
}
