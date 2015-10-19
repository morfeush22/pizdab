function SocketService() {
	var service = {};
	var url = null;
	var callback = null;
	var connected = false;
	var ws = null;

	function start(newUrl, newCallback) {
		url = newUrl;
		callback = newCallback;
		connected = false;	
		ws = new WebSocket(newUrl);

		ws.onopen = function() {
			connected = true;
		}

		ws.onclose = function() {
			connected = false;
		}

		ws.onmessage = function(message) {
			handleRequest(JSON.parse(message.data));
		}
	}

	function stop() {
		if (connected) {
			ws.close();
			console.log("close");
		}
		console.log(connected);
	}

	function sendRequest(request) {
		if (ws && ~[2, 3].indexOf(ws.readyState)) {
			connected = false;
			start(url, callback);
		}

		if (connected)
			ws.send(JSON.stringify(request));
	}

	function handleRequest(request) {
		callback(request)
	}

	service.start = start;
	service.stop = stop;
	service.sendRequest = sendRequest
	return service
}
