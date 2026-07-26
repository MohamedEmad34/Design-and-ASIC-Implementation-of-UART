# UART Transmitter (UART TX)

A synthesizable UART (Universal Asynchronous Receiver/Transmitter) Transmitter designed in Verilog HDL. The design supports configurable parity generation and follows the standard UART frame format.

---

## Features

- 8-bit parallel data transmission
- LSB First serialization
- Configurable parity
  - Even Parity
  - Odd Parity
  - No Parity
- Finite State Machine (FSM) Controller
- Modular RTL Design
- Synthesizable Verilog HDL
- Self-contained Testbench

---

## UART Frame Format


<p align="center">
<img src="../../image./UART_FRAME_FORMAT.PNG" width="1000">
</p>



---

## Block Diagram

<p align="center">
<img src="../../image./UART_TX_ARCHETICTURE.PNG" width="1000"></p>

---

## FSM

<p align="center">
<img src="../../image./UART_TX_FSM.PNG" width="1000"></p>
</p>

| State  | Description                 |
| ------ | --------------------------- |
| IDLE   | Waits for DATA_VALID        |
| START  | Sends Start Bit (0)         |
| DATA   | Serializes 8-bit Data       |
| PARITY | Sends Parity Bit (Optional) |
| STOP   | Sends Stop Bit (1)          |

---

## RTL Modules

| Module | Description |
|----------|-------------|
| UART_TX | Top module |
| TX_FSM | Controls UART transmission sequence |
| serializer | Converts parallel data into serial data |
| parity_calc | Generates even/odd parity bit |
| tx_mux | Selects Start, Data, Parity or Stop bit |

---

## Simulation

The simulation verifies the correct UART frame generation, including Start Bit, Data Bits (LSB First), Optional Parity Bit, and Stop Bit.
### Test Cases

- No Parity
- Even Parity
- Odd Parity
- Multiple Data Patterns

Example:

| Data | Parity |
|------|--------|
| A5 | Disabled |
| 55 | Even |
| F3 | Odd |
| AA | Odd |

---

## Simulation Waveform

### Test Case 1 – Transmission without Parity

| Parameter | Value |
|-----------|-------|
| Data | 8'hA5 |
| Parity | Disabled |

<p align="center">
<img src="../waveforms/no_parity_test_case.PNG" width="900">
</p>

**Observation**

- The transmission starts with a **Start Bit (0)**.
- The 8-bit data (`8'hA5`) is transmitted **LSB first**.
- Since parity is disabled, no parity bit is transmitted.
- The frame ends with a **Stop Bit (1)**.
- The `BUSY` signal remains asserted during transmission and is deasserted after the frame is completed.
### Test Case 2 – Transmission with Even Parity

| Parameter | Value |
|-----------|-------|
| Data | `8'h55` |
| Parity | Even |

<p align="center">
<img src="../waveforms/Even_parity.PNG" width="900">
</p>

#### Verification Results

- ✔ Start bit (`0`) is generated correctly.
- ✔ The data byte (`8'h55`) is transmitted **LSB first**.
- ✔ Data = `8'h55` (`01010101₂`) contains **four logic '1's**.
- ✔ The generated parity bit is `0`, preserving **even parity**.
- ✔ The frame is terminated with a valid **Stop bit (`1`)**.
- ✔ The `BUSY` signal remains asserted during transmission and is deasserted once the complete frame has been transmitted.
## Tools

- Verilog HDL
- Xilinx Vivado Simulator

---

## Folder Structure

```

UART_TX/
│
├── rtl/
│ ├── UART_TX.v
│ ├── TX_FSM.v
│ ├── serializer.v
│ ├── parity_calc.v
│ └── mux.v
│
├── tb/
│ └── UART_TX_tb.v
│
├── images/
│ ├── SERIALIZER.png
│ ├── TX_MUX.png
│ ├── UART_ARCH
│ ├── UART_FRAME_FORMAT
│ ├──UART_SYSTEM_ARCH
| ├── UART_SYSTEM_ARCHETICTURE
| ├──UART_TX_FSM
│
├── waveforms/
│ └── uart_tx_waveform.png
│
└── README.md

```

---

## Future Improvements

- Configurable Data Width
- Baud Rate Generator
- UART Receiver (RX)
- FIFO Buffer
- SystemVerilog Self-checking Testbench
- Functional Coverage

---

## Author

Mohamed Emad
