/* Universidad de Costa Rica
   Escuela de Ingeniería Eléctrica | Circuitos Digitales II - IE0523
   Profesor: Enrique Coen | Asistente: Ana Eugenia Sánchez
   Estudiante: Andrés Chaves Vargas | Carné: B92198 
*/

module Cajero_Tester(
                output reg CLK, RESET, TARJETA_RECIBIDA,
                output reg DIGITO_STB, TIPO_TRANS, MONTO_STB,
                output reg [4:0] DIGITO, 
                output reg [15:0] PIN,
                output reg [31:0] MONTO,
                input BALANCE_ACTUALIZADO, ENTREGAR_DINERO,
                input FONDOS_INSUFICIENTES, PIN_INCORRECTO, 
                input ADVERTENCIA, BLOQUEO);

reg [2:0]CONTADOR;
reg [8:0] ESTADO, PROX_ESTADO; 
reg [15:0] PIN_COMP;
reg [63:0] BALANCE;

initial begin


//Valores Iniciales de la Simulación:

CLK = 1; RESET = 1; DIGITO = 0; DIGITO = 2; TIPO_TRANS = 0;
MONTO_STB = 0; BALANCE = 64'h1000000; CONTADOR = 0; TARJETA_RECIBIDA = 1;
PIN = 16'h2198; PIN_COMP = 0; MONTO = 0; 
/*
//Prueba 1: Proceso Normal de Funcionamiento. Acción: Depósito:
#5 RESET = 0;
#5 TARJETA_RECIBIDA = 1; //Se pasa al estado: Esperando primer dígito.
   
#3 DIGITO_STB = 1; //Se pasa al estado: Esperando segundo dígito.
#5 DIGITO_STB = 0;
   TARJETA_RECIBIDA = 0;

#5 DIGITO = 1;
   DIGITO_STB = 1; //Se pasa al estado: Esperando tercer dígito.
#5 DIGITO_STB = 0;

#5 DIGITO = 9;
   DIGITO_STB = 1; //Se pasa al estado: Esperando cuarto dígito.
#5 DIGITO_STB = 0;

#5 DIGITO = 8;
   DIGITO_STB = 1; //Se pasa al estado: Verificando PIN.
#5 DIGITO_STB = 0;
   MONTO = 32'h500000;
   MONTO_STB = 1;
   BALANCE = 64'h1000000;
   TIPO_TRANS = 0; //Se pasa al estado: Depósito.
*/

//Prueba 2: Proceso Normal de Funcionamiento. Acción: Retiro (Fondos Suficientes):
#9  DIGITO = 2;  
#5 RESET = 0;
   TARJETA_RECIBIDA = 1; //Se pasa al estado: Esperando primer dígito.
#1   BALANCE = 64'h1000000;
   DIGITO_STB = 1; //Se pasa al estado: Esperando segundo dígito.
#1 DIGITO_STB = 0;
 
#5   DIGITO = 1;
#5   DIGITO_STB = 1; //Se pasa al estado: Esperando tercer dígito.
#2 DIGITO_STB = 0;

#5   DIGITO = 9;
#5   DIGITO_STB = 1; //Se pasa al estado: Esperando cuarto dígito.
#2 DIGITO_STB = 0;

#5   DIGITO = 8;
#5   DIGITO_STB = 1; //Se pasa al estado: Verificando PIN.
#2 DIGITO_STB = 0;
   
   MONTO = 32'h500000;
   MONTO_STB = 1;
   
   TIPO_TRANS = 1; //Se pasa al estado: Retiro.
/* 
//Prueba 3: Proceso Normal de Funcionamiento. Acción: Retiro (Fondos Insuficientes):
#9  DIGITO = 2;  
#5 RESET = 0;
   TARJETA_RECIBIDA = 1; //Se pasa al estado: Esperando primer dígito.

   DIGITO_STB = 1; //Se pasa al estado: Esperando segundo dígito.
#1 DIGITO_STB = 0;
 
#5   DIGITO = 1;
#5   DIGITO_STB = 1; //Se pasa al estado: Esperando tercer dígito.
#2 DIGITO_STB = 0;

#5   DIGITO = 9;
#5   DIGITO_STB = 1; //Se pasa al estado: Esperando cuarto dígito.
#2 DIGITO_STB = 0;

#5   DIGITO = 8;
#5   DIGITO_STB = 1; //Se pasa al estado: Verificando PIN.
#2 DIGITO_STB = 0;
   BALANCE = 64'h000000;
   MONTO = 32'h500000;
   MONTO_STB = 1;
   
   TIPO_TRANS = 1; //Se pasa al estado: Retiro.

//Prueba 4: Proceso Pin Incorrecto: Bloqueo:

#5 RESET = 0;
#5 TARJETA_RECIBIDA = 1; //Se pasa al estado: Esperando primer dígito.
   
#3 DIGITO_STB = 1; //Se pasa al estado: Esperando segundo dígito.
#5 DIGITO_STB = 0;
   TARJETA_RECIBIDA = 0;

#5 DIGITO = 1;
   DIGITO_STB = 1; //Se pasa al estado: Esperando tercer dígito.
#5 DIGITO_STB = 0;

#5 DIGITO = 2;
   DIGITO_STB = 1; //Se pasa al estado: Esperando cuarto dígito.
#5 DIGITO_STB = 0;

#5 DIGITO = 3;
   DIGITO_STB = 1; //Se pasa al estado: Verificando PIN.
#5 DIGITO_STB = 0;

//Segundo Intento

#5 RESET = 0;
#5 TARJETA_RECIBIDA = 1; //Se pasa al estado: Esperando primer dígito.
   DIGITO = 3;
#3 DIGITO_STB = 1; //Se pasa al estado: Esperando segundo dígito.
#5 DIGITO_STB = 0;
   TARJETA_RECIBIDA = 0;

#5 DIGITO = 2;
   DIGITO_STB = 1; //Se pasa al estado: Esperando tercer dígito.
#5 DIGITO_STB = 0;

#5 DIGITO = 1;
   DIGITO_STB = 1; //Se pasa al estado: Esperando cuarto dígito.
#5 DIGITO_STB = 0;

#5 DIGITO = 2;
   DIGITO_STB = 1; //Se pasa al estado: Verificando PIN.
#5 DIGITO_STB = 0;

//Tercer Intento

#5 RESET = 0;
#5 TARJETA_RECIBIDA = 1; //Se pasa al estado: Esperando primer dígito.
   DIGITO = 3;
#3 DIGITO_STB = 1; //Se pasa al estado: Esperando segundo dígito.
#5 DIGITO_STB = 0;
   TARJETA_RECIBIDA = 0;

#5 DIGITO = 2;
   DIGITO_STB = 1; //Se pasa al estado: Esperando tercer dígito.
#5 DIGITO_STB = 0;

#5 DIGITO = 1;
   DIGITO_STB = 1; //Se pasa al estado: Esperando cuarto dígito.
#5 DIGITO_STB = 0;

#5 DIGITO = 2;
   DIGITO_STB = 1; //Se pasa al estado: Verificando PIN.
#5 DIGITO_STB = 0;
*/
#200 $finish;
end 

always begin
    #5 CLK = !CLK;
end
endmodule