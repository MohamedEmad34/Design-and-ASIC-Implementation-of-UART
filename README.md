# UART ASIC RTL-to-GDSII Implementation

<p align="center">

![Verilog](https://img.shields.io/badge/Language-Verilog-blue)
![Synopsys](https://img.shields.io/badge/EDA-Synopsys-success)
![RTL to GDSII](https://img.shields.io/badge/Flow-RTL--to--GDSII-orange)
![Technology](https://img.shields.io/badge/Technology-SAED32nm-red)

<p align="center">
  <img src="image/Capture.png" width="1000">
</p>
---

# Overview

This repository demonstrates the complete ASIC implementation flow of a **Universal Asynchronous Receiver/Transmitter (UART)** from **RTL to GDSII**.

The design is implemented using **Verilog HDL**, functionally verified with **Synopsys VCS**, synthesized using **Synopsys Design Compiler**, and physically implemented using **Synopsys IC Compiler II (ICC2)** targeting the **SAED 32nm CMOS Standard Cell Library**.

The project follows a complete industrial ASIC design methodology including RTL design, synthesis, floorplanning, placement, CTS, routing, timing closure, and physical verification.

---

# Table of Contents

- Overview
- UART Architecture
- ASIC Design Flow
- Design Tools
- Project Structure
- Simulation Results
- Floorplan
- Placement
- Clock Tree Synthesis
- Routing
- Final Layout
- Reports
- Technology
- Author

---

# UART Overview

UART (Universal Asynchronous Receiver/Transmitter) is one of the most widely used asynchronous serial communication protocols.

It enables communication between two digital devices using only two wires:

- TX (Transmit)
- RX (Receive)

UART is commonly used in

- Embedded Systems
- ASIC Design
- FPGA Design
- Microcontrollers
- SoCs

---

# UART Architecture

<p align="center">
<img src="images/UART_Block_Diagram.png" width="700">
</p>

The UART consists of

- UART Transmitter (TX)
- UART Receiver (RX)
- Baud Rate Generator
- Finite State Machine (FSM)
- Control Logic

---

# ASIC Design Flow

```
RTL Design
      │
      ▼
Functional Simulation (VCS)
      │
      ▼
Logic Synthesis (Design Compiler)
      │
      ▼
Floorplanning
      │
      ▼
Power Planning
      │
      ▼
Placement
      │
      ▼
Clock Tree Synthesis (CTS)
      │
      ▼
Routing
      │
      ▼
Timing Closure
      │
      ▼
Physical Verification
      │
      ▼
GDSII Generation
```

---

# Design Tools

| Tool | Purpose |
|-------|----------|
| Verilog HDL | RTL Design |
| Synopsys VCS | Functional Verification |
| Design Compiler | Logic Synthesis |
| IC Compiler II | Physical Design |
| SAED 32nm | Standard Cell Library |

---

# Project Structure

```
Design-and-ASIC-Implementation-of-UART
│
├── RTL
├── Testbench
├── Constraints
├── Scripts
├── Reports
├── images
├── README.md
└── LICENSE
```

---

# Simulation Result

<p align="center">
<img src="images/waveform.png" width="900">
</p>

---

# Floorplan

<p align="center">
<img src="images/floorplan.png" width="900">
</p>

---

# Placement

<p align="center">
<img src="images/placement.png" width="900">
</p>

---

# Clock Tree Synthesis (CTS)

<p align="center">
<img src="images/cts.png" width="900">
</p>

---

# Routing

<p align="center">
<img src="images/routing.png" width="900">
</p>

---

# Final Layout

<p align="center">
<img src="images/layout.png" width="900">
</p>

---

# Reports

The project includes

- Timing Report
- Area Report
- Power Report
- Utilization Report
- Congestion Analysis

---

# Technology

| Item | Value |
|------|--------|
| Technology | SAED 32nm CMOS |
| RTL Language | Verilog HDL |
| Design Methodology | RTL to GDSII |
| Protocol | UART |

---

# Future Improvements

- Scan Chain Insertion
- DFT Support
- Formal Verification
- Low Power Optimization
- Multi-Corner Multi-Mode (MCMM)
- Physical Signoff

---

# Author

## Mohamed Emad

**ASIC Digital Design & Physical Design Engineer**

### Skills

- RTL Design
- Verilog HDL
- ASIC Design Flow
- Logic Synthesis
- Physical Design
- Floorplanning
- CTS
- Routing
- Timing Closure
- Synopsys Design Compiler
- Synopsys IC Compiler II

---

⭐ If you found this repository useful, consider giving it a star.
