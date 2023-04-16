/* Universidad de Costa Rica
   Escuela de Ingeniería Eléctrica | Circuitos Digitales II - IE0523
   Profesor: Enrique Coen | Asistente: Ana Eugenia Sánchez
   Estudiante: Andrés Chaves Vargas | Carné: B92198 
*/

`include "probador32Bits.v"
`include "Sumador32Bits.v"
                                        
module Sumador32Bits_tb;

  wire c2RCO, c2CLK, c2ENB, c2RCI;
  wire [1:0]c2MODO;
  wire [31:0] c2A, c2B, c2Q; 
  
  initial begin
	$dumpfile("Sumador32Bits.vcd");
	$dumpvars(-1, S1);
	$monitor ("A=%b,B=%b,Q=%b", c2A, c2B, c2Q);
  end

Sumador32Bits S1(.A(c2A), .B(c2B), .MODO(c2MODO), .CLK(c2CLK), 
                .ENB(c2ENB), .RCI(c2RCI), .Q(c2Q), .RCO(c2RCO));

probador32Bits P0(.A(c2A), .B(c2B), .MODO(c2MODO), .CLK(c2CLK), 
                .ENB(c2ENB), .RCI(c2RCI), .Q(c2Q), .RCO(c2RCO));

endmodule
