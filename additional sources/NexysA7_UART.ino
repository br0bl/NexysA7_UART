HardwareSerial NexysA7_UART(2);

void setup() 
{
  Serial.begin(115200);
  NexysA7_UART.begin(115200, SERIAL_8N1, 25, 26);
}

void loop() 
{
    if(Serial.available())
    {
        String input = Serial.readStringUntil('\n');
        input.trim();

        long value = strtol(input.c_str(), NULL, 2);

        if(value >= 0 && value <= 255)
        {
          NexysA7_UART.write((byte)value);

          Serial.print("Sent: ");
          Serial.println(value, BIN);
        }
    }

    if(NexysA7_UART.available())
    {
        byte received = NexysA7_UART.read();

        Serial.print("Received: ");
        Serial.println(received, BIN);
    }
}