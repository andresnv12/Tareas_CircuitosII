/* Universidad de Costa Rica
   Escuela de Ingeniería Eléctrica | Circuitos Digitales II - IE0523
   Profesor: Enrique Coen | Asistente: Ana Eugenia Sánchez
   Estudiante: Andrés Chaves Vargas | Carné: B92198 
*/

module SPI_Tester(
                output reg CLK, RESET,
                output reg CKP, CPH,
                input MOSI, MISO, SCK, CS);
reg [15:0] tdata_send, rdata_send;

parameter CARNET1 = 16'b0000000000010101;
parameter CARNET2 = 16'b0000000001100010;
initial begin

//Valores Iniciales de la Simulación:

CLK = 1; RESET = 0; CKP = 0; CPH = 0;
//Prueba 1: CKP = 0 CPH = 0
    CKP = 1;
    CPH = 1;
#20 RESET = 1;
    
/*
//Prueba 2: CKP = 0 CPH = 1
#1200 RESET = 0;
    CKP = 0;
    CPH = 1;
#20 RESET = 1;
    
//Prueba 3: CKP = 1 CPH = 0
#1200 RESET = 0;
    CKP = 1;
    CPH = 0;
#20 RESET = 1;
//Prueba 4: CKP = 1 CPH = 1
#1200 RESET = 0;
    CKP = 1;
    CPH = 1;
#20 RESET = 1;
*/
#8000 $finish;
end 

always begin
    #10 CLK = !CLK;
end
endmodule