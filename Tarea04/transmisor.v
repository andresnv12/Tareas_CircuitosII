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
parameter CARNET1 = 16'b0000000000010101;
reg posedge_SCK;
reg transf_f;
reg [1:0] clk_count;
reg [4:0] state, next_state, counter;
reg [15:0] tdata_rcv, tdata_send;

   
always @(posedge CLK) begin 
   
   if (~RESET) begin
      SCK = 0;
      state = INICIO;
      next_state <= INICIO;
      transf_f = 0; tdata_rcv = 0; tdata_send = 0;
      clk_count = 0; CS = 1; counter = 0;
      tdata_send = CARNET1;
   end

   else begin
      clk_count <= clk_count + 1;
      SCK = clk_count[1];
      CS <= 0;
      
   end 
end

always @(posedge SCK) begin 
   posedge_SCK =1;
   if ((~CKP & ~CPH)| (CKP & CPH)) begin
      state = next_state;
      end
   end

always @(negedge SCK) begin
   MOSI = 0;
   posedge_SCK = 0;
   if ((~CKP & CPH)|(CKP & ~CPH)) begin
      state = next_state;
      end
   end
always @(*) begin 

case (state)
   
   INICIO: begin
   
      if (~CS) begin

         tdata_rcv = 0;
         counter = 0;
         MOSI = 0;
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
      else tdata_send = CARNET1;
      end
   end

   MODO0:

      if (posedge_SCK) begin
         MOSI = tdata_send[15];
         tdata_send = tdata_send << 1; 
         tdata_rcv = tdata_rcv << 1;
         tdata_rcv[0] = MISO;
         counter += 1;
         if (counter > 16) begin 
            transf_f = 1;
            if (transf_f) begin 
               CS = 1; 
               next_state = INICIO;
            end
         end
      end
   MODO1:
      if (~posedge_SCK) begin
        MOSI = tdata_send[15];
         tdata_send = tdata_send << 1; 
         tdata_rcv = tdata_rcv << 1;
         tdata_rcv[0] = MISO;
         counter += 1;
         if (counter > 16) begin 
            transf_f = 1;
            if (transf_f) begin 
               CS = 1; 
               next_state = INICIO;
            end
         end
      end
   MODO2:
      if (~posedge_SCK) begin
         MOSI = tdata_send[15];
         tdata_send = tdata_send << 1; 
         tdata_rcv = tdata_rcv << 1;
         tdata_rcv[0] = MISO;
         counter += 1;
         if (counter > 16) begin 
            transf_f = 1;
            if (transf_f) begin 
               CS = 1; 
               next_state = INICIO;
            end
         end
      end
   MODO3:
      if (posedge_SCK) begin
         MOSI = tdata_send[15];
         tdata_send = tdata_send << 1; 
         tdata_rcv = tdata_rcv << 1;
         tdata_rcv[0] = MISO;
         counter += 1;
         if (counter > 16) begin 
            transf_f = 1;
            if (transf_f) begin 
               CS = 1; 
               next_state = INICIO;
            end
         end
      end
endcase      
end
endmodule