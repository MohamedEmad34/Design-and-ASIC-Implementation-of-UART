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
<img src="..../image./UART_FRAME_FORMAT.PNG" width="700">
</p>



---

## Block Diagram

<p align="center">
<img src="/uart_tx_architecture.png" width="700">
</p>

---

## FSM

<p align="center">
<img src="images/tx_fsm.png" width="500">
</p>

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

The transmitter was verified using a dedicated Verilog Testbench covering different transmission scenarios.

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

<p align="center">
<img src="waveforms/uart_tx_waveform.png" width="900">
</p>

---

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
│ └── tx_mux.v
│
├── tb/
│ └── UART_TX_tb.v
│
├── images/
│ ├── uart_tx_architecture.png
│ └── tx_fsm.png
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
