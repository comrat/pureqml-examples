Item {
	anchors.fill: context;

	Rectangle {
		width: 100;
		height: 100;
		color: "red";
		focus: true;

		onSelectPressed: {
			this.color = "blue"
			window.webOS.service.request("luna://com.webos.applicationManager", { method: "launch", parameters: { id: "com.example.app", params: { contentTarget: '100500' } } })
		}
	}
}
