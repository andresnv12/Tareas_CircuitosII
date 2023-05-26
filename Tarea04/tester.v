/* Universidad de Costa Rica
   Escuela de Ingeniería Eléctrica | Circuitos Digitales II - IE0523
   Profesor: Enrique Coen | Asistente: Ana Eugenia Sánchez
   Estudiante: Andrés Chaves Vargas | Carné: B92198 
*/

module SPI_Tester(
                output reg CLK, RESET,
                output reg CKP, CPH, MISO,
                input MOSI, SCK, CS);


initial begin


//Valores Iniciales de la Simulación:

CLK = 1; RESET = 1; 
#5 RESET = 0;
#200 $finish;
end 

always begin
    #10 CLK = !CLK;
end
endmodule