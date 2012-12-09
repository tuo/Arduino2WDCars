//motorA  right wheel
int dir1PinA = 7;
int dir2PinA = 8;
int speedPinA = 6;


int dir1PinB = 12;
int dir2PinB = 13;
int speedPinB = 11;

unsigned long time ;
int speed;
int dir;
int increment = 20;

String comdata = "";

void setup() {
	pinMode(dir1PinA, OUTPUT);
	pinMode(dir2PinA, OUTPUT);
	pinMode(speedPinA, OUTPUT);
	pinMode(dir1PinB, OUTPUT);
	pinMode(dir2PinB, OUTPUT);
	pinMode(speedPinB, OUTPUT);
	speed = 200;
	Serial.begin(9600);
}
void turnLeft(){
	digitalWrite(dir1PinA, HIGH);
	digitalWrite(dir2PinA, LOW);
	digitalWrite(dir1PinB, LOW);
	digitalWrite(dir2PinB, LOW);			
}

void turnRight(){
	digitalWrite(dir1PinA, LOW);
	digitalWrite(dir2PinA, LOW);
	digitalWrite(dir1PinB, HIGH);
	digitalWrite(dir2PinB, LOW);			
}


void forward(){
	digitalWrite(dir1PinA, HIGH);
	digitalWrite(dir2PinA, LOW);
	digitalWrite(dir1PinB, HIGH);
	digitalWrite(dir2PinB, LOW);			
}

void back(){
	digitalWrite(dir1PinA, LOW);
	digitalWrite(dir2PinA, HIGH);
	digitalWrite(dir1PinB, LOW);
	digitalWrite(dir2PinB, HIGH);			
}




void loop() {
	// analogWrite(speedPinA, speed);
	// analogWrite(speedPinB, speed);
	// 
	// digitalWrite(dir1PinA, HIGH);
	// digitalWrite(dir2PinA, LOW);
	// digitalWrite(dir1PinB, HIGH);
	// digitalWrite(dir2PinB, LOW);		
	// Serial.println("speed : ");
	//         Serial.print(speed);
	// if(millis() -time > 2000){
	// 	time = millis();
	// 	speed += increment;
	// 	if(speed > 255){
	// 		speed = 0;
	// 	}
	// }
	
	while(Serial.available() > 0){
		comdata += char(Serial.read());
		delay(2);
	}
	
    if(comdata.length() > 0){
      Serial.println("---------------response-------");
      Serial.print(comdata);
      Serial.println("");
      if(comdata[0] == 'f'){
        Serial.println("moving forward");		
		forward();		
      }else if(comdata[0] == 'b'){
         Serial.println("moving back");
		 back();
      }else if(comdata[0] == 'r'){
         Serial.println("turning right");
		 turnRight();
      }else if(comdata[0] == 'l'){
		 Serial.println("turning left");
		 turnLeft();
	  }else if(comdata[0] == 'u'){
		 Serial.println("speed up");	  	
		 speed += increment;
		 if(speed > 255){
			speed = 255;
			Serial.println("maximum speed reached....");
		 } 
	 	analogWrite(speedPinA, speed);
	 	analogWrite(speedPinB, speed);
		 
	  }else if(comdata[0] == 'd'){
		 Serial.println("speed down");	  		  	
		 speed -= increment;
		 if(speed < 0){
			speed = 0;
			Serial.println("minum speed reached....");
		 } 		
	 	analogWrite(speedPinA, speed);
	 	analogWrite(speedPinB, speed);
  	  }else if(comdata[0] == 't'){
  		Serial.println("start the car");	  		  	
  		speed = 120;
  	  	analogWrite(speedPinA, speed);
  	  	analogWrite(speedPinB, speed);
		forward();	  					  
	  }else if(comdata[0] == 'p'){
		Serial.println("stop the car");	  		  	
		speed = 0;
	  	analogWrite(speedPinA, speed);
	  	analogWrite(speedPinB, speed);	  	
	  }else{
	  	 Serial.println("unrecognized command :(");
	  }
      Serial.println("");
      comdata = "";
    }
	delay(8);
}