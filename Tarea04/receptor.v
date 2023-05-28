/* Universidad de Costa Rica
   Escuela de Ingeniería Eléctrica | Circuitos Digitales II - IE0523
   Profesor: Enrique Coen | Asistente: Ana Eugenia Sánchez
   Estudiante: Andrés Chaves Vargas | Carné: B92198 
*/

module Receptor(
            input SCK, SS,
            input CKP, CPH, MOSI, 
            output reg MISO);
//Estados a utlizar en el receptor:
parameter IDLE = 2'b01;
parameter TRANSFER = 2'b10;

//últimos dos dígitos de carné:
parameter CARNET2 = 16'b0000000001100010;

reg [15:0] rdata_rcv, rdata_send;
reg [1:0] state_rec, next_state;
reg posedge_SCK;
reg counter;

always @(posedge SCK) posedge_SCK =1;

always @(negedge SCK) begin 
   MISO = 0;
   posedge_SCK = 0;
   end
always @(*) begin 

   if (SS) state_rec = IDLE;

   if (~SS) state_rec = TRANSFER;
   
   case (state_rec)
      IDLE: begin 
         rdata_send = CARNET2;
         rdata_rcv = 0;
         if (~SS) state_rec = TRANSFER;
      end 
      TRANSFER: begin
         if (((~CKP & ~CPH)|(CKP & CPH)) & posedge_SCK) begin
 
         MISO = rdata_send[15];
         rdata_send = rdata_send << 1;
         rdata_rcv = rdata_rcv << 1; 
         rdata_rcv[0] = MOSI;
         if (SS) state_rec = IDLE;
         end

         else if (((CKP & ~CPH)|(~CKP & CPH)) & ~posedge_SCK) begin
         
         MISO = rdata_send[15];
         rdata_send = rdata_send << 1;
         rdata_rcv = rdata_rcv << 1; 
         rdata_rcv[0] = MOSI;
         if (SS) state_rec = IDLE; 
         end
      end
   endcase
end
endmodule