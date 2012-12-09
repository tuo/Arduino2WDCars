
/**
 * Module dependencies.
 */

var express = require('express')
  , routes = require('./routes')
  , user = require('./routes/user')
  , control = require('./routes/control')
  , http = require('http')
  , path = require('path');

var app = express();

var sys = require('sys');
var exec = require('child_process').exec;
var child;
var serial = "/dev/cu.SLAB_USBtoUART"; //make sure the serial port is connnected
var setupCommand = "/bin/stty -f " + serial + " cs8 9600 ignbrk -brkint -imaxbel -opost -onlcr -isig -icanon -iexten -echo -echoe -echok -echoctl -echoke noflsh -ixon -crtscts";



app.configure(function(){
  app.set('port', process.env.PORT || 3000);
  app.set('views', __dirname + '/views');
  app.set('view engine', 'ejs');
  app.use(express.favicon());
  app.use(express.logger('dev'));
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(app.router);
  app.use(express.static(path.join(__dirname, 'public')));
});

app.configure('development', function(){
  app.use(express.errorHandler());
});

app.get('/', routes.index);
app.post('/control', control.control);
app.get('/users', user.list);

child = exec(setupCommand, function(error, stdout, stderr){
	sys.print('stdout: ' + stdout);
	sys.print('stderr: ' + stderr);		
	if(error !== null){
		console.log("exec command: "  + setupCommand + " failed with error: "+ error);
	}else{
		console.log('exec command: ' + setupCommand + " worked")	
	}
});

http.createServer(app).listen(app.get('port'), function(){
  console.log("Express server listening on port " + app.get('port'));
});
