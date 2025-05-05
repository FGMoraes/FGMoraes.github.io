/*
    ULA  Unidade Lógico-Aritmética
    Fernando Moraes - 13/abril/2025
*/

//--------------------------------------
// Pacote com enumeração da ULA
//--------------------------------------
package p_ula;

  // Declaração do tipo enumerado para operações da ULA
  typedef enum logic [3:0] {     //até 15 operações
    uAND,     // AND lógico
    uOR,      // OR lógico
    uXOR,     // XOR lógico
    uADD,     // Soma
    uSUB,     // Subtração
    uINC,     // Incremento
    uDEC,     // Decremento
    uNEG,      // Negação
    uZero,     // zero
    uSLL,     // Shift lógico à esquerda
    uSRL     // Shift lógico à direita
  } op_alu;

endpackage



//--------------------------------------
// Módulo ula
//--------------------------------------
module ula (
  input  logic [7:0] op1, op2,
  input  p_ula::op_alu opmode,
  output logic z, cout, ov,
  output logic [7:0] outalu
);

  import p_ula::*;

  logic [7:0] aa, bb, soma;
  logic mode;

  assign z = (outalu == 8'h00) ? 1'b1 : 1'b0;    // Detecta zero na saída 

  // Define modo de operação para soma/sub baseado no tipo de operação
  assign mode = (opmode == uADD || opmode == uINC) ? 1'b0 : 1'b1;

  // Define operandos para unidade soma/sub
  assign aa = (opmode == uNEG) ? 8'h00 : op1;

  assign bb = (opmode == uINC)  ? 8'h01 :
              (opmode == uNEG) ? op1 : op2;

  // Instancia o módulo soma_sub (equivalente ao sb do VHDL)
  sum_sub #(.N(8)) sb ( .A(aa),  .B(bb), .mode(mode),  .Sum(soma), .Cout(cout),  .ov(ov) );

  // Saída principal da ALU
  always_comb begin
    outalu = (opmode == uAND) ? (op1 & op2) :
              (opmode == uOR)  ? (op1 | op2) :
              (opmode == uXOR) ? (op1 ^ op2) :
              (opmode == uSLL) ? {op1[6:0], 1'b0} :
              (opmode == uSRL) ? {1'b0, op1[7:1]} :
              soma; // default: resultado da unidade soma/sub
  end

endmodule