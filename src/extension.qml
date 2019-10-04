Rectangle {
	anchors.fill: context;
	color: "#fff";

	Resource {
		url: "https://blockchain.info/ticker";

		onDataChanged: {
			var response = JSON.parse(value)
			valuteText.text = response.USD.buy + response.USD.symbol
		}
	}

	Image {
		x: 50;
		y: 25;
		width: 150;
		height: 150;
		source: "https://en.bitcoin.it/w/images/en/5/50/Bitcoin.png";
	}

	Text {
		id: valuteText;
		x: 5%;
		y: 185;
		width: 90%;
		horizontalAlignment: Text.AlignHCenter;
		font.pixelSize: 42;
		font.bold: true;
		wrapMode: Text.WordWrap;
		color: "#000";
	}
}
