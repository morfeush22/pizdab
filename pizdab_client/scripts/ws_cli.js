var socketService = new SocketService();

var StationBox = React.createClass({
	handleControll: function(connected) {
		this.setState({connected: connected});
	},
	handleData: function(message) {
		switch(message.$type) {
			case "set":
			case "init":	
			case "up":
				this.setState({data: message.$data});
				break;
			default:
				console.log("err");
				console.log(message.$type);
		}
	},
	handleFormSubmit: function(url) {
		this.setState({data: []});
		this.props.socketService.stop();
		this.props.socketService.start("ws://" + url, this.handleData, this.handleControll);
	},
	handleStationClicked: function(station) {
		var request = {};
		request.$type = "set";
		request.$data = station.sub_channel_id;
		this.props.socketService.sendRequest(request);
	},
	getInitialState: function() {
    	return {data: [], connected: false};
	},
	render: function() {
		return (
			<div className="stationBox">
				<IPForm connected={this.state.connected} onFormSubmit={this.handleFormSubmit}/>
				<StationList data={this.state.data} onStationClicked={this.handleStationClicked} />
			</div>
			);
	}
});

var IPForm = React.createClass({
	handleSubmit: function(e) {
		e.preventDefault();
		var url = this.refs.url.value.trim();
		this.props.onFormSubmit(url);
	},
	render: function() {
		var ipFormClass = classNames({
			"addrInput": true,
			"addrInputConnected": this.props.connected
		});
		return (
				<form className="ipForm" onSubmit={this.handleSubmit}>
					<input className={ipFormClass} type="search" placeholder="Address" ref="url" />
				</form>
			)
	}
})

var StationList = React.createClass({
	handleStationClicked: function(station) {
		this.props.onStationClicked(station);
	},
	render: function() {
		var stationNodes = this.props.data.map(function(station) {
			return (
				<Station key={station.sub_channel_id} station={station} onStationClicked={this.handleStationClicked} />
				);
		}.bind(this));

		var renderElement;
		if (stationNodes.length)
			renderElement = (
					<div className="stationList">
						<ul>
							{stationNodes}
						</ul>
					</div>
				)
		else
			renderElement = (
					<div className="emptyList">
						<img src="images/warning.png"></img>
						<span>Station list is empty. Enter vaild IP address to get station list.</span>
					</div>
				)

		return renderElement
	}
})

var Station = React.createClass({
	handleClick: function(e) {	
		this.props.onStationClicked(this.props.station);
	},
	render: function() {
		var stationClass = classNames({
			"station": true,
			"stationActive": this.props.station.current_station
		});
		return (
			<li className={stationClass} onClick={this.handleClick}>
				<span>{this.props.station.station_title}</span>
			</li>
			)
	}
})

ReactDOM.render(
	<StationBox socketService={socketService} />,
	document.getElementById("content")
	)
