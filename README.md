# UART Communication System Implementation

## Overview
A complete Universal Asynchronous Receiver/Transmitter (UART) system designed and implemented from scratch using Verilog. This RTL module enables reliable full-duplex serial communication. 
The system is highly configurable, supporting dynamic parity generation/checking and multiple oversampling rates to ensure robust data recovery.


## Key Features
* **Full-Duplex Communication:** Simultaneous transmission and reception of 8-bit data frames.
<img width="916" height="167" alt="{BD61ADFC-2D96-4FB6-91FD-A82346887D64}" src="https://github.com/user-attachments/assets/38a725cc-cf3f-46b8-9177-5537f24dc966" />

* **Configurable Parity:** Supports Even, Odd, or No Parity configurations via `PAR_EN` and `PAR_TYP` control signals.
<img width="918" height="186" alt="{67135C37-225D-4C94-ADDC-247FA799D604}" src="https://github.com/user-attachments/assets/b762bb14-4100-4651-8b53-21ce1a55ae34" />

* **Robust Receiver:** Implements data sampling at the middle of the bit period with configurable oversampling rates (8x, 16x, 32x) via the `Prescale` input.
<img width="681" height="793" alt="{8A930F5F-7BCE-440E-9087-234DFA4A3123}" src="https://github.com/user-attachments/assets/25d8bdac-c19c-4966-9d9f-7b2649030689" />

* **Error Detection:** Built-in error flags for Parity Mismatch (`Parity_Error`) and Framing/Stop Bit Error (`Stop_Error`).
* **Synchronous Design:** Fully synchronous architecture utilizing asynchronous active-low reset for proper initialization.

## System Architecture

### 1. UART Top Module
The top-level module integrates both the Transmitter and Receiver to provide a seamless full-duplex interface.
<img width="951" height="577" alt="{9148940D-82CA-43A0-8AAC-42F448919FF0}" src="https://github.com/user-attachments/assets/da74f3e3-fcc4-46ac-b27f-d743b6f2102e" />

### 2. UART Transmitter (UART_TX)
Responsible for serializing parallel data and appending start, parity, and stop bits to construct the transmission frame.
* **Internal Blocks:** Consists of a main FSM, Serializer, Parity Calculator, and an Output Multiplexer.
* **Operation:** Triggers transmission upon receiving a high `DATA_VALID` signal for one clock cycle.
* **Handshaking:** Outputs a `Busy` flag to indicate ongoing transmission, ensuring no data is overwritten during the process.
<img width="1134" height="729" alt="{7082D8C2-7B9D-43DA-A226-7C7415CA662C}" src="https://github.com/user-attachments/assets/3f4e804c-d363-467a-84c2-1a9f0d650f93" />

### 3. UART Receiver (UART_RX)
Responsible for detecting incoming frames, oversampling the serial stream, checking for corruption, and deserializing the stream back to parallel data.
* **Internal Blocks:** Consists of a main FSM, Data Sampler, Edge/Bit Counters, Deserializer, and specific check blocks for Start, Stop, and Parity bits.
* **Oversampling Mechanism:** Accurately extracts data by taking multiple samples per bit period (e.g., testing at 921.6 KHz for 8x oversampling of a 115.2 KHz baud rate).
* **Data Integrity:** Only asserts the output `data_valid` signal if the frame is received correctly without any parity or stop bit errors.
<img width="856" height="515" alt="{76D52DC5-3550-4764-9093-BE79BEBD5953}" src="https://github.com/user-attachments/assets/ba7f360f-e7a2-42f4-8553-22584ac962be" />


