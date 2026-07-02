# UART Communication System Implementation

## 📝 Overview
A complete Universal Asynchronous Receiver/Transmitter (UART) system designed and implemented from scratch using Verilog. This RTL module enables reliable full-duplex serial communication[cite: 3]. The system is highly configurable, supporting dynamic parity generation/checking and multiple oversampling rates to ensure robust data recovery.

## ✨ Key Features
* **Full-Duplex Communication:** Simultaneous transmission and reception of 8-bit data frames.
* **Configurable Parity:** Supports Even, Odd, or No Parity configurations via `PAR_EN` and `PAR_TYP` control signals.
* **Robust Receiver:** Implements data sampling at the middle of the bit period with configurable oversampling rates (8x, 16x, 32x) via the `Prescale` input.
* **Advanced Error Detection:** Built-in error flags for Parity Mismatch (`Parity_Error`) and Framing/Stop Bit Error (`Stop_Error`).
* **Synchronous Design:** Fully synchronous architecture utilizing asynchronous active-low reset for proper initialization.

## 🏗️ System Architecture

### 1. UART Top Module
The top-level module integrates both the Transmitter and Receiver to provide a seamless full-duplex interface.

<img width="951" height="577" alt="{9148940D-82CA-43A0-8AAC-42F448919FF0}" src="https://github.com/user-attachments/assets/da74f3e3-fcc4-46ac-b27f-d743b6f2102e" />


### 2. UART Transmitter (UART_TX)
Responsible for serializing parallel data and appending start, parity, and stop bits to construct the transmission frame.
* **Internal Blocks:** Consists of a main FSM, Serializer, Parity Calculator, and an Output Multiplexer[cite: 2].
* **Operation:** Triggers transmission upon receiving a high `DATA_VALID` signal for one clock cycle[cite: 2].
* **Handshaking:** Outputs a `Busy` flag to indicate ongoing transmission, ensuring no data is overwritten during the process[cite: 2].

### 3. UART Receiver (UART_RX)
Responsible for detecting incoming frames, oversampling the serial stream, checking for corruption, and deserializing the stream back to parallel data.
* **Internal Blocks:** Consists of a main FSM, Data Sampler, Edge/Bit Counters, Deserializer, and specific check blocks for Start, Stop, and Parity bits[cite: 4].
* **Oversampling Mechanism:** Accurately extracts data by taking multiple samples per bit period (e.g., testing at 921.6 KHz for 8x oversampling of a 115.2 KHz baud rate)[cite: 4].
* **Data Integrity:** Only asserts the output `data_valid` signal if the frame is received correctly without any parity or stop bit errors[cite: 4].

