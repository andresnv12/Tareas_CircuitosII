/* Universidad de Costa Rica
   Escuela de Ingeniería Eléctrica | Circuitos Digitales II - IE0523
   Profesor: Enrique Coen | Asistente: Ana Eugenia Sánchez
   Estudiante: Andrés Chaves Vargas | Carné: B92198 
*/

module Receptor(
            input SCK, SS,
            input CKP, CPH, MOSI, 
            output reg MISO);

reg [15:0] rdata_rcv, rdata_send;

always @(*) begin 
   if (~SS) begin
      MISO = rdata_send[15];
      rdata_send = rdata_send << 1; 
      rdata_rcv[0] = MOSI;
      rdata_rcv = rdata_rcv << 1;
   end
end
endmodule