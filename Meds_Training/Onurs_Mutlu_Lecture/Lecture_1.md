## Digital Design and Computer Architecture-Lecture 1

### Course Overview and Goals

This course focuses on how modern computers work from the ground up, starting with transistors and advancing to complex systems like GPUs and machine learning accelerators.

The primary goals of the course are:

* To teach fundamental principles of digital design and architecture.
* To foster critical thinking and the ability to evaluate complex design trade-offs.
* To emphasize that achieving the highest efficiency, security, and performance requires co-designing hardware and software across the entire computing stack.
* To highlight the coupling of teaching and research, noting that mastering current technologies enables future technological innovations.

### The Transformation Hierarchy

The transformation hierarchy defines the process of orchestrating electrons to solve human problems through a series of abstraction layers.

1. Problem
2. Algorithm
3. Program
4. System Software
5. Instruction Set Architecture (ISA)
6. Microarchitecture
7. Logic
8. Devices
9. Electrons

The **Instruction Set Architecture (ISA)** acts as the critical contract and interface between software and hardware. The specific hardware implementation of a given ISA is defined as the **Microarchitecture**.

### Computing Platforms and Trade-Offs

Computing systems come in different forms to meet varying performance, efficiency, and flexibility needs.

* **CPUs (General Purpose):** Highly flexible and relatively easy to program, but lack maximum power and efficiency for specialized tasks.
* **ASICs (Special Purpose):** Custom-built for specific applications, such as machine learning accelerators (e.g., Google's TPU) or video encoding chips. They offer peak efficiency and performance but little to no flexibility.
* **GPUs:** Initially specialized for graphics, these have evolved to handle massively parallel computational workloads efficiently.
* **FPGAs:** Reconfigurable hardware that balances general-purpose flexibility with specialized performance capabilities.

### Transistors as Switches

Transistors serve as the foundational building blocks of modern digital systems. The course abstracts their complex electrical properties into simple *on/off* wall switches.

* **N-Type (NMOS):** Closes the circuit (acts as a wire) when a high voltage (logical 1) is applied to the gate. NMOS transistors are highly effective at pulling output voltages down to zero.
* **P-Type (PMOS):** Closes the circuit when a low voltage (logical 0) is applied to the gate. PMOS transistors are highly effective at pulling output voltages up to high levels.

### Building Logic Gates (CMOS)

Digital logic gates are created by combining NMOS and PMOS transistors into **Complementary Metal-Oxide-Semiconductor (CMOS)** structures.

CMOS networks follow a general structural rule:

* A PMOS pull-up network connects to high voltage.
* An NMOS pull-down network connects to low voltage.

#### Basic Gates

* **NOT Gate (Inverter):** Built with one PMOS pulling up and one NMOS pulling down, cleanly inverting the input signal.
* **NAND Gate:** Constructed using two PMOS transistors in parallel and two NMOS transistors in series. It outputs a `0` only when both inputs are `1`.
* **AND Gate:** Created by attaching a NOT gate to the output of a NAND gate. Physical transistor limitations prevent building an efficient AND gate directly without this inversion step.

