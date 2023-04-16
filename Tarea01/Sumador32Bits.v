/* Universidad de Costa Rica
   Escuela de Ingeniería Eléctrica | Circuitos Digitales II - IE0523
   Profesor: Enrique Coen | Asistente: Ana Eugenia Sánchez
   Estudiante: Andrés Chaves Vargas | Carné: B92198 
*/

`include "Sumador8Bits.v"

module Sumador32Bits(
               input [31:0] A, 
               input [31:0] B, 
               input [1:0] MODO, 
               input CLK, 
               input ENB,
               input RCI,
               output [31:0] Q,
               output RCO);

wire wRCI2, wRCI3, wRCI4;

Sumador8Bits S1(.A({A[7], A[6], A[5], A[4], A[3], A[2], A[1], A[0]}), .B({B[7], B[6], B[5], B[4], B[3], B[2], B[1], B[0]}), .MODO(MODO), .CLK(CLK), 
                .ENB(ENB), .RCI(RCI), .Q({Q[7], Q[6], Q[5], Q[4], Q[3], Q[2], Q[1], Q[0]}), .RCO(wRCI2));

Sumador8Bits S2(.A({A[15], A[14], A[13], A[12], A[11], A[10], A[9], A[8]}), .B({B[15], B[14], B[13], B[12], B[11], B[10], B[9], B[8]}), .MODO(MODO), .CLK(CLK), 
                .ENB(ENB), .RCI(wRCI2), .Q({Q[15], Q[14], Q[13], Q[12], Q[11], Q[10], Q[9], Q[8]}), .RCO(wRCI3));

Sumador8Bits S3(.A({A[23], A[22], A[21], A[20], A[19], A[18], A[17], A[16]}), .B({B[23], B[22], B[21], B[20], B[19], B[18], B[17], B[16]}), .MODO(MODO), .CLK(CLK), 
                .ENB(ENB), .RCI(wRCI3), .Q({Q[23], Q[22], Q[21], Q[20], Q[19], Q[18], Q[17], Q[16]}), .RCO(wRCI4));

Sumador8Bits S4(.A({A[31], A[30], A[29], A[28], A[27], A[26], A[25], A[24]}), .B({B[31], B[30], B[29], B[28], B[27], B[26], B[25], B[24]}), .MODO(MODO), .CLK(CLK), 
                .ENB(ENB), .RCI(wRCI4), .Q({Q[31], Q[30], Q[29], Q[28], Q[27], Q[26], Q[25], Q[24]}), .RCO(RCO));
endmodule