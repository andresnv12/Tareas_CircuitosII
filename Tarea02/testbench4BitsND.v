/* Universidad de Costa Rica
   Escuela de Ingeniería Eléctrica | Circuitos Digitales II - IE0523
   Profesor: Enrique Coen | Asistente: Ana Eugenia Sánchez
   Estudiante: Andrés Chaves Vargas | Carné: B92198 
*/

`include "probador4Bits.v"
`include "Sum4.v"
`include "cmos_cells_no_delay.v"                                        
module Sumador4Bits_tb;

  wire cRCO, cCLK, cENB, cRCI;
  wire [1:0]cMODO;
  wire [3:0] cA, cB, cQ; 

  initial begin
	$dumpfile("Sumador4Bits.vcd");
	$dumpvars(-1, U0);
	$monitor ("A=%b,B=%b,Q=%b", cA, cB, cQ);
  end

  Sumador4Bits U0 (.A(cA), .B(cB),.MODO(cMODO), .CLK(cCLK),
                .ENB(cENB), .RCI(cRCI), .Q(cQ), .RCO(cRCO));

  probador4Bits P0 (.A(cA), .B(cB),.MODO(cMODO), .CLK(cCLK),
                .ENB(cENB), .RCI(cRCI), .Q(cQ), .RCO(cRCO));

endmodule
