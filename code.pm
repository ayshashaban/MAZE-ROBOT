// Define the sensor pins
#define S1Trig A1
#define S2Trig A3
#define S3Trig A5
#define S1Echo A0
#define S2Echo A2
#define S3Echo A4

// Define the motor control pins for the L298N
#define ENA 8 // Enable pin for motor 1 (speed control)
#define IN1 6 // Control pin 1 for motor 1
#define IN2 7 // Control pin 2 for motor 1
#define ENB 9 // Enable pin for motor 2 (speed control)
#define IN3 10 // Control pin 1 for motor 2
#define IN4 11 // Control pin 2 for motor 2

// Set the speed of the motors
#define Speed 160

void setup() {
  Serial.begin(9600);
  
  // Set the Trig pins as output pins
  pinMode(S1Trig, OUTPUT);
  pinMode(S2Trig, OUTPUT);
  pinMode(S3Trig, OUTPUT);
  
  // Set the Echo pins as input pins
  pinMode(S1Echo, INPUT);
  pinMode(S2Echo, INPUT);
  pinMode(S3Echo, INPUT);
  
  // Set motor control pins as outputs
  pinMode(ENA, OUTPUT);
  pinMode(IN1, OUTPUT);
  pinMode(IN2, OUTPUT);
  pinMode(ENB, OUTPUT);
  pinMode(IN3, OUTPUT);
  pinMode(IN4, OUTPUT);

  // Set the initial speed of the motors
  analogWrite(ENA, Speed);
  analogWrite(ENB, Speed);
}

void loop() {
  int centerSensor = sensorTwo();
  int leftSensor = sensorOne();
  int rightSensor = sensorThree();

  // Check the distance using the IF condition
  if (8 >= centerSensor) {
    Stop();
    Serial.println("Stop");
    delay(1000);
    if (leftSensor > rightSensor) {
      left();
      Serial.println("Left");
      delay(500);
    } else {
      right();
      Serial.println("Right");
      delay(500);
    }
  } else {
    Serial.println("Forward");
    forward();
  }
}

// Get the sensor values
int sensorOne() {
  // Pulse output
  digitalWrite(S1Trig, LOW);
  delayMicroseconds(4);
  digitalWrite(S1Trig, HIGH);
  delayMicroseconds(10);
  digitalWrite(S1Trig, LOW);

  long t = pulseIn(S1Echo, HIGH); // Get the pulse
  int cm = t / 29 / 2; // Convert time to the distance
  return cm; // Return the values from the sensor
}

// Get the sensor values
int sensorTwo() {
  // Pulse output
  digitalWrite(S2Trig, LOW);
  delayMicroseconds(4);
  digitalWrite(S2Trig, HIGH);
  delayMicroseconds(10);
  digitalWrite(S2Trig, LOW);

  long t = pulseIn(S2Echo, HIGH); // Get the pulse
  int cm = t / 29 / 2; // Convert time to the distance
  return cm; // Return the values from the sensor
}

// Get the sensor values
int sensorThree() {
  // Pulse output
  digitalWrite(S3Trig, LOW);
  delayMicroseconds(4);
  digitalWrite(S3Trig, HIGH);
  delayMicroseconds(10);
  digitalWrite(S3Trig, LOW);

  long t = pulseIn(S3Echo, HIGH); // Get the pulse
  int cm = t / 29 / 2; // Convert time to the distance
  return cm; // Return the values from the sensor
}

/******************* Motor functions **********************/
void forward() {
  digitalWrite(IN1, HIGH);
  digitalWrite(IN2, LOW);
  digitalWrite(IN3, HIGH);
  digitalWrite(IN4, LOW);
  analogWrite(ENA, Speed);
  analogWrite(ENB, Speed);
}

void left() {
  digitalWrite(IN1, LOW);
  digitalWrite(IN2, HIGH);
  digitalWrite(IN3, HIGH);
  digitalWrite(IN4, LOW);
  analogWrite(ENA, Speed);
  analogWrite(ENB, Speed);
}

void right() {
  digitalWrite(IN1, HIGH);
  digitalWrite(IN2, LOW);
  digitalWrite(IN3, LOW);
  digitalWrite(IN4, HIGH);
  analogWrite(ENA, Speed);
  analogWrite(ENB, Speed);
}

void Stop() {
  digitalWrite(IN1, LOW);
  digitalWrite(IN2, LOW);
  digitalWrite(IN3, LOW);
  digitalWrite(IN4, LOW);
  analogWrite(ENA, 0);
  analogWrite(ENB, 0);
}
