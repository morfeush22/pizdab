function SocketService() {
	var service = {};
	var url = null;
	var dataCallback = null;
	var controlCallback = null;
	var connected = false;
	var ws = null;

	function start(newUrl, newDataCallback, newControlCallback) {
		url = newUrl;
		dataCallback = newDataCallback;
		controlCallback = newControlCallback;
		connected = false;	
		ws = new WebSocket(newUrl);

		ws.onopen = function() {
			connected = true;
			controlCallback(connected);
		}

		ws.onclose = function() {
			connected = false;
			controlCallback(connected);
		}

		ws.onmessage = function(message) {
			handleRequest(JSON.parse(message.data));
		}
	}

	function stop() {
		if (connected) {
			ws.close();
		}
	}

	function sendRequest(request) {
		if (ws && ~[2, 3].indexOf(ws.readyState)) {
			connected = false;
			start(url, dataCallback, controlCallback);
		}

		if (connected)
			ws.send(JSON.stringify(request));
	}

	function handleRequest(request) {
		dataCallback(request)
	}

	service.start = start;
	service.stop = stop;
	service.sendRequest = sendRequest
	return service
}
