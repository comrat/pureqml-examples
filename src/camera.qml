Rectangle {
	anchors.fill: context;
	color: "#0000";

	Image {
		width: 200;
		height: 80;
		anchors.left: parent.left;
		anchors.bottom: parent.bottom;
		anchors.margins: 10;
		source: "res/hud.png";
	}

	onCompleted: {
		var options = {
			x: 0,
			y: 0,
			width: this.width,
			height: this.height,
			camera: window.CameraPreview.CAMERA_DIRECTION.BACK,
			toBack: true,
			tapPhoto: true,
			tapFocus: false,
			previewDrag: false
		};

		window.CameraPreview.startCamera(options);
	}
}
