# Digital Design and Computer Architecture: Lecture 4

## Sequential Logic and Finite State Machines (FSMs)

Building on previous lectures, this section finalizes the design of sequential logic, focusing heavily on **Finite State Machines (FSMs)**.

### Synchronous vs. Asynchronous Systems
- **Synchronous:** Uses a global clock signal. State transitions occur strictly at the clock edge (e.g., the rising edge). This makes complex systems manageable and predictable.
- **Asynchronous:** Operates without a clock. State transitions occur dynamically based on input changes. While potentially faster, these systems are highly prone to race conditions and are extremely difficult to design at scale.

### FSM Components
An FSM is a discrete-time model of a stateful system. It requires three core hardware components:
1.  **State Register:** Stores the current state. Built using **D Flip-Flops** (which are edge-triggered) rather than simple Latches (which are level-triggered and "transparent"). This ensures the state is stable for the full duration of the clock cycle.
2.  **Next State Logic:** Combinational logic that calculates what the *next* state will be, based on the *current* state and the system inputs.
3.  **Output Logic:** Combinational logic that calculates the system's output.

### Moore vs. Mealy FSMs
There are two primary ways to design an FSM, categorized by how outputs are generated:
-   **Moore Machine:** Outputs depend *solely* on the current state.
-   **Mealy Machine:** Outputs depend on *both* the current state and the current inputs. (Often requires fewer states but involves more complex output logic).

### FSM Design Example: Smart Traffic Light
The lecture steps through designing a Moore FSM for a traffic light controller:
1.  **State Transition Diagram:** Draw circles (states) and arrows (transitions based on inputs like traffic sensors). Always include a **Reset** state to establish a known starting point upon power-up.
2.  **State Transition Table (Truth Table):** Convert the diagram into a tabular format showing Current State, Inputs, and Next State.
3.  **State Encoding:** Assign binary values to the states.
    -   *Binary Encoding:* Uses the minimum number of bits (e.g., 2 bits for 4 states). Minimizes flip-flops but increases logic complexity.
    -   *One-Hot Encoding:* Uses one bit per state (e.g., 4 bits for 4 states). Maximizes flip-flops but drastically simplifies next-state logic.
    -   *Output Encoding:* States are encoded to match the desired outputs directly, simplifying output logic.
4.  **Boolean Simplification:** Derive Boolean equations (Sum of Products) for the next-state and output logic, and simplify them using theorems or Karnaugh maps.

### Timing Considerations
For a synchronous FSM to work correctly, the **clock cycle** must be long enough to accommodate the worst-case delay of the combinational logic. If the clock is too fast, the next state won't be calculated in time, leading to system failure.

---

## Lab Overview and Introduction to FPGAs

The second half of the session shifts focus to the practical, hands-on portion of the course.

### The Goal of the Labs
Over 10 lab sessions, students will progressively build a fully functional **32-bit MIPS Microprocessor**.

### Field Programmable Gate Arrays (FPGAs)
An FPGA is a software-reconfigurable hardware substrate. It allows engineers to map custom digital circuits directly onto physical hardware without the immense cost of fabricating custom silicon (ASICs).

**Core Components of an FPGA:**
-   **Lookup Tables (LUTs):** Small memory blocks used to implement arbitrary Boolean logic functions (acting as the combinational logic).
-   **Switch Boxes/Interconnects:** Programmable routing networks that connect the LUTs together.
-   **I/O Blocks:** Connect the internal logic to physical pins, LEDs, switches, and displays on the board.
-   **Hard Blocks:** Some FPGAs include pre-built, highly optimized silicon for complex tasks like multipliers, DSP slices, or even full ARM processors to improve efficiency.

**FPGA Pros and Cons:**
-   *Advantages:* High performance/concurrency compared to software (CPUs), rapid prototyping, and reusability.
-   *Disadvantages:* Slower, less power-efficient, and consumes more physical area than a dedicated ASIC.

### Computer-Aided Design (CAD) Flow
Programming an FPGA involves a complex software toolchain (like Xilinx Vivado).
1.  **Hardware Description Language (HDL):** Code is written in Verilog or VHDL.
2.  **Logic Synthesis:** The tool translates the HDL into low-level logic gates.
3.  **Placement and Routing:** The tool maps the logic to specific LUTs on the physical FPGA chip and calculates the best pathways to connect them via switch boxes.
4.  **Bitstream Generation:** The tool outputs a final binary file (bitstream) that is flashed onto the FPGA to configure the hardware.

---

## Hardware Description Languages (HDL) and Verilog

To handle the complexity of billions of transistors, engineers use HDLs to describe circuits through code rather than drawing schematics.

### Why HDLs instead of C/C++ or Python?
Standard programming languages execute sequentially. Digital hardware operates **concurrently** (everything happens at the same time). HDLs are specifically built to model parallel hardware structures, wires, gates, and clock edges.

### Verilog Fundamentals
Verilog uses a hierarchical, modular design approach (Top-Down planning, Bottom-Up implementation).

**The `module` Keyword:**
A module is the fundamental building block in Verilog. It requires a name and a defined list of ports (inputs and outputs).

**Syntax Example:**
```verilog
module example_module (
    input a,
    input b,
    input c,
    output y
);
    // Functionality goes here
endmodule
```

**Multi-bit Signals (Buses):**
Defined using a range `[MSB:LSB]` (Most Significant Bit to Least Significant Bit).
```verilog
input [31:0] data_in; // A 32-bit input bus
output [7:0] byte_out; // An 8-bit output bus
```
