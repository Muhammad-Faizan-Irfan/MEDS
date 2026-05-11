# Digital Design and Computer Architecture: Lecture 5

## Introduction to Hardware Description Languages (HDLs)

While standard programming languages like C++ or Java are executed sequentially, hardware operates **concurrently**. Every gate and transistor in a digital circuit evaluates simultaneously. Hardware Description Languages (HDLs), such as **Verilog** and **VHDL**, are specialized languages designed to model this concurrency, manage complex hierarchies (like billions of transistors), and interface directly with Computer-Aided Design (CAD) synthesis tools.

### Design Methodologies
- **Top-Down Design:** Start by defining the high-level system (e.g., a microprocessor), then break it down into smaller sub-modules (e.g., ALU, Control Unit, Register File), and finally down to primitive leaf cells (e.g., logic gates).
- **Bottom-Up Implementation:** Start by building and verifying the foundational primitive blocks, then combine them to build the sub-modules, scaling up to the complete top-level system. *Testing must occur at every level to isolate bugs early.*

---

## Verilog Syntax and Structure

Verilog code relies heavily on the `module` block, which defines a component's inputs, outputs, and internal behavior.

### Basic Module Definition and Multi-Bit Buses
```verilog
module example (
    input [31:0] a,  // A 32-bit input bus (MSB to LSB ordering)
    input [7:0] b,   // An 8-bit input bus
    output c         // A single-bit output
);
    // Module functionality
endmodule
```

### Bit Manipulation
Verilog provides built-in syntax for handling multi-bit signals:
- **Bit Slicing:** Selecting a portion of a bus. (e.g., `short_bus = long_bus[12:5];`)
- **Concatenation:** Joining multiple signals together using curly braces `{}`. (e.g., `{a[2], a[1], a[0]}`)
- **Duplication:** Repeating a signal multiple times. (e.g., `{4{a[0]}}` makes four copies of bit `a[0]`).

---

## Coding Styles: Structural vs. Behavioral

Verilog supports two primary modeling styles. Most practical designs use a combination of both.

### 1. Structural Modeling
Structural code explicitly defines the physical wiring and instantiation of hardware components. It describes *how* things are connected.
- Often uses predefined primitive gates (like `and`, `or`, `not`, `xor`).
- Example: Connecting the output wire of a submodule to the input port of another submodule. 

### 2. Behavioral Modeling
Behavioral code describes *what* the circuit should do logically or mathematically, relying on the synthesis tool to determine the physical gate implementation.
- Relies heavily on the `assign` keyword for continuous combinational logic.
- Uses operators like bitwise AND (`&`), bitwise OR (`|`), and conditional assignments (e.g., `assign y = s ? d1 : d0;` to build a multiplexer).
- **Warning:** Overusing high-level behavioral code without understanding the underlying hardware it implies can result in highly unoptimized, slow, or bloated physical circuits.

---

## Sequential Logic in Verilog

Combinational logic is memoryless, but sequential logic requires memory elements (like Flip-Flops) to hold state. Sequential logic is modeled using the `always` block.

### The `always` Block
Code inside an `always` block executes whenever a signal in its **sensitivity list** changes.
- **Sequential Elements (Flip-Flops):** Triggered by clock edges.
  ```verilog
  always @(posedge clk) // Executes only when the clock transitions from 0 to 1
  ```
- **Combinational Logic via Always Blocks:** Triggered by any input change.
  ```verilog
  always @(*) // The '*' automatically includes all right-hand side variables
  ```
*Note: Any signal assigned a value inside an `always` block MUST be declared as a `reg` (register) data type, even if it eventually synthesizes into a purely combinational wire.*

### Blocking vs. Non-Blocking Assignments
Inside an `always` block, you must choose how to assign values:

- **Blocking (`=`):** Evaluates and assigns sequentially, line-by-line. (Generally used for complex *combinational* logic inside an `always` block).
- **Non-Blocking (`<=`):** Evaluates all right-hand side expressions simultaneously, but updates the left-hand side variables only at the *end* of the block. (Strictly used for *sequential* logic to accurately model hardware concurrency and prevent race conditions).

---

## Implementing Finite State Machines (FSMs)

Verilog handles FSMs gracefully by splitting the machine into distinct hardware blocks:

1. **State Register:** An edge-triggered `always` block (using `<=`) that updates the `current_state` with the `next_state` at the clock edge. It should also handle synchronous or asynchronous Resets.
2. **Next State Logic:** A combinational `always` block (using `case` statements) that looks at the `current_state` and inputs to determine the `next_state`. *Always include a `default` case to prevent metastability or latch inference.*
3. **Output Logic:** An `assign` statement (or another combinational block) that determines the output based on the state (Moore) or state+inputs (Mealy).

---

## Delays and Simulation
While synthesis tools map Verilog to physical gates, developers can add arbitrary timing delays (e.g., `#5` for a 5-nanosecond delay) into the code. 
- These delays are **strictly for simulation and testbenches**. 
- They allow engineers to simulate real-world propagation delays and verify circuit behavior before manufacturing. 
- The synthesis tool completely ignores these delay markers when compiling the code to physical hardware.
