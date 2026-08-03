# UART Top (UART_TOP)

The UART_TOP module integrates the UART Transmitter (UART_TX) and UART Receiver (UART_RX) into a complete UART communication system. It connects both modules through a shared serial line, enabling end-to-end UART data transmission and reception.

---

## Features

- Complete UART Communication System
- Integration of UART_TX and UART_RX
- Configurable Baud Rate using Prescale
- Configurable Parity
  - No Parity
  - Even Parity
  - Odd Parity
- End-to-End Data Transmission
- Functional Verification
- Modular RTL Architecture

---

## System Architecture

<p align="center">
    <img src="../../images/UART_TOP/UART_TOP_Architecture.png" width="950">
</p>

The UART_TOP module connects the transmitter and receiver together through the UART serial line.

---

## RTL Hierarchy

```
UART_TOP
│
├── UART_TX
│   ├── TX_FSM
│   ├── Serializer
│   ├── Parity Calculator
│   └── Multiplexer
│
└── UART_RX
    ├── RX_FSM
    ├── Edge Counter
    ├── Data Sampling
    ├── Majority Voting
    ├── Start Checker
    ├── Deserializer
    ├── Parity Checker
    └── Stop Checker
```

---

## Data Flow

The communication sequence is summarized as follows:

```
Parallel Data
      │
      ▼
 UART_TX
      │
      ▼
 UART Serial Line (TX_OUT → RX_IN)
      │
      ▼
 UART_RX
      │
      ▼
Recovered Parallel Data
```

---

## Verification

The complete UART system was verified by connecting the transmitter directly to the receiver and validating end-to-end communication.

The following test scenarios were successfully verified:

| Test Case | Status |
|------------|:------:|
| No Parity | ✅ |
| Even Parity | ✅ |
| Odd Parity | ✅ |
| Parity Error Detection | ✅ |
| Framing Error Detection | ✅ |
| End-to-End Communication | ✅ |

---

## Simulation Results

### Complete UART Communication

<p align="center">
    <img src="../../images/UART_TOP/UART_TOP_Waveform.png" width="950">
</p>

The waveform demonstrates successful transmission from the UART transmitter and correct reception by the UART receiver.

---

## Project Organization

```
Design-and-ASIC-Implementation-of-UART
│
├── RTL/
│
├── Verification/
│
├── docs/
│   ├── UART_TX/
│   ├── UART_RX/
│   └── UART_TOP/
│
├── images/
│
└── README.md
```

---

## Conclusion

The UART_TOP module successfully integrates the UART transmitter and receiver into a complete UART communication system. Functional verification confirms reliable end-to-end data transmission under different parity configurations while maintaining correct error detection. This implementation serves as the RTL foundation for the upcoming RTL-to-GDSII ASIC implementation flow.
