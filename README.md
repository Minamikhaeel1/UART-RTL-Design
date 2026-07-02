# UART Communication System Implementation

## Overview
A complete Universal Asynchronous Receiver/Transmitter (UART) system designed and implemented from scratch using Verilog. This RTL module enables reliable full-duplex serial communication. 
The system is highly configurable, supporting dynamic parity generation/checking and multiple oversampling rates to ensure robust data recovery.


## Key Features
* **Full-Duplex Communication:** Supports simultaneous, bidirectional serial data transmission and reception.
The receiver is highly optimized to handle consecutive incoming frames continuously without requiring any inter-frame gaps.
<img width="1203" height="107" alt="{F7BB54DB-AD44-4C49-A935-4E15334D73B6}" src="https://github.com/user-attachments/assets/4a370a4e-07a4-499e-bb7d-32100ed0c82a" />

<br>

* **Configurable Parity:** Configurable frame construction consisting of 1 start bit (low), 8 data bits, an optional parity bit, and 1 stop bit (high).
Parity is fully dynamic and controlled via `PAR_EN` (enable/disable) and `PAR_TYP` (Even/Odd) configuration signals.
<img width="918" height="186" alt="{67135C37-225D-4C94-ADDC-247FA799D604}" src="https://github.com/user-attachments/assets/b762bb14-4100-4651-8b53-21ce1a55ae34" />

<br>

* **Robust Receiver:** Enhances data recovery in noisy environments by sampling incoming data at the exact middle of the bit period.
Supports multiple oversampling ratios (8x, 16x, 32x) via the `Prescale` input. For a standard 115.2 KHz transmission baud rate, the receiver can accurately operate at clock speeds of 921.6 KHz, 1.843 MHz, or 3.686 MHz.
<img width="851" height="803" alt="{3C570E3E-8A47-4ECE-8B88-3EE084AF00CF}" src="https://github.com/user-attachments/assets/65a8af70-e043-4b40-a02a-fe4d6c684d59" />

<br>

* **Error Detection:** Built-in hardware flags for immediate corruption identification.
The `Parity_Error` flag asserts upon a mismatch between calculated and received parity bits, while the `Stop_Error` flag asserts if the frame lacks a valid stop bit.


* **Synchronous Design:** The design utilizes a fully synchronous clocking scheme combined with an asynchronous active-low reset to guarantee safe and predictable system initialization.


## System Architecture

### 1. UART Top Module
The top-level module integrates both the Transmitter and Receiver to provide a seamless full-duplex interface.
<img width="951" height="577" alt="{9148940D-82CA-43A0-8AAC-42F448919FF0}" src="https://github.com/user-attachments/assets/da74f3e3-fcc4-46ac-b27f-d743b6f2102e" />

<br>

### 2. UART Transmitter (UART_TX)
Responsible for serializing parallel data and appending start, parity, and stop bits to construct the transmission frame.
* **Internal Blocks:** Consists of a main FSM, Serializer, Parity Calculator, and an Output Multiplexer.
* **Operation:** Triggers transmission upon receiving a high `DATA_VALID` signal for one clock cycle.
* **Handshaking:** Outputs a `Busy` flag to indicate ongoing transmission, ensuring no data is overwritten during the process.
<img width="1134" height="729" alt="{7082D8C2-7B9D-43DA-A226-7C7415CA662C}" src="https://github.com/user-attachments/assets/3f4e804c-d363-467a-84c2-1a9f0d650f93" />

<br>

### 3. UART Receiver (UART_RX)
Responsible for detecting incoming frames, oversampling the serial stream, checking for corruption, and deserializing the stream back to parallel data.
* **Internal Blocks:** Consists of a main FSM, Data Sampler, Edge/Bit Counters, Deserializer, and specific check blocks for Start, Stop, and Parity bits.
* **Oversampling Mechanism:** Accurately extracts data by taking multiple samples per bit period (e.g., testing at 921.6 KHz for 8x oversampling of a 115.2 KHz baud rate).
* **Data Integrity:** Only asserts the output `data_valid` signal if the frame is received correctly without any parity or stop bit errors.
<img width="856" height="515" alt="{76D52DC5-3550-4764-9093-BE79BEBD5953}" src="https://github.com/user-attachments/assets/ba7f360f-e7a2-42f4-8553-22584ac962be" />

<br>

## How to Run Simulation (ModelSim/QuestaSim)
This project includes automated TCL scripts for quick compilation and simulation setup.

run.do: ModelSim DO script for automated compilation and simulation.

wave.do: ModelSim DO script to load the saved waveform formatting.

1. Open **ModelSim** or **QuestaSim**.
2. In the Transcript window, navigate to the project directory:
   ```tcl
   cd /path/to/your/project
   run.do / wave.do

