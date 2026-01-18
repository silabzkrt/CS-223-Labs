# CS-223 Digital Design Labs

My lab work completed as part of CS 223 Digital Design and Computer Architecture Course (Fall 2025-2026) at Bilkent University.

## Overview

This repository contains four comprehensive laboratory projects that progressively build digital design skills from basic combinational circuits to complex sequential systems and finite state machines. All projects were designed and simulated using **Xilinx Vivado** and implemented using **SystemVerilog** on **Basys3 FPGA boards**.

---

## Lab 1: Combinational Logic - Adders and Subtractors

**Topics Covered:**
- Combinational logic design
- Half adders and full adders
- Half subtractors and full subtractors
- Multi-bit arithmetic circuits
- Modular design and hierarchical instantiation

**Skills Developed:**
- SystemVerilog module design and instantiation
- Boolean algebra implementation
- Testbench development and simulation
- Hardware synthesis and implementation on FPGA
- Understanding of carry and borrow propagation

**Key Modules:**
- `half_adder.sv` - Basic half adder implementation
- `full_adder.sv` - Full adder with carry-in/carry-out
- `2_bit_fulladder.sv` - Multi-bit addition circuit
- `half_subtractor.sv` - Basic half subtractor
- `full_subtractor.sv` - Complete subtractor using half subtractors
- `make_negative.sv` - Two's complement implementation
- `full_adder_swnled.sv` - FPGA interface with switches and LEDs

**Implementation Details:**
- Used structural modeling to build full adders/subtractors from half adders/subtractors
- Implemented 2-bit arithmetic operations with borrow/carry handling
- Created testbenches for functional verification
- Successfully synthesized and tested on Basys3 board

---

## Lab 2: Multiplexers, Decoders, and Combinational Functions

**Topics Covered:**
- Multiplexer (MUX) design and applications
- Decoder implementation
- Hierarchical circuit design
- Logic function implementation using MUXs
- Bit manipulation circuits

**Skills Developed:**
- Building complex circuits from simpler components
- N-to-1 multiplexer design (2:1, 4:1, 8:1)
- M-to-N decoder implementation (2:4, 3:8)
- Using MUXs to implement arbitrary logic functions
- Systematic testbench development

**Key Modules:**
- `mux_2to1.sv`, `mux_4to1.sv`, `mux_8to1.sv` - Multiplexer hierarchy
- `decoder_2to4.sv`, `decoder_3to8.sv` - Decoder implementations
- `bit_shifter.sv` - Bit shifting operations
- `function_g.sv`, `logicfunc.sv` - Custom logic function implementations
- Multiple comprehensive testbenches (`tb_*.sv`)

**Implementation Details:**
- Built 8:1 MUX hierarchically using 4:1 and 2:1 MUXs
- Constructed 3:8 decoder from two 2:4 decoders with enable logic
- Implemented custom logic functions using MUX-based design
- Created bit shifter for data manipulation
- Extensive simulation with various input combinations

---

## Lab 3: Sequential Logic - Registers and Clocked Circuits

**Topics Covered:**
- Sequential circuit design
- D flip-flops and registers
- Clock synchronization and clock dividers
- Shift registers (left, right, rotate)
- Parallel load and serial input
- Seven-segment display interfacing
- Multifunction register operations

**Skills Developed:**
- Synchronous circuit design with clocks and resets
- Register transfer level (RTL) coding
- Clock domain management and frequency division
- State retention and sequential operations
- Timing analysis and metastability awareness
- Display multiplexing and encoding

**Key Modules:**
- `d_flipflop.sv` - Basic D flip-flop with reset
- `multifunction_register.sv` - 8-bit register with multiple operations:
  - Hold current value
  - Shift right (with serial input)
  - Shift left  
  - Parallel load
  - Rotate left
  - Rotate right
- `clock_divider.sv` - Clock frequency divider for display
- `hexadecimal_7segment.sv` - 7-segment decoder for hex display
- `8_to1mux.sv` - MUX for operation selection

**Implementation Details:**
- Implemented 8-bit multifunction register using D flip-flops and 8:1 multiplexers
- Each bit has independent MUX for operation selection (3-bit select signal)
- Operations: Hold, Shift L/R, Rotate L/R, Parallel Load
- Integrated with 7-segment display for visual output
- Clock divider to slow down operations for observation
- Comprehensive testbenches for all operations

---

## Lab 4: Finite State Machines - Parking System Controller

**Topics Covered:**
- Finite state machine (FSM) design
- Moore and Mealy machine implementations
- State encoding and transition logic
- Datapath and control path separation
- Timer and counter design
- Queue management
- Button debouncing
- Multi-zone parallel FSMs

**Skills Developed:**
- FSM design methodology (state diagram → SystemVerilog)
- Complex control logic implementation
- Synchronous timer design with enable signals
- Real-time system modeling
- Resource allocation algorithms
- LED control and blinking patterns
- Seven-segment display driver
- Modular FSM design for scalability

**Key Modules:**
- `ParkingSystem.sv` - Top-level module integrating 4 parking zones:
  - **Compact Zone** (5s parking duration)
  - **SUV Zone** (8s parking duration)
  - **Electric Zone** (10s parking duration)
  - **VIP Zone** (12s parking duration)
- `Parkingsystem_FSM.sv` - Generic 5-state FSM for parking zone control:
  - IDLE → START_TIMER → BUSY → DONE → CHECK_Q → (IDLE or START_TIMER)
- `Debouncer.sv` - Button debouncing for reliable input

**System Features:**
- **4 Independent Zones**: Each with its own FSM, timer, and queue
- **Queue Management**: Vehicles wait in queue when zone is occupied
- **Visual Feedback**: 
  - LEDs show zone status (solid = free, blinking = occupied)
  - 7-segment display shows total occupied spots
- **Clock Management**: 100MHz → 1Hz conversion for real-time operation
- **Debounced Inputs**: Clean button press detection
- **Scalable Architecture**: Easy to add more zones or modify timers

**Implementation Details:**
- Used Moore FSM for predictable state-based outputs
- Separated control logic (FSM) from datapath (timers, counters)
- Implemented LED blinking using toggle signal at 1Hz
- Queue automatically decrements when parking completes and queue exists
- Reset functionality returns all zones to IDLE
- Successfully tested with multiple simultaneous vehicle arrivals

---

## Tools and Technologies

- **HDL**: SystemVerilog
- **IDE**: Xilinx Vivado Design Suite
- **Target Hardware**: Basys3 Artix-7 FPGA Board
- **Simulation**: Vivado Simulator
- **Synthesis**: Vivado Synthesis
- **Implementation**: Vivado Implementation (Place & Route)

---

## Key Concepts Demonstrated

### Combinational Logic (Labs 1-2)
- Boolean algebra and logic gates
- Arithmetic circuits (adders, subtractors)
- Data selection and routing (multiplexers)
- Data distribution (decoders)
- Hierarchical design methodology

### Sequential Logic (Lab 3)
- Clock-synchronized operations
- Storage elements (flip-flops, registers)
- State retention and data shifting
- Timing constraints and setup/hold times

### State Machines (Lab 4)
- FSM design and implementation
- State encoding and optimization
- Control and datapath separation
- Real-time system modeling
- Resource management algorithms

### FPGA Implementation Skills
- Constraint file creation (.xdc)
- Pin assignment and I/O planning
- Timing analysis and closure
- On-board debugging with LEDs and 7-segment displays
- Clock domain crossing and management

---

## Learning Outcomes

Through these labs, I developed comprehensive skills in:
1. **Digital Design Fundamentals**: From gates to complex systems
2. **HDL Programming**: SystemVerilog for synthesis and simulation
3. **FPGA Development**: Complete design flow from RTL to bitstream
4. **Verification**: Testbench design and functional simulation
5. **System Architecture**: Modular, hierarchical, and scalable design
6. **Hardware Debugging**: Using on-board resources for verification
7. **Documentation**: Clear commenting and design documentation

---

## Repository Structure

```
CS-223-Labs/
├── Lab 1/          # Combinational circuits (adders/subtractors)
├── Lab 2/          # Multiplexers and decoders
├── Lab 3/          # Sequential circuits (registers)
├── Lab 4/          # Finite state machines (parking system)
└── README.md       # This file
```

---

**Course**: CS 223 - Digital Design and Computer Architecture  
**Institution**: Bilkent University  
**Semester**: Fall 2025-2026  
**Author**: Sıla Bozkurt
