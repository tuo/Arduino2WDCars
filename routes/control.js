var sys = require('sys');
var exec = require('child_process').exec;
var child;
var serial = "/dev/cu.SLAB_USBtoUART"; //make sure the serial port is connnected
exports.control = function(req, res){
	console.log("received command: " + req.body.command);	
	var command = "echo '" + req.body.command + "' > " + serial;
	res.contentType('json');
	child = exec(command, function(error, stdout, stderr){
		sys.print('stdout: ' + stdout);
		sys.print('stderr: ' + stderr);		
		if(error !== null){
			console.log("exec command: "  + command + " failed with error: "+ error);
			res.end('stdout:\n' + stdout + '\n\nstderr:\n' + stderr + ' \n\n error: \n' + error);
		}else{
			console.log('exec command: ' + command + " worked")
			res.end('stdout:\n' + stdout + '\n\nstderr:\n' + stderr);
		}
	});	
	// res.send({'result': JSON.stringify({response:'json'})});

};