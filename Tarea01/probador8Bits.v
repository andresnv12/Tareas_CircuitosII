/* Universidad de Costa Rica
   Escuela de Ingeniería Eléctrica | Circuitos Digitales II - IE0523
   Profesor: Enrique Coen | Asistente: Ana Eugenia Sánchez
   Estudiante: Andrés Chaves Vargas | Carné: B92198 
*/

module probador8Bits(
               output [7:0] A, 
               output [7:0] B, 
               output [1:0] MODO, 
               output CLK, ENB, RCI, 
               input [7:0]Q, 
               input RCO);

reg A, B, MODO, CLK, ENB, RCI;
wire Q, RCO;
initial begin

A = 8'b00000010;
B = 8'b00000001;
MODO = 2'b11;
ENB = 1;
CLK = 1;
RCI = 0;

// Prueba #1. Suma de 8 Bits.
// Caso: A + B con RCI = 0:
#10 MODO = 2'b01;
#12 A = 8'b01010010;
B = 8'b00010001;


// Prueba #2. Resta de 8 Bits.
// Caso: A > B:

#10 MODO = 2'b10;
RCI =0;
#12 A = 8'b01000000;
B = 8'b00011001;

// Prueba #3. Mantener el valor del MODO 00.

#10 MODO = 2'b01;
RCI = 0;
#12 A = 8'b01000000;
B = 8'b00100000;
// Se realiza el cambio de MODO:

#10 MODO = 2'b00;


// Prueba #4. Mantener el valor cuando ENB = 0.
#10 MODO = 2'b10;

#12 A = 8'b00101100;
B = 8'b10000001;

// Se realiza el cambio de ENB:
ENB = 0;

#12A = 8'b00101100;
B = 8'b10000001;

// Prueba #5. Limpiar el contador.
#10 ENB = 1;
#10 MODO = 2'b01;

#12 A = 8'b00001000;
 B = 8'b00000100;
// Se realiza el cambio de MODO:

#10 MODO = 2'b11;
#200 $finish;
end

always begin
    #5 CLK = !CLK;
end

endmodule
