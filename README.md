# Single-Cycle-RISCV-Processor

This processor uses a word length of 32 bits of data to support the RISCV 32-bit instruction set. It uses 32 general-use registers arranged in a register file. The following is a short description of each RTL component all encoded in SystemVerilog:

-Program Counter: risc_pc
	 outputs a 32-bit address to the instruction memory to fetch the next instruction every positive edge of the clock. The next instruction address is the sum of the current address and an integer 4 or a 32-bit offset from the immediate generator either of which depends on the input pc_src. The address offset is shifted once to the left before being added to the current address.

-ALU: risc_alu
	combinationally outputs the result of two 32-bit inputs whose operation depends on the control signal alu_op. For instructions who don't use the ALU, an add operation is coded as a default. A separate combinational block is used to compute whether operandA is equal to operand B for the zero signal.

-Immediate Extension: risc_imm
	takes in the instruction from the instruction memory as an input and combinationally outputs a 32-bit immediate as either an operand or address offset. The immediate extension extracts the immediate field of an instruction per its input imm_src (that depends on the instruction encoding type). This component also sign extends the extracted immediate to a 32-bit output.

-Controller: risc_comb_controller
	outputs control signals to the riscv components depending on its input opcode. Branch instructions BEQ and BNE are distinguised through their funct3. The controller in this case is written through an array where individual control signals are concatenated. The arrangement of the array is: wr_en, alu_src, pc_src, imm_src (2 bits), mem_write, mem_to_reg (2 bits). When a control signal is to be a 'dont care' the controller defaults to a '0'. 
	a separate block is used to determine alu_op. Funct7 is used to distinguis the sub instruction from the rest of the r and i type encodings, and the funct 3 is used to determine the operation. The add operation is defaulted for instructions who dont use the ALU output.
