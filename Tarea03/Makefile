all:
	iverilog -o Cajero.out testbench.v
	vvp Cajero.out
	gtkwave Cajero.vcd

clean:
	 rm Cajero.out Cajero.vcd
	 
