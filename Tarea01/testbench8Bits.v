/* Universidad de Costa Rica
   Escuela de Ingeniería Eléctrica | Circuitos Digitales II - IE0523
   Profesor: Enrique Coen | Asistente: Ana Eugenia Sánchez
   Estudiante: Andrés Chaves Vargas | Carné: B92198 
*/

`include "probador8Bits.v"
`include "Sumador8Bits.v"
                                        
module Sumador8Bits_tb;

  wire c1RCO, c1CLK, c1ENB, c1RCI;
  wire [1:0]c1MODO;
  wire [7:0] c1A, c1B, c1Q; 
  
      

  initial begin
	$dumpfile("Sumador8Bits.vcd");
	$dumpvars(-1, SP);
	$monitor ("A=%b,B=%b,Q=%b", c1A, c1B, c1Q);
  end

  Sumador8Bits SP(.A(c1A), .B(c1B), .MODO(c1MODO), .CLK(c1CLK), 
                .ENB(c1ENB), .RCI(c1RCI), .Q(c1Q), .RCO(c1RCO));
  
  probador8Bits P0(.A(c1A), .B(c1B), .MODO(c1MODO), .CLK(c1CLK), 
                .ENB(c1ENB), .RCI(c1RCI), .Q(c1Q), .RCO(c1RCO));

endmodule
