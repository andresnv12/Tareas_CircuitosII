/* Universidad de Costa Rica
   Escuela de Ingeniería Eléctrica | Circuitos Digitales II - IE0523
   Profesor: Enrique Coen | Asistente: Ana Eugenia Sánchez
   Estudiante: Andrés Chaves Vargas | Carné: B92198 
*/


module Transmisor(
            input CLK, RESET,
            input CKP, CPH, MISO, 
            output reg MOSI, SCK, CS);

//Estados a utilizar:
parameter INICIO = 5'b00001;
parameter MODO0  = 5'b00010;
parameter MODO1  = 5'b00100;
parameter MODO2  = 5'b01000;
parameter MODO3  = 5'b10000;
//Primeros dígitos del Carné:

parameter CARNET1 = 16'b0000000000010101;

reg posedge_SCK;
reg transf_f; //Señal de transacción finalizada.
reg [1:0] clk_count; // clk para mantener el SCK a un 25 % de CLK
reg [4:0] state, next_state, counter;
reg [15:0] tdata_rcv, tdata_send;

   
always @(posedge CLK) begin 
   
   if (~RESET) begin
      state <= INICIO;
      next_state <= INICIO;
      transf_f = 0; tdata_rcv = 0; tdata_send = 0;
      clk_count = 0; CS = 1; counter = 0;
      tdata_send = CARNET1;
      
      // Habilita la polaridad con la que inicia el SCK cuando se encuentra en idle.
      if ((~CKP & ~CPH)| (~CKP & CPH)) begin 
      SCK = 0;
      clk_count =0;
      end

      if ((CKP & CPH)|(CKP & ~CPH)) begin
      SCK = 1;
      clk_count = 2;
      end

   end

   else begin
      clk_count <= clk_count + 1;
      SCK = clk_count[1]; //25% del CLK 
   end 
end

always @(posedge SCK) begin 
   posedge_SCK =1; //Permite realizar cambios en el posedge SCK
   if ((~CKP & ~CPH)| (CKP & CPH)) begin
      state = next_state;
      end
   end

always @(negedge SCK) begin
   MOSI = 0;
   posedge_SCK = 0; //permite realizar cambios en el negedge SCK
   if ((~CKP & CPH)|(CKP & ~CPH)) begin
      state = next_state;
      end
   end
always @(*) begin 
case (state)
   
   INICIO: begin
      if (RESET) begin
         CS = 0;
         if (~CS) begin
            tdata_rcv = 0;
            counter = 0;
            MOSI = 0;
            transf_f = 0;
            if (~CKP & ~CPH) begin
               next_state = MODO0;
               end
            else if (~CKP & CPH) begin
               next_state = MODO1;
               end
            else if (CKP & ~CPH) begin
               next_state = MODO2;
               end 
            else if (CKP & CPH) begin 
               next_state = MODO3;
               end
         end
         
      end
   end

   MODO0: //CKP = 0 Y CPH = 0

      if (posedge_SCK) begin
         MOSI = tdata_send[15]; //guarda en MOSI el bit MSB
         tdata_send = tdata_send << 1; //Desplaza a la izquierda un bit, haciendo un efecto de registro desplazante.
         tdata_rcv = tdata_rcv << 1;
         tdata_rcv[0] = MISO; //recibe en el LSB la señal de MISO proveniente del receptor.
         counter += 1;
         if (counter > 16) begin //Indica cuando se debe terminar la transferencia.
            transf_f = 1;
            if (transf_f) begin 
               CS = 1; 
               if (CS) begin
                  tdata_send = CARNET1;
                  tdata_rcv = 0;
               end
               next_state = INICIO;
            end
         end
      end
   MODO1: //CKP = 0 Y CPH = 1
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
               if (CS) begin
                  tdata_send = CARNET1;
                  tdata_rcv = 0;
                  end
               next_state = INICIO;
            end
         end
      end
   MODO2: //CKP = 1 Y CPH = 0
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
               if (CS) begin
                  tdata_send = CARNET1;
                  tdata_rcv = 0;
                  end
               next_state = INICIO;
            end
         end
      end
   MODO3: //CKP = 0 Y CPH = 1
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
               if (CS) begin
                  tdata_send = CARNET1;
                  tdata_rcv = 0;
                  end
               next_state = INICIO;
            end
         end
      end
endcase      
end
endmodule