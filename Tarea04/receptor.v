/* Universidad de Costa Rica
   Escuela de Ingeniería Eléctrica | Circuitos Digitales II - IE0523
   Profesor: Enrique Coen | Asistente: Ana Eugenia Sánchez
   Estudiante: Andrés Chaves Vargas | Carné: B92198 
*/

module Receptor(
            input SCK, SS,
            input CKP, CPH, MOSI, 
            output reg MISO);
parameter CARNET2 = 16'b0000000001100010;
reg [15:0] rdata_rcv, rdata_send;
reg posedge_SCK;
always @(posedge SCK) posedge_SCK =1;

always @(negedge SCK) begin 
   MISO = 0;
   posedge_SCK = 0;
   end
always @(*) begin 

   if (SS) begin
      rdata_send = CARNET2;
      rdata_rcv = 0;
      
   end
   if (~SS) begin
      if (((~CKP & ~CPH)|(CKP & CPH)) & posedge_SCK) begin
 
         MISO = rdata_send[15];
         rdata_send = rdata_send << 1;
         rdata_rcv = rdata_rcv << 1; 
         rdata_rcv[0] = MOSI;
      end

      else if (((CKP & ~CPH)|(~CKP & CPH)) & ~posedge_SCK) begin
         
         MISO = rdata_send[15];
         rdata_send = rdata_send << 1;
         rdata_rcv = rdata_rcv << 1; 
         rdata_rcv[0] = MOSI; 
      end  
   end
end
endmodule