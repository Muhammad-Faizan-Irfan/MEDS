# Digital Design and Computer Architecture - lecture 2

## Boolean Algebra and Logic Simplification

Boolean algebra provides the theoretical foundation for representing and simplifying logic circuits. It operates on two values (0 and 1) using operations like AND, OR, and NOT.

### Why Simplify?

Different Boolean expressions can represent the exact same logic function, but they lead to different hardware implementations. Simplifying expressions helps minimize the resulting circuit, leading to:

* Reduced Area
* Lower Power Consumption
* Improved Latency (Speed)

### Key Laws and Theorems

* **Commutative, Associative, and Distributive Laws:** Similar to regular algebra but applied to AND/OR.
* **Identity and Complement:** `A + 0 = A`, `A + A' = 1`, `A \\\* 1 = A`, `A \\\* A' = 0`.
* **Duality:** Any true Boolean theorem remains true if you swap ANDs with ORs, and 1s with 0s.
* **Simplification Theorems:** For example, the Uniting Theorem (`X\\\*Y + X\\\*Y' = X`).
* **DeMorgan’s Laws:** `(A + B)' = A' \\\* B'` and `(A \\\* B)' = A' + B'`. These are incredibly useful for converting between different gate types (like changing an AND-heavy design to use NOR gates).

### Canonical Forms

To methodically design and minimize circuits, we start from a standardized (canonical) representation derived from a truth table.

#### Sum of Products (SOP)

* Expresses the function as an **OR** of all **AND** terms (Minterms) that result in an output of 1.
* A **Minterm** is a product of all input variables (e.g., `A\\\*B'\\\*C`).
* *Example notation:* $F(A,B,C) = \\sum m(3,4,5,6,7)$

#### Product of Sums (POS)

* Expresses the function as an **AND** of all **OR** terms (Maxterms) that result in an output of 0.
* A **Maxterm** is a sum of all input variables (e.g., `A + B' + C`).
* *Example notation:* $F(A,B,C) = \\prod M(0,1,2)$

## Combinational Logic Blocks

Combinational logic circuits are memoryless; their outputs depend purely on the current combination of inputs. To manage the complexity of millions of transistors, designers build hierarchical modules.

### Decoders

A decoder is an input pattern detector.

* It takes an $N$-bit input and has $2^N$ outputs.
* Only exactly *one* output is active (logical 1) at a time, corresponding to the binary value of the input.
* **Use cases:** Memory address decoding (selecting which row of memory to read) or instruction decoding (interpreting an opcode to trigger the right CPU operation).

### Multiplexers (Mux)

A multiplexer is a digital selector switch.

* It takes multiple data inputs and a set of select inputs.
* The select inputs determine which data input is routed to the output.
* **Use cases:** Selecting which result to write to a register, or implementing arbitrary logic functions (acting as a basic Lookup Table).

### Adders

* **Full Adder:** Adds two 1-bit binary numbers plus a carry-in bit, outputting a sum bit and a carry-out bit.
* **Ripple Carry Adder (RCA):** Chaining multiple 1-bit full adders together to add multi-bit numbers (e.g., a 4-bit adder). The carry bit "ripples" from the least significant bit to the most significant bit.
* *Performance Note:* RCAs are slow because of the carry propagation delay. Advanced designs, like the **Carry Lookahead Adder**, use complex logic to calculate carry bits in parallel, greatly speeding up the addition.

### Programmable Logic Arrays (PLAs)

A PLA is a reconfigurable piece of hardware that directly maps to the Sum of Products (SOP) form.

* It consists of an array of AND gates (to compute all possible minterms) followed by an array of OR gates.
* The connections between the inputs, the AND gates, and the OR gates are programmable.
* **Advantage:** Highly flexible. A single PLA can be programmed to act as an adder, a multiplier, or any other logic function without changing the underlying physical hardware.

