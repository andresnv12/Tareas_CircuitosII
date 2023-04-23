/* Universidad de Costa Rica
   Escuela de Ingeniería Eléctrica | Circuitos Digitales II - IE0523
   Profesor: Enrique Coen | Asistente: Ana Eugenia Sánchez
   Estudiante: Andrés Chaves Vargas | Carné: B92198 
*/

module probador4Bits(
               output [3:0] A, 
               output [3:0] B, 
               output [1:0] MODO, 
               output CLK, ENB, RCI, 
               input [3:0]Q, 
               input RCO);

reg A, B, MODO, CLK, ENB, RCI;
wire Q, RCO;
initial begin


A = 4'b0010;
B = 4'b0001;
MODO = 2'b11;
ENB = 1;
CLK = 1;
RCI = 0;

// Prueba #1. Suma de 4 Bits.
// Caso: A + B con RCI = 0:
#10 MODO = 2'b01;
#5 A = 4'b0010;
B = 4'b0001;

#10 A = 4'b0111;
B = 4'b0001;

// Caso: A + B con RCI = 1:
#5RCI = 1; 
#5 A = 4'b0111;
B = 4'b0011;


// Prueba #2. Resta de 4 Bits.
// Caso: A > B:
#10 MODO = 2'b10;
RCI = 0;
#5 A = 4'b0100;
B = 4'b0001;

// Caso: B > A con RCI = 0:
#10 A = 4'b0001;
B = 4'b0100;

// Caso: B > A con RCI = 1:
#5 RCI = 1;
#5 A = 4'b0001;
B = 4'b0100;

// Prueba #3. Mantener el valor del MODO 00.

#10 MODO = 2'b01;
RCI = 0;
#5 A = 4'b0100;
B = 4'b0010;
// Se realiza el cambio de MODO:

#10 MODO = 2'b00;


// Prueba #4. Mantener el valor cuando ENB = 0.
#10 MODO = 2'b10;

#5 A = 4'b0100;
B = 4'b0001;

// Se realiza el cambio de ENB:
ENB = 0;


// Prueba #5. Limpiar el contador.
#10 ENB = 1;
MODO = 2'b01;

A = 4'b1000;
B = 4'b0100;
// Se realiza el cambio de MODO:

#10 MODO = 2'b11;
#200 $finish;
end

always begin
    #5 CLK = !CLK;
end

endmodule


