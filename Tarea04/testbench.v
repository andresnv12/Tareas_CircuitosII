/* Universidad de Costa Rica
   Escuela de Ingeniería Eléctrica | Circuitos Digitales II - IE0523
   Profesor: Enrique Coen | Asistente: Ana Eugenia Sánchez
   Estudiante: Andrés Chaves Vargas | Carné: B92198 
*/

`include "tester.v"
`include "transmisor.v"
`include "receptor.v"


module SPI_Tb;

wire wCLK, wRESET, wCKP, wCPH;
wire wMISO, wMOSI, wSCK, wCS;


initial begin
	$dumpfile("SPI.vcd");
	$dumpvars(-1, U0);
	//$monitor ("BALANCE ACTUALIZADO=%d, ENTREGAR DINERO=%d, FONDOS INSUFICIENTES=%d, PIN INCORRECTO=%d", wBALANCE_ACTUALIZADO, wENTREGAR_DINERO);
end

Transmisor U0 (.CLK(wCLK), .RESET(wRESET), .CKP(wCKP), .CPH(wCPH), 
               .MISO(wMISO), .MOSI(wMOSI), .SCK(wSCK), .CS(wCS));

Receptor U1 (.CKP(wCKP), .CPH(wCPH), .MISO(wMISO), 
             .MOSI(wMOSI), .SCK(wSCK), .SS(wCS));

SPI_Tester P0 (.CLK(wCLK), .RESET(wRESET), .CKP(wCKP), .CPH(wCPH), .MISO(wMISO), 
             .MOSI(wMOSI), .SCK(wSCK), .CS(wCS));

endmodule