# Design and ASIC Implementation of UART

![Verilog](https://img.shields.io/badge/Language-Verilog-blue)
![Status](https://img.shields.io/badge/Stage-RTL%20%2B%20Verification-brightgreen)
![Simulator](https://img.shields.io/badge/Simulator-Xilinx%20Vivado-orange)
![License](https://img.shields.io/badge/License-MIT-lightgrey)

<p align="center">
  <img src="./images/UART_TOP/Capture.PNG" width="1000">
</p>
---

## Overview

This repository contains a fully synchronous **UART (Universal Asynchronous Receiver/Transmitter)** designed from scratch in Verilog HDL, and functionally verified through directed testbenches in **Xilinx Vivado**.

The design supports a configurable baud rate (via a `Prescale` divider), optional even/odd parity, and dedicated framing/parity error detection on the receive side. The project currently covers the **RTL design and functional verification** stages, with synthesis and physical implementation planned as the next phase of the flow.

---

## Table of Contents

- [Features](#features)
- [Architecture](#architecture)
- [Project Structure](#project-structure)
- [Module Description](#module-description)
- [Verification](#verification)
- [How to Simulate](#how-to-simulate)
- [Design Notes & Fixes](#design-notes--fixes)
- [Roadmap](#roadmap)
- [Tools](#tools)
- [Author](#author)

---

## Features

- Configurable data width (default **8 bits**) via a Verilog `parameter`.
- Configurable baud rate through a 6-bit `Prescale` input, shared between TX and RX so both sides stay in lock-step.
- Optional parity generation/checking, switchable between **even** and **odd**.
- Independent **`PARITY_ERROR`** and **`FRAMING_ERROR`** status flags on the receive path.
- Noise-tolerant reception: each bit is sampled **3 times around the bit center** and resolved by majority vote instead of a single sample point.
- Fully synchronous design, single clock domain, active-low asynchronous reset.
- Clean separation of concerns: every protocol stage (start/data/parity/stop) has its own small, testable module.

---

## Architecture


<p align="center">
<img src="./images/UART_TOP/UART_ARCH.png" width="1000">
</p>

**Transmit path:** `TX_FSM` (baud-tick driven) → `serializer` (parallel→serial shift register) → `parity_calc` → `mux` (selects start/data/parity/stop bit onto `TX_OUT`).

**Receive path:** `uart_rx_fsm` (baud-tick driven via `edge_bit_counter`) → `data_sampling` (3-sample majority vote) → `deserializer` (serial→parallel) → `start_check` / `parity_check` / `stop_check` (glitch, parity, and framing validation).

Both TX and RX divide the same system clock by `Prescale` internally, so a single shared value keeps transmitter and receiver bit timing aligned.

---

## Project Structure

```
Design-and-ASIC-Implementation-of-UART
│
├── RTL
│   ├── UART_TX
│   ├── UART_RX
│   └── UART_TOP
│
├── Verification
│   ├── UART_TX_tb
│   ├── UART_RX_tb
│   └── UART_TOP_tb
│
├── Images
│   ├── UART_TX
│   ├── UART_RX
│   └── UART_TOP
│
└── README.md
```

---

## Module Description

| Module | Role |
|---|---|
| `UART_TOP.v` | Integrates `UART_TX` and `UART_RX`, exposes a single external interface (data, control, `Prescale`, status flags). |
| `UART_TX.v` | Transmit top module: wires `TX_FSM`, `serializer`, `parity_calc`, and `mux` together. |
| `TX_FSM.v` | Drives the TX protocol states and contains the baud-rate tick generator that paces one bit every `Prescale` clock cycles. |
| `serializer.v` | Shifts the parallel input byte out one bit at a time, LSB first. |
| `mux.v` | Selects which signal (start bit, data bit, parity bit, stop bit) drives `TX_OUT` based on the current TX state. |
| `UART_RX.v` | Receive top module: wires `uart_rx_fsm`, `edge_bit_counter`, `data_sampling`, `deserializer`, and the three checker modules together. |
| `uart_rx_fsm.v` | Drives the RX protocol states (`IDLE → START → DATA → PARITY → STOP → ERROR_CHK`) and generates all internal enable strobes. |
| `edge_bit_counter.v` | Divides the system clock by `Prescale` to produce per-bit timing, and tracks which data bit is currently being received. |
| `data_sampling.v` | Samples the incoming line three times around the center of each bit and takes a majority vote, for noise immunity. |
| `deserializer.v` | Shifts sampled bits into the received data register. |
| `start_check.v` | Confirms the start bit is still low mid-bit, to reject glitches. |
| `parity_calc.v` | Computes the expected parity (even/odd) for the byte being transmitted. |
| `parity_check.v` | Compares the received parity bit against the expected value and flags `PARITY_ERROR`. |
| `stop_check.v` | Confirms the stop bit is high and flags `FRAMING_ERROR` if not. |

---
##
## Verification

The design was verified with directed, self-checking testbenches covering:

| Test Case              | Status |
| ---------------------- | ------ |
| No Parity              | ✅      |
| Even Parity            | ✅      |
| Odd Parity             | ✅      |
| Parity Error           | ✅      |
| Framing Error          | ✅      |
| Parity + Framing Error | ✅      |
| TX/RX Integration      | ✅      |

---

## Verification Results

### UART Top

<p align="center">
<img src="./images/UART_TOP/no_parity_test_case.PNG" width="900">
</p>

### UART Receiver
<p align="center">
<img src="./images/UART_RX/no_parity_test_case_RX.PNG" width="900">
</p>

### UART Transmitter
<p align="center">
<img src="./images/UART_TX/no_parity_test_case.PNG" width="900">
</p>

## Design Notes & Fixes

A few subtle timing bugs were found and fixed during bring-up, worth keeping in mind if you extend this design:

- **RX bit-count offset:** the same counter is used to time the start bit and the data bits, so the data-bit counter does not start at zero when `DATA` state begins. The exit condition for the `DATA` state accounts for this one-bit offset.
- **TX baud generation:** the transmit FSM needs its own `Prescale`-driven tick to pace state transitions and shifts; without it, the transmitter finishes a frame far faster than the receiver samples it.
- **Sticky error flags:** `PARITY_ERROR` and `FRAMING_ERROR` are cleared only at the start of a new frame, not on every cycle their enable is low — otherwise each flag is only valid for a single clock cycle and can be missed.

---

## Roadmap

- [x] RTL design
- [x] Functional verification (directed testbenches, Vivado)
- [ ] Logic synthesis
- [ ] Floorplanning & power planning
- [ ] Placement & Clock Tree Synthesis (CTS)
- [ ] Routing & timing closure
- [ ] Physical verification & GDSII generation

---

## Physical Implementation

> This section will be filled in as each stage of the ASIC flow is completed. Placeholders below are ready for screenshots, reports, and metrics.

### Synthesis
- Status: ⏳ Not started
- Tool:
- Area report:
- Timing summary (setup/hold slack):
- Gate-level netlist: `syn/netlist.v` *(to be added)*

### Floorplanning
- Status: ⏳ Not started
- Die/core size:
- Aspect ratio / utilization:
- I/O pin placement:
- Floorplan screenshot: `docs/floorplan.png` *(to be added)*

### Power Planning
- Status: ⏳ Not started
- Power ring / stripe configuration:
- IR drop analysis:

### Placement
- Status: ⏳ Not started
- Placement density:
- Congestion map: `docs/placement.png` *(to be added)*

### Clock Tree Synthesis (CTS)
- Status: ⏳ Not started
- Clock skew:
- Clock latency:

### Routing & Timing Closure
- Status: ⏳ Not started
- DRC/LVS clean: 
- Final timing signoff (WNS/TNS):
- Routed layout screenshot: `docs/routing.png` *(to be added)*

### GDSII
- Status: ⏳ Not started
- Final GDS file: `gds/uart.gds` *(to be added)*
- Chip micrograph (if fabricated):

---

## Tools

| Tool | Purpose |
|---|---|
| Verilog HDL | RTL design |
| Xilinx Vivado | Functional simulation & waveform debug |

---

## Author

Mohamed Emad

Faculty of Engineering, Zagazig University

Electronics and Communications Engineering

Digital ASIC Design & Verification Engineer
