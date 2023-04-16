/* Universidad de Costa Rica
   Escuela de Ingeniería Eléctrica | Circuitos Digitales II - IE0523
   Profesor: Enrique Coen | Asistente: Ana Eugenia Sánchez
   Estudiante: Andrés Chaves Vargas | Carné: B92198 
*/

`include "Sumador4Bits.v"

module Sumador8Bits(
               input [7:0] A, 
               input [7:0] B, 
               input [1:0] MODO, 
               input CLK, 
               input ENB,
               input RCI,
               output [7:0] Q,
               output RCO);
wire wRCI1;

Sumador4Bits S1(.A({A[3], A[2], A[1], A[0]}), .B({B[3], B[2], B[1], B[0]}),
               .MODO({MODO[1], MODO[0]}), .CLK(CLK), .ENB(ENB), .RCI(RCI), .Q({Q[3], Q[2], Q[1], Q[0]}), .RCO(wRCI1));

Sumador4Bits S2(.A({A[7], A[6], A[5], A[4]}), .B({B[7], B[6], B[5], B[4]}),
               .MODO({MODO[1], MODO[0]}), .CLK(CLK), .ENB(ENB), .RCI(wRCI1), .Q({Q[7], Q[6], Q[5], Q[4]}), .RCO(RCO));

endmodule
