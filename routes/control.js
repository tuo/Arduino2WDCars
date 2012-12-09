var sys = require('sys');
var exec = require('child_process').exec;
var child;
var serial = "/dev/cu.SLAB_USBtoUART"; //make sure the serial port is connnected
var setupCommand = "stty -f " + serial + " cs8 9600 ignbrk -brkint -imaxbel -opost -onlcr -isig -icanon -iexten -echo -echoe -echok -echoctl -echoke noflsh -ixon -crtscts";

exports.control = function(req, res){
	console.log("received command: " + req.body.command);
	
	var dirCommand = "echo -n '" + req.body.command + "' > " + serial;
	var command =  setupCommand + " && " + dirCommand;
	child = exec(command, function(error, stdout, stderr){
		sys.print('stdout: ' + stdout);
		sys.print('stderr: ' + stderr);		
		if(error !== null){
			console.log("exec command: "  + command + " failed with error: "+ error);
		}else{
			console.log('exec command: ' + command + " worked")
		}
	});
	
	res.contentType('json');
	res.send({'result': JSON.stringify({response:'json'})});
};