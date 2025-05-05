/*
    ULA  Unidade Lógico-Aritmética
    Fernando Moraes - 13/abril/2025
*/

module tb;

  import p_ula::*;

  logic [7:0] op1, op2, outalu;
  logic z, cout, ov;
  op_alu opmode;

  // Estrutura de teste
  typedef struct packed {
    logic [7:0] a;
    logic [7:0] b;
  } test_record_t;

  //Inicializaçao dos vetores de teste
  typedef test_record_t test_array_t[];

  const test_array_t padrao_de_teste = '{
    '{8'hAA, 8'h55},
    '{8'hFF, 8'hFF},
    '{8'h34, 8'h00},
    '{8'h00, 8'h22},
    '{8'h56, 8'h01},
    '{8'h05, 8'h0A}
  };

  // Instanciação da ULA
  ula dut (  .op1(op1), .op2(op2),  .outalu(outalu),  .z(z), .cout(cout),  .ov(ov), .opmode(opmode) );

  // Processo de teste
  initial begin
    for (int op = 0; op <= 10; op++) begin  // varredura de operações até a última
      opmode = op_alu'(op);

      foreach (padrao_de_teste[i]) begin
        op1 = padrao_de_teste[i].a;
        op2 = padrao_de_teste[i].b;
        #10;
        #10 $display("op1=%2h op2=%2h oper=%0h - out=%2h cout=%b ov=%b", op1, op2, opmode, outalu, cout, ov);

      end
    end

    $finish;
  end

endmodule

