/* Universidad de Costa Rica
   Escuela de Ingeniería Eléctrica | Circuitos Digitales II - IE0523
   Profesor: Enrique Coen | Asistente: Ana Eugenia Sánchez
   Estudiante: Andrés Chaves Vargas | Carné: B92198 
*/

module probador32Bits(
               output [31:0] A, 
               output [31:0] B, 
               output [1:0] MODO, 
               output CLK, ENB, RCI, 
               input [31:0]Q, 
               input RCO);

reg A, B, MODO, CLK, ENB, RCI;
wire Q, RCO;
initial begin

A = 32'b00000000000000000000000000000010;
B = 32'b00000000000000000000000000000001;
MODO = 2'b11;
ENB = 1;
CLK = 1;
RCI = 0;
// Prueba #1. Suma de 32 Bits.
// Caso: A + B con RCI = 0:
#5 MODO = 2'b01;
#6 A = 32'b0000000000000000000001000000010;
B = 32'b00000000000000100000000000000001;


// Prueba #2. Resta de 4 Bits.
// Caso: A > B:
#5 MODO = 2'b10;
#6 A = 32'b00000000000001000000000000000000;
B = 32'b00000000000000100000000000000000;

// Prueba #3. Mantener el valor del MODO 00.

#5 MODO = 2'b01;
#6 A = 32'b00000000000000000000000000010010;
B = 32'b00000000000000100000000000000001;
// Se realiza el cambio de MODO:

#10 MODO = 2'b00;


// Prueba #4. Mantener el valor cuando ENB = 0.
#5 MODO = 2'b10;

#6 A = 32'b00000000000000000000000000000010;
B = 32'b00000000000000100000000000000001;

// Se realiza el cambio de ENB:
ENB = 0;


// Prueba #5. Limpiar el contador.
#10 ENB = 1;
#5 MODO = 2'b01;

A = 32'b00000000000000000000000000000110;
B = 32'b00000000000000000011100000000001;
// Se realiza el cambio de MODO:

#5 MODO = 2'b11;
#200 $finish;
end

always begin
    #5 CLK = !CLK;
end
endmodule
