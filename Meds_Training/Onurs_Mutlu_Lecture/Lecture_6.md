# Digital Design and Computer Architecture: Lecture 6

## Circuit Timing and Real-World Constraints

The digital logic abstraction often assumes that outputs change instantly when inputs change. However, in physical hardware, transistors take a finite amount of time to switch. This delay is fundamentally caused by parasitic capacitance and resistance inherent in physical wires and transistors. 

### Types of Delay
There are two primary metrics used to characterize the delay of a combinational circuit:

*   **Contamination Delay ($t_{cd}$):** The absolute minimum amount of time required for the output to *start* changing after an input changes. It is calculated by finding the **shortest path** through the logic circuit.
*   **Propagation Delay ($t_{pd}$):** The maximum amount of time required for the output to *finish* changing and stabilize after an input changes. It is calculated by finding the **longest (critical) path** through the logic circuit.

Delay is highly sensitive to environmental and physical factors:
*   **Voltage:** Higher supply voltages generally decrease delay (at the cost of power).
*   **Temperature:** Higher temperatures increase resistance, thereby increasing delay.
*   **Manufacturing Variations:** Two identical gates on the same chip might have slightly different physical delays due to microscopic manufacturing inconsistencies.

### Glitches
A glitch occurs when a single input transition causes multiple, temporary output transitions before the output settles to its final correct value. This happens when there are multiple paths from an input to an output, and these paths have different propagation delays. While glitches resolve themselves eventually, they cause unnecessary power consumption (dynamic power dissipation). Moore FSMs are generally less susceptible to propagating glitches than Mealy FSMs.

---

## Sequential Circuit Timing

In sequential circuits, the timing of the flip-flops (state registers) becomes the most critical factor for ensuring correct operation. 

### Flip-Flop Timing Requirements
For a flip-flop to reliably sample incoming data at the active clock edge, the data must remain perfectly stable during a critical window called the **aperture time**.
*   **Setup Time ($t_{setup}$):** The minimum time the data input must remain stable *before* the active clock edge.
*   **Hold Time ($t_{hold}$):** The minimum time the data input must remain stable *after* the active clock edge.
Violating either of these constraints results in **metastability**, where the flip-flop output gets "stuck" between a logical 1 and 0 for an unpredictable amount of time, corrupting the system state.

Like combinational logic, flip-flops also have internal delays:
*   **Clock-to-Q Contamination Delay ($t_{ccq}$):** The time after the clock edge until the output $Q$ *starts* to change.
*   **Clock-to-Q Propagation Delay ($t_{pcq}$):** The time after the clock edge until the output $Q$ *finishes* changing.

### Meeting Timing Constraints
When designing a synchronous system (Flip-Flop -> Combinational Logic -> Flip-Flop), two mathematical constraints must be met:

1.  **The Setup Time Constraint (Defines Clock Frequency):**
    The clock period must be long enough to accommodate the flip-flop's internal delay, the worst-case combinational logic delay, and the setup time of the receiving flip-flop.
    $$T_{clock} \ge t_{pcq} + t_{pd} + t_{setup}$$
    *If violated:* Reduce the clock frequency (increase $T_{clock}$), or simplify the critical path of the combinational logic.

2.  **The Hold Time Constraint:**
    The combinational logic must be slow enough to ensure the data input to the next flip-flop does not change before the hold time requirement is met.
    $$t_{ccq} + t_{cd} \ge t_{hold}$$
    *If violated:* You cannot fix this by slowing down the clock. You must physically redesign the circuit to add artificial delay (like inserting non-inverting buffers) to the shortest path.

### Clock Skew
Clock skew occurs when the clock signal arrives at different flip-flops at slightly different times due to wire lengths and routing delays. 
*   Skew inherently increases the required setup and hold times, severely eating into the "useful work" portion of the clock cycle.
*   Designers use specialized, balanced "clock trees" (like H-trees) to distribute the clock signal evenly across the chip to minimize skew.

---

## Circuit Verification and Testbenches

Verification is the process of proving that a circuit works as intended. In modern processor design, up to 70% of the engineering time is spent entirely on verification. 

### Functional Verification
Functional verification ignores physical timing (setup/hold times) and checks only if the logic outputs the correct values for given inputs. It is performed extensively using high-level HDL simulators (like Xilinx Vivado).

A **Testbench** is an HDL module written strictly for simulation purposes. It instantiates the "Device Under Test" (DUT), provides it with input patterns (test vectors), and monitors the outputs.

#### Testbench Strategies
1.  **Simple Testbench:** The designer manually hardcodes specific input values, applies delays, and visually inspects the resulting waveform diagrams. (Not scalable).
2.  **Self-Checking Testbench:** The testbench automatically compares the DUT's output against hardcoded expected values and prints error messages to the console.
3.  **Test Vector Files:** Inputs and expected outputs are loaded from a text file, allowing the testbench to loop through thousands of test cases automatically.
4.  **Golden Model Automated Testing:** The ultimate standard. A high-level, mathematically perfect software model of the system (the "Golden Model") is written (often in C++ or Python). The testbench feeds random, edge-case, or sequential inputs to *both* the DUT and the Golden Model simultaneously and automatically flags any discrepancy in their outputs.

### Design Principles for Performance
*   **Optimize the Critical Path:** The longest logic delay dictates the maximum possible speed of the entire system.
*   **Balance the Design:** Ensure that all combinational logic blocks between flip-flops have roughly the same delay. A single slow path will bottleneck the whole chip.
*   **Optimize for the Common Case:** Design the architecture so that the most frequent operations happen as quickly and efficiently as possible, while ensuring edge cases are handled safely (even if slowly).
