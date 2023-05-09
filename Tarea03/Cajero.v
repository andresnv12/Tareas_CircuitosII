/* Universidad de Costa Rica
   Escuela de Ingeniería Eléctrica | Circuitos Digitales II - IE0523
   Profesor: Enrique Coen | Asistente: Ana Eugenia Sánchez
   Estudiante: Andrés Chaves Vargas | Carné: B92198 
*/

module Cajero(
            input CLK, RESET, TARJETA_RECIBIDA,
            input DIGITO_STB, TIPO_TRANS, MONTO_STB,
            input [4:0] DIGITO, 
            input [15:0] PIN,
            input [31:0] MONTO,
            output reg BALANCE_ACTUALIZADO, ENTREGAR_DINERO,
            output reg FONDOS_INSUFICIENTES, PIN_INCORRECTO, 
            output reg ADVERTENCIA, BLOQUEO);
reg [2:0]CONTADOR;
reg [8:0] ESTADO, PROX_ESTADO;
reg [15:0] PIN_COMP;
reg [63:0] BALANCE;

always @(posedge CLK) begin 
   
   ESTADO <= PROX_ESTADO;

   if (RESET) begin 
      ESTADO = 9'b000000001;
      PROX_ESTADO = 9'b000000001;
      BALANCE = 64'h1000000;
      PIN_COMP = 0;
      ADVERTENCIA = 0;
      BLOQUEO = 0;
      CONTADOR = 0; 
      BALANCE_ACTUALIZADO = 0;
      PIN_INCORRECTO = 0;
      FONDOS_INSUFICIENTES = 0;
   end
   
   
end

always @(*) begin 

case (ESTADO)
   9'b000000001: if (TARJETA_RECIBIDA) begin //Estado 1: Esperando Tarjeta.
                     PIN_COMP = 0;
                     
                     PROX_ESTADO = 9'b000000010; 
                     end
   9'b000000010: if (DIGITO_STB) begin //Estado 2: Esperando primer dígito.
                     PIN_COMP = DIGITO + PIN_COMP; //Se suma el dígito ingresado a una variable que permita comparar más adelante con PIN.
                     PIN_COMP = PIN_COMP << 4; //Se mueven cuatro posiciones antes de ingresar un nuevo dígito para obtener al final el número de 16 bits
                     PROX_ESTADO = 9'b000000100; 
                     end

   9'b000000100: if (DIGITO_STB) begin //Estado 3: Esperando segundo dígito.
                     PIN_COMP = DIGITO + PIN_COMP;
                     PIN_COMP = PIN_COMP << 4;
                     PROX_ESTADO = 9'b000001000; 
                     end

   9'b000001000: if (DIGITO_STB) begin //Estado 4: Esperando tercer dígito.
                     PIN_COMP = DIGITO + PIN_COMP;
                     PIN_COMP = PIN_COMP << 4;
                     PROX_ESTADO = 9'b000010000; 
                     end

   9'b000010000: if (DIGITO_STB) begin //Estado 5: Esperando cuarto dígito.
                     PIN_COMP = DIGITO + PIN_COMP;
                     PROX_ESTADO = 9'b000100000; 
                     end

   9'b000100000: if (PIN_COMP == PIN) begin //Estado 6: Verificando PIN correcto.   
                     if (MONTO_STB)begin
                     if (TIPO_TRANS) PROX_ESTADO = 9'b100000000;
                     else PROX_ESTADO = 9'b010000000;
                     end
                     end

                 else if (CONTADOR == 1 & PIN_INCORRECTO)begin //Segundo Intento.
                     PIN_INCORRECTO = 0;
                     ADVERTENCIA = 1;
                     CONTADOR = 2;
                     PROX_ESTADO = 9'b000000010;
                     end    
                 else if (CONTADOR == 0)begin //Primer Intento.
                     PIN_INCORRECTO = 1;
                     CONTADOR = 1;
                     PROX_ESTADO = 9'b000000010;
                     end
                  
            
                else begin //Tercer Intento, Tarjeta Bloqueada.
                     PIN_INCORRECTO = 1;
                     ADVERTENCIA = 1;
                     BLOQUEO = 1;
                     CONTADOR = 3;
                     PROX_ESTADO = 9'b001000000;
                     end

   9'b001000000: if (RESET) begin //Estado 7: Bloqueo. Esperando RESET.
                     PROX_ESTADO = 9'b000000001;
                     end

   9'b010000000:  begin          //Estado 8: Depósito.
                     BALANCE += MONTO;
                     BALANCE_ACTUALIZADO = 1;
                     PROX_ESTADO = 9'b000000001;
                  end  

   9'b100000000: if (MONTO > BALANCE) begin //Estado 9: Retiro.
                     FONDOS_INSUFICIENTES = 1; 
                     PROX_ESTADO = 9'b000000001; 
                     end
                 else begin 
                     BALANCE -= MONTO;
                     BALANCE_ACTUALIZADO = 1;
                     ENTREGAR_DINERO = 1;
                     PROX_ESTADO = 9'b000000001;
                     end  
            
endcase
end
endmodule