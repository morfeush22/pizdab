var socketService = new SocketService();

var StationBox = React.createClass({
	handleData: function(message) {
		switch(message.$type) {
			case "set":
				console.log("rcv");
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
		this.props.socketService.start("ws://" + url, this.handleData);
	},
	handleStationClicked: function(station) {
		//console.log(station.sub_channel_id);
		var request = {};
		request.$type = "set";
		request.$data = station.sub_channel_id;
		this.props.socketService.sendRequest(request);
	},
	getInitialState: function() {
    	return {data: []};
	},
	render: function() {
		return (
			<div className="stationBox">
				<IPForm onFormSubmit={this.handleFormSubmit}/>
				<h1>Stations</h1>
				<StationList data={this.state.data} onStationClicked={this.handleStationClicked} />
			</div>
			);
	}
});

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
		return (
			<div className="stationList">
				{stationNodes}
			</div>
			)
	}
})

var Station = React.createClass({
	handleClick: function(e) {	
		this.props.onStationClicked(this.props.station);
	},
	render: function() {
		return (
			<p className="station" onClick={this.handleClick}>
				{this.props.station.station_title} - {this.props.station.current_station.toString()}
			</p>
			)
	}
})

var IPForm = React.createClass({
	handleSubmit: function(e) {
		e.preventDefault();
		var url = this.refs.url.value.trim();
		this.props.onFormSubmit(url);
	},
	render: function() {
		return (
				<form className="ipForm" onSubmit={this.handleSubmit}>
					<input type="text" placeholder="IP" ref="url" />
					<input type="submit" value="Post" />
				</form>
			)
	}
})

ReactDOM.render(
	<StationBox socketService={socketService} />,
	document.getElementById("content")
	)
