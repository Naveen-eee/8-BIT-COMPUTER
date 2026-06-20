# 8-BIT-COMPUTER
OBJECTIVE
  The objective of this project is to design, simulate, verify, and implement an 8-Bit Harvard-Inspired Computer Architecture using Verilog Hardware Description Language (Verilog HDL). The processor is based on a shared-bus organization and consists of fundamental computing modules including the Program Counter (PC), Instruction Register (IR), Memory Address Register (MAR), Instruction RAM, Data RAM, A Register, B Register, Arithmetic Logic Unit (ALU), Flag Register, Output Register, and an FSM-based Control Unit. The architecture is designed to execute a custom Instruction Set Architecture (ISA) capable of performing arithmetic, logical, data transfer, and input/output operations. The complete design is functionally verified through simulation and targeted for implementation on an FPGA development board to demonstrate real-time hardware execution.

  SYSTEM ARCHITECTURE
  
<img width="894" height="1266" alt="image" src="https://github.com/user-attachments/assets/9f82e041-3862-492a-a422-a1d37d517a98" />

The proposed 8-bit computer architecture follows a Harvard-inspired memory organization with separate Instruction RAM and Data RAM. The Program Counter (PC) generates instruction addresses for Instruction RAM, while the Instruction Register (IR) stores the fetched instruction and separates it into opcode and operand fields. The Control Unit decodes the opcode and generates the necessary control signals for instruction execution. The Memory Address Register (MAR) stores memory addresses used for Data RAM access.
The architecture consists of A Register and B Register for operand storage, an Arithmetic Logic Unit (ALU) for arithmetic and logical operations, and a Flag Register for status monitoring. An Input Register is used to receive external data, while a DMA Controller enables direct data transfer between peripherals and memory when required. All modules communicate through a shared 8-bit internal bus. The final result is stored in the Output Register and displayed on the FPGA board through a Binary-to-BCD Converter and Seven-Segment Display interface.



                                                                     **   Module List **
•	Program Counter (PC)
•	Instruction Register (IR)
•	Memory Address Register (MAR)
•	Instruction RAM
•	Data RAM
•	A Register
•	B Register
•	Arithmetic Logic Unit (ALU)
•	Flag Register
•	Input Register
•	Output Register
•	DMA Controller
•	Control Unit (FSM)
•	Binary-to-BCD Converter
•	Seven-Segment Decoder

                                                            **Instruction Set Architecture (ISA)**
| Opcode | Instruction | Description                                                        |
| ------ | ----------- | ------------------------------------------------------------------ |
| `0000` | NOP         | No operation. Processor proceeds to the next instruction.          |
| `0001` | LDA addr    | Load data from memory address `addr` into the Accumulator (AC).    |
| `0010` | STA addr    | Store the contents of the Accumulator into memory address `addr`.  |
| `0011` | INP         | Read data from the input register into the Accumulator.            |
| `0100` | OUT         | Transfer the contents of the Accumulator to the output register.   |
| `0101` | ADD addr    | Add data from memory address `addr` to the Accumulator.            |
| `0110` | SUB addr    | Subtract data at memory address `addr` from the Accumulator.       |
| `0111` | INC         | Increment the Accumulator by 1.                                    |
| `1000` | DEC         | Decrement the Accumulator by 1.                                    |
| `1001` | AND addr    | Perform bitwise AND between Accumulator and memory data at `addr`. |
| `1010` | OR addr     | Perform bitwise OR between Accumulator and memory data at `addr`.  |
| `1011` | XOR addr    | Perform bitwise XOR between Accumulator and memory data at `addr`. |
| `1100` | JMP addr    | Unconditionally jump to memory address `addr`.                     |
| `1101` | JZ addr     | Jump to address `addr` if the Zero Flag (Z) is set.                |
| `1110` | JC addr     | Jump to address `addr` if the Carry Flag (C) is set.               |
| `1111` | HLT         | Halt processor execution.                                          |


                                                                        **Working Principle**
	The proposed processor operates using the Fetch–Decode–Execute cycle. During the fetch stage, the Program Counter (PC) generates the address of the next instruction, which is retrieved from Instruction RAM and loaded into the Instruction Register (IR). The IR separates the instruction into opcode and operand fields. The opcode is sent to the Control Unit for decoding, while the operand is used as a memory address when required.
During the execute stage, the Control Unit generates the necessary control signals to enable data transfer between registers, memory, and the ALU through the shared bus. Arithmetic and logical instructions are executed by the ALU, while memory instructions access Data RAM through the Memory Address Register (MAR). The resulting data is stored in registers or memory as required. For output operations, data is transferred to the Output Register and displayed on the seven-segment display. The processor continues executing instructions sequentially until a Halt (HLT) instruction is encountered.




