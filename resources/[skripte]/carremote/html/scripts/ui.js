// const hotKey = 42; // FIXME: This was causing server issues over and over.

// Callback to client.lua
function httpPost(event, data) {
	const xhr = new XMLHttpRequest(); 
	xhr.open("POST", "http://carremote/" + event, true);
	xhr.send(JSON.stringify({data}));
}

document.onkeydown = function (data) {
	if (data.which == '314' || '27') { // Escape key 
		document.getElementById("keyfob").style.display = 'none';
		document.getElementById("carDisconnected").style.display = 'none';
		document.getElementById("carConnected").style.display = 'none';
		document.getElementById("engineOff").style.display = 'none';
		document.getElementById("engineOn").style.display = 'none';
		document.getElementById("unlocked").style.display = 'none';
		document.getElementById("locked").style.display = 'none';
		httpPost("NUIFocusOff");
	}
};


// Listens for messages from the client and updates the status
window.addEventListener('message', function(event) {

	// Open Key Fob
	if (event.data.type == "openKeyFob") {
		document.getElementById("keyfob").style.display = 'block';
		
	} else if (event.data.type == "setHotKey") {
		hotKey = event.data.value
	
	} else if (event.data.type == "carConnected") {
		document.getElementById("carDisconnected").style.display = 'none';
		document.getElementById("carConnected").style.display = 'block';
	
	} else if (event.data.type == "carDisconnected") {
		document.getElementById("carConnected").style.display = 'none';
		document.getElementById("carDisconnected").style.display = 'block';
		

	} else if (event.data.type == "battery-0") {
		document.getElementById("battery-0").style.display = 'block';
		document.getElementById("battery-10").style.display = 'none';
		document.getElementById("battery-20").style.display = 'none';
		document.getElementById("battery-30").style.display = 'none';
		document.getElementById("battery-40").style.display = 'none';
		document.getElementById("battery-50").style.display = 'none';
		document.getElementById("battery-60").style.display = 'none';
		document.getElementById("battery-70").style.display = 'none';
		document.getElementById("battery-80").style.display = 'none';
		document.getElementById("battery-90").style.display = 'none';
		document.getElementById("battery-100").style.display = 'none';	
	
	} else if (event.data.type == "battery-10") {
		document.getElementById("battery-0").style.display = 'none';
		document.getElementById("battery-10").style.display = 'block';
		document.getElementById("battery-20").style.display = 'none';
		document.getElementById("battery-30").style.display = 'none';
		document.getElementById("battery-40").style.display = 'none';
		document.getElementById("battery-50").style.display = 'none';
		document.getElementById("battery-60").style.display = 'none';
		document.getElementById("battery-70").style.display = 'none';
		document.getElementById("battery-80").style.display = 'none';
		document.getElementById("battery-90").style.display = 'none';
		document.getElementById("battery-100").style.display = 'none';	
	

	} else if (event.data.type == "battery-20") {
		document.getElementById("battery-0").style.display = 'none';
		document.getElementById("battery-10").style.display = 'none';
		document.getElementById("battery-20").style.display = 'block';
		document.getElementById("battery-30").style.display = 'none';
		document.getElementById("battery-40").style.display = 'none';
		document.getElementById("battery-50").style.display = 'none';
		document.getElementById("battery-60").style.display = 'none';
		document.getElementById("battery-70").style.display = 'none';
		document.getElementById("battery-80").style.display = 'none';
		document.getElementById("battery-90").style.display = 'none';
		document.getElementById("battery-100").style.display = 'none';
		
	} else if (event.data.type == "battery-30") {
		document.getElementById("battery-0").style.display = 'none';
		document.getElementById("battery-10").style.display = 'none';
		document.getElementById("battery-20").style.display = 'none';
		document.getElementById("battery-30").style.display = 'block';
		document.getElementById("battery-40").style.display = 'none';
		document.getElementById("battery-50").style.display = 'none';
		document.getElementById("battery-60").style.display = 'none';
		document.getElementById("battery-70").style.display = 'none';
		document.getElementById("battery-80").style.display = 'none';
		document.getElementById("battery-90").style.display = 'none';
		document.getElementById("battery-100").style.display = 'none';	
		
	} else if (event.data.type == "battery-40") {
		document.getElementById("battery-0").style.display = 'none';
		document.getElementById("battery-10").style.display = 'none';
		document.getElementById("battery-20").style.display = 'none';
		document.getElementById("battery-30").style.display = 'none';
		document.getElementById("battery-40").style.display = 'block';
		document.getElementById("battery-50").style.display = 'none';
		document.getElementById("battery-60").style.display = 'none';
		document.getElementById("battery-70").style.display = 'none';
		document.getElementById("battery-80").style.display = 'none';
		document.getElementById("battery-90").style.display = 'none';
		document.getElementById("battery-100").style.display = 'none';	
		
	} else if (event.data.type == "battery-50") {
		document.getElementById("battery-0").style.display = 'none';
		document.getElementById("battery-10").style.display = 'none';
		document.getElementById("battery-20").style.display = 'none';
		document.getElementById("battery-30").style.display = 'none';
		document.getElementById("battery-40").style.display = 'none';
		document.getElementById("battery-50").style.display = 'block';
		document.getElementById("battery-60").style.display = 'none';
		document.getElementById("battery-70").style.display = 'none';
		document.getElementById("battery-80").style.display = 'none';
		document.getElementById("battery-90").style.display = 'none';
		document.getElementById("battery-100").style.display = 'none';	

	} else if (event.data.type == "battery-60") {
		document.getElementById("battery-0").style.display = 'none';
		document.getElementById("battery-10").style.display = 'none';
		document.getElementById("battery-20").style.display = 'none';
		document.getElementById("battery-30").style.display = 'none';
		document.getElementById("battery-40").style.display = 'none';
		document.getElementById("battery-50").style.display = 'none';
		document.getElementById("battery-60").style.display = 'block';
		document.getElementById("battery-70").style.display = 'none';
		document.getElementById("battery-80").style.display = 'none';
		document.getElementById("battery-90").style.display = 'none';
		document.getElementById("battery-100").style.display = 'none';	
	
	} else if (event.data.type == "battery-70") {
		document.getElementById("battery-0").style.display = 'none';
		document.getElementById("battery-10").style.display = 'none';
		document.getElementById("battery-20").style.display = 'none';
		document.getElementById("battery-30").style.display = 'none';
		document.getElementById("battery-40").style.display = 'none';
		document.getElementById("battery-50").style.display = 'none';
		document.getElementById("battery-60").style.display = 'none';
		document.getElementById("battery-70").style.display = 'block';
		document.getElementById("battery-80").style.display = 'none';
		document.getElementById("battery-90").style.display = 'none';
		document.getElementById("battery-100").style.display = 'none';		

	} else if (event.data.type == "battery-80") {
		document.getElementById("battery-0").style.display = 'none';
		document.getElementById("battery-10").style.display = 'none';
		document.getElementById("battery-20").style.display = 'none';
		document.getElementById("battery-30").style.display = 'none';
		document.getElementById("battery-40").style.display = 'none';
		document.getElementById("battery-50").style.display = 'none';
		document.getElementById("battery-60").style.display = 'none';
		document.getElementById("battery-70").style.display = 'none';
		document.getElementById("battery-80").style.display = 'block';
		document.getElementById("battery-90").style.display = 'none';
		document.getElementById("battery-100").style.display = 'none';		
	
	} else if (event.data.type == "battery-90") {
		document.getElementById("battery-0").style.display = 'none';
		document.getElementById("battery-10").style.display = 'none';
		document.getElementById("battery-20").style.display = 'none';
		document.getElementById("battery-30").style.display = 'none';
		document.getElementById("battery-40").style.display = 'none';
		document.getElementById("battery-50").style.display = 'none';
		document.getElementById("battery-60").style.display = 'none';
		document.getElementById("battery-70").style.display = 'none';
		document.getElementById("battery-80").style.display = 'none';
		document.getElementById("battery-90").style.display = 'block';
		document.getElementById("battery-100").style.display = 'none';	
	
	} else if (event.data.type == "battery-100") {
		document.getElementById("battery-0").style.display = 'none';
		document.getElementById("battery-10").style.display = 'none';
		document.getElementById("battery-20").style.display = 'none';
		document.getElementById("battery-30").style.display = 'none';
		document.getElementById("battery-40").style.display = 'none';
		document.getElementById("battery-50").style.display = 'none';
		document.getElementById("battery-60").style.display = 'none';
		document.getElementById("battery-70").style.display = 'none';
		document.getElementById("battery-80").style.display = 'none';
		document.getElementById("battery-90").style.display = 'none';
		document.getElementById("battery-100").style.display = 'block';	

	// TODO: Add Wifi icon
	
	} else if (event.data.type == "engineOn") {
		document.getElementById("engineOn").style.display = 'block';
		document.getElementById("engineOff").style.display = 'none';
	
	} else if (event.data.type == "engineOff") {
		document.getElementById("engineOn").style.display = 'none';
		document.getElementById("engineOff").style.display = 'block';
	
	} else if (event.data.type == "locked") {
		document.getElementById("unlocked").style.display = 'none';
		document.getElementById("locked").style.display = 'block';

	} else if (event.data.type == "unlocked") {
		document.getElementById("unlocked").style.display = 'block';
		document.getElementById("locked").style.display = 'none';
		
	} else if (event.data.type == "disableButtons") {
		document.getElementById("buttonStart").disabled = true;
		document.getElementById("buttonLock").disabled = true;
		document.getElementById("buttonUnlock").disabled = true;
		document.getElementById("buttonAux").disabled = true;
		
	} else if (event.data.type == "enableButtons") {
		document.getElementById("buttonStart").disabled = false;
		document.getElementById("buttonLock").disabled = false;
		document.getElementById("buttonUnlock").disabled = false;
		document.getElementById("buttonAux").disabled = false;

	} else if (event.data.type == "closeAll") {
		document.getElementById("keyfob").style.display = 'none';
		document.getElementById("carDisconnected").style.display = 'none';
		document.getElementById("carConnected").style.display = 'none';
		document.getElementById("engineOff").style.display = 'none';
		document.getElementById("engineOn").style.display = 'none';
		document.getElementById("unlocked").style.display = 'none';
		document.getElementById("locked").style.display = 'none';
		document.getElementById("battery-0").style.display = 'none';
		document.getElementById("battery-10").style.display = 'none';
		document.getElementById("battery-20").style.display = 'none';
		document.getElementById("battery-30").style.display = 'none';
		document.getElementById("battery-40").style.display = 'none';
		document.getElementById("battery-50").style.display = 'none';
		document.getElementById("battery-60").style.display = 'none';
		document.getElementById("battery-70").style.display = 'none';
		document.getElementById("battery-80").style.display = 'none';
		document.getElementById("battery-90").style.display = 'none';
		document.getElementById("battery-100").style.display = 'none';	
		httpPost("NUIFocusOff");
	}
});