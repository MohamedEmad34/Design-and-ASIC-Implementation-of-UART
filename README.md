UART-ASIC-RTL-to-GDSII/
│
├── RTL/
├── Testbench/
├── Constraints/
├── Scripts/
├── Reports/
│   ├── Timing/
│   ├── Area/
│   └── Power/
├── Layout/
├── GDS/
├── images/
│   ├── uart_block.png
│   ├── waveform.png
│   ├── floorplan.png
│   ├── placement.png
│   ├── cts.png
│   ├── routing.png
│   └── layout.png
├── README.md
└── LICENSE
# UART ASIC Design Flow (RTL to GDSII)

## Overview

This repository presents the complete ASIC implementation flow of a **Universal Asynchronous Receiver/Transmitter (UART)**, starting from RTL design and ending with the final GDSII layout.

The project demonstrates a complete digital ASIC flow using Synopsys EDA tools and the **SAED 32 nm CMOS technology library**.

---

## Features

- UART Transmitter (TX)
- UART Receiver (RX)
- Finite State Machine (FSM) based architecture
- RTL to GDSII Implementation
- Timing-driven Physical Design

---

## Design Flow

✔ RTL Design (Verilog HDL)

✔ Functional Verification (Synopsys VCS)

✔ Logic Synthesis (Synopsys Design Compiler)

✔ Floorplanning

✔ Power Planning

✔ Placement Optimization

✔ Clock Tree Synthesis (CTS)

✔ Routing

✔ Timing Closure

✔ Physical Verification

✔ GDSII Generation

---

## Tools

| Tool | Purpose |
|-------|----------|
| Verilog HDL | RTL Design |
| Synopsys VCS | Functional Simulation |
| Synopsys Design Compiler | Logic Synthesis |
| Synopsys IC Compiler II | Physical Design |
| SAED 32nm Library | Standard Cell Library |

---

## UART Overview

UART (Universal Asynchronous Receiver/Transmitter) is one of the most widely used asynchronous serial communication protocols.

It enables communication between two devices using only two signal lines:

- TX (Transmit)
- RX (Receive)

UART is commonly used in:

- Embedded Systems
- Microcontrollers
- SoCs
- FPGA Designs
- ASIC Designs

---

## Project Architecture

<p align="center">
<img src="images/UART_Block_Diagram.png" width="700">
</p>

---

## Simulation Results

<p align="center">
<img src="images/UART_Waveform.png" width="900">
</p>

---

## Floorplan

<p align="center">
<img src="images/Floorplan.png" width="800">
</p>

---

## Placement

<p align="center">
<img src="images/Placement.png" width="800">
</p>

---

## Clock Tree Synthesis (CTS)

<p align="center">
<img src="images/CTS.png" width="800">
</p>

---

## Routing

<p align="center">
<img src="images/Routing.png" width="800">
</p>

---

## Final Layout

<p align="center">
<img src="images/Layout.png" width="800">
</p>

---

## Technology

- Technology Node: SAED 32 nm CMOS
- RTL Language: Verilog HDL

---

## Author

**Mohamed Emad**

ASIC Digital Design & Physical Design Engineer

- RTL Design
- Logic Synthesis
- Physical Design
- RTL to GDSII
