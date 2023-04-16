/* Universidad de Costa Rica
   Escuela de Ingeniería Eléctrica | Circuitos Digitales II - IE0523
   Profesor: Enrique Coen | Asistente: Ana Eugenia Sánchez
   Estudiante: Andrés Chaves Vargas | Carné: B92198 
*/

module Sumador4Bits(
               input [3:0] A, 
               input [3:0] B, 
               input [1:0] MODO, 
               input CLK, ENB, RCI,
               output reg [3:0] Q,
               output reg RCO);


always @ (posedge CLK)
if (ENB) begin
  case(MODO)
   2'b00: begin Q <= Q; // Valor de estado anterior se mantiene.
          RCO <= RCO;
          end
   2'b01: Q <= A + B + RCI ; // Suma entre A y B.

   2'b10: Q <= A - B + RCI; // Resta mediante el uso de complemento a 2.
           
   2'b11: begin Q <= 0; 
          RCO <= 0;
          end 
  endcase
end


endmodule 
