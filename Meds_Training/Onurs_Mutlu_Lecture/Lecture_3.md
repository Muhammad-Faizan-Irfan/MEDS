# Digital Design and Computer Architecture: Lecture 3

## CMOS Transistors and Power Consumption

The lecture begins with a review of transistor-level implementation and the physical properties of circuits. 

* **CMOS Gate Structure:**
    * **PMOS Transistors:** Used in the pull-up network (connected to high voltage) because they are excellent at passing logical `1`s (using holes).
    * **NMOS Transistors:** Used in the pull-down network (connected to ground) because they are excellent at passing logical `0`s (using electrons).
    * *Note on Latency:* Transistors arranged in series increase resistance and delay, making them slower than parallel arrangements.
* **Power Consumption:**
    * **Dynamic Power:** Power consumed during the active switching of gates (charging and discharging capacitors). Governed by the equation $P = C \cdot V^2 \cdot f$ (where $C$ is capacitance, $V$ is voltage, and $f$ is frequency). Voltage has a cubical effect on power because higher frequencies usually require higher voltages.
    * **Static Power:** Power consumed due to leakage current even when the transistor is not actively switching. 
* **Moore's Law:** The observation (from Gordon Moore's 1965 paper) that the number of transistors on an integrated circuit doubles approximately every two years, driving down costs and increasing computational power, despite growing manufacturing complexities.

## Boolean Algebra and Logic Simplification

Boolean algebra is the mathematical foundation for analyzing and minimizing digital circuits.

* **Key Concepts and Rules:**
    * **Duality:** Every Boolean axiom has a dual. Swapping ANDs with ORs, and `1`s with `0`s, produces another valid theorem.
    * **DeMorgan's Laws:** Allow for the conversion between AND and OR gates by inverting inputs and outputs. 
    * **Bubble Pushing:** A visual trick utilizing DeMorgan's laws. For example, pushing the inversion bubble from a NAND gate's output to its inputs transforms it into an OR gate with inverted inputs.

### Canonical Forms
Standardized representations of truth tables allow for methodical circuit simplification.

* **Sum of Products (SOP):** 
    * Expresses a function as an **OR** of **AND** terms (Minterms).
    * A **Minterm** includes all variables and evaluates to `1` for exactly one row of the truth table.
* **Product of Sums (POS):** 
    * Expresses a function as an **AND** of **OR** terms (Maxterms).
    * A **Maxterm** includes all variables and evaluates to `0` for exactly one row of the truth table.

## Combinational Logic Blocks

Combinational circuits are "memoryless." Their outputs depend exclusively on the current combination of inputs.

* **Decoders:**
    * A pattern detector that takes $N$ inputs and asserts exactly one of its $2^N$ outputs. 
    * **Use Cases:** Address decoding in memory arrays, or op-code decoding to determine which instruction a CPU should execute.
* **Multiplexers (Muxes):**
    * A selector that uses control lines to choose one of many data inputs to pass to the output.
    * **Use Cases:** Selecting data paths, or serving as a **Lookup Table (LUT)** to perform arbitrary Boolean logic (the foundational mechanism of FPGAs).
* **Adders:**
    * **Ripple Carry Adder:** Chains multiple 1-bit full adders together. It is simple but slow because the carry bit must "ripple" sequentially through each adder stage.
    * **Carry Lookahead Adder:** Accelerates addition by using parallel logic to compute carry bits simultaneously, minimizing latency.
* **Programmable Logic Arrays (PLAs):**
    * A hardware realization of the Sum of Products (SOP) form. 
    * Consists of an array of AND gates (to compute minterms) connected to an array of OR gates. The connections are programmable, allowing the PLA to implement any arbitrary logic function.

## Sequential Logic and State Elements

Unlike combinational logic, **sequential logic** incorporates memory. Its output depends on both current inputs and the history of past inputs (the "state").

* **Finite State Machines (FSMs):** A discrete-time model consisting of a finite number of states, explicit transition rules (Next State Logic), outputs, and a State Register.
* **Synchronous vs. Asynchronous:** Modern computers are overwhelmingly **synchronous**, relying on a global clock signal to dictate exactly when state transitions occur. This avoids the chaotic race conditions found in unclocked (asynchronous) designs.

### The Evolution of Storage Elements

* **Cross-Coupled Inverters:** The simplest storage mechanism, but lacks inputs to safely alter its state.
* **RS Latch:** Uses Set (`S`) and Reset (`R`) inputs. Setting both to `0` simultaneously is forbidden as it causes logical contradictions and metastability.
* **Gated D Latch:** Solves the RS latch flaw by using a single Data (`D`) input and a Write Enable signal. However, it is "level-triggered" (transparent), meaning the output can change chaotically multiple times if the input changes while the enable signal is high.
* **D Flip-Flop:** Built using two D latches in a master-slave configuration. It is **edge-triggered**, meaning it captures data *only* at the precise moment the clock signal transitions from `0` to `1` (positive edge). This ensures perfectly stable state registers for synchronous FSMs.
