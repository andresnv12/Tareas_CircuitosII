/* Universidad de Costa Rica
   Escuela de Ingeniería Eléctrica | Circuitos Digitales II - IE0523
   Profesor: Enrique Coen | Asistente: Ana Eugenia Sánchez
   Estudiante: Andrés Chaves Vargas | Carné: B92198 
*/


module Transmisor(
            input CLK, RESET,
            input CKP, CPH, MISO, 
            output reg MOSI, SCK, CS);

parameter INICIO = 5'b00001;
parameter MODO0  = 5'b00010;
parameter MODO1  = 5'b00100;
parameter MODO2  = 5'b01000;
parameter MODO3  = 5'b10000;

reg posedge_SCK;
reg transf_f;
reg [1:0] clk_count;
reg [4:0] state, next_state;
reg [15:0] tdata_rcv, tdata_send;

   
always @(posedge CLK) begin 
   
   if (~RESET) begin
      SCK = 0;
      state = INICIO;
      next_state <= INICIO;
      transf_f = 0; tdata_rcv = 0; tdata_send = 0;
      clk_count = 0; CS = 1;
   end

   else begin
      SCK = clk_count[1];
      state <= next_state;
      clk_count <= clk_count + 1;
   end 
end

always @(posedge SCK) posedge_SCK =1;

always @(negedge SCK) posedge_SCK = 0;

always @(*) begin 

case (state)

   INICIO: begin
      if (~CS) begin
         if (~CKP & ~CPH) begin
            clk_count = 0;
            next_state = MODO0;
            end
         else if (~CKP & CPH) begin
            clk_count = 0;
            next_state = MODO1;
            end
         else if (CKP & ~CPH) begin
            clk_count = 2;
            next_state = MODO2;
            end 
         else if (CKP & CPH) begin 
            clk_count = 2;
            next_state = MODO3;
            end  
      end
   end

   MODO0:

      if (posedge_SCK) begin
         MOSI = tdata_send[15];
         tdata_send = tdata_send << 1; 
         tdata_rcv[0] = MISO;
         tdata_rcv = tdata_rcv << 1;
         if (transf_f) next_state = INICIO;
      end
   MODO1:
      if (~posedge_SCK) begin
         MOSI = tdata_send[15];
         tdata_send = tdata_send << 1; 
         tdata_rcv[0] = MISO;
         tdata_rcv = tdata_rcv << 1;

         if (transf_f) next_state = INICIO;
      end
   MODO2:
      if (~posedge_SCK) begin
         MOSI = tdata_send[15];
         tdata_send = tdata_send << 1; 
         tdata_rcv[0] = MISO;
         tdata_rcv = tdata_rcv << 1;

         if (transf_f) next_state = INICIO;
      end
   MODO3:
      if (posedge_SCK) begin
         MOSI = tdata_send[15];
         tdata_send = tdata_send << 1; 
         tdata_rcv[0] = MISO;
         tdata_rcv = tdata_rcv << 1;

         if (transf_f) next_state = INICIO;
      end
endcase      
end
endmodule