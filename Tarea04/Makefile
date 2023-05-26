all:
	iverilog -o SPI.out testbench.v
	vvp SPI.out
	gtkwave SPI.vcd

clean:
	 rm SPI.out SPI.vcd
	 
