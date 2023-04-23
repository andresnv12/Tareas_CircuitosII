all: one two three

one:
	 yosys -s Sumador4Bits.ys
two:
	 iverilog -o Sumador4bits.out testbench4Bits.v
	 vvp Sumador4bits.out
	 gtkwave Sumador4Bits.vcd
three:
	 iverilog -o Sumador4bits.out testbench4BitsND.v
	 vvp Sumador4bits.out
	 gtkwave Sumador4Bits.vcd
clean:
	 rm Sumador4bits.out Sumador4Bits.vcd
	 
