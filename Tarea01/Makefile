all: one two three

one:
	 iverilog -o Sumador4bits.out testbench4Bits.v
	 vvp Sumador4bits.out
	 gtkwave Sumador4Bits.vcd
two:
	 iverilog -o Sumador8bits.out testbench8Bits.v
	 vvp Sumador8bits.out
	 gtkwave Sumador8Bits.vcd
three:
	 iverilog -o Sumador32bits.out testbench32Bits.v
	 vvp Sumador32bits.out
	 gtkwave Sumador32Bits.vcd
clean:
	 rm Sumador4bits.out Sumador4Bits.vcd
	 rm Sumador8bits.out Sumador8Bits.vcd
	 rm Sumador32bits.out Sumador32Bits.vcd
