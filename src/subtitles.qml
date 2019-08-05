Rectangle {
	anchors.fill: context;
	color: "#0000";

	VideoPlayer {
		id: player;
		width: 100%;
		height: 100%;
		source: "http://www.storiesinflight.com/js_videosub/jellies.mp4";
		autoPlay: true;
		loop: true;
	}

	Subtitles {
		id: subtitles;
		url: "http://www.storiesinflight.com/js_videosub/jellies.srt";
		progress: player.progress;
	}

	Rectangle {
		anchors.fill: subtitlesText;
		anchors.margins: -10;
		visible: subtitlesText.text;
		radius: 5;
		color: "#0008";

		Behavior on transform { Animation { duration: 300; } }
	}

	Text {
		id: subtitlesText;
		anchors.bottom: parent.bottom;
		anchors.horizontalCenter: parent.horizontalCenter;
		anchors.bottomMargin: 40;
		color: "#fff";
		font.pixelSize: 36;
		font.bold: true;
		horizontalAlignment: Text.AlignHCenter;
		text: subtitles.text;
		visible: text;

		Behavior on transform { Animation { duration: 300; } }
	}
}
