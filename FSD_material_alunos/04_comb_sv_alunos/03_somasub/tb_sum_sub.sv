/*
    testbench par o modulo que realizar soma/subtração em função de mode
    Fernando Moraes - 13/abril/2025
*/
module tb;

  parameter N = 4;

  logic [N-1:0] A, B;
  logic mode;
  logic [N-1:0] Sum;
  logic Cout, ov;

  // Instancia o DUT (Device Under Test)
  sum_sub #(.N(N)) 
         dut ( .A(A),  .B(B),  .mode(mode), .Sum(Sum), .Cout(Cout), .ov(ov)  );

  // Vetores de entrada constantes (exemplos de 4 bits)
  const logic [N-1:0] vec_A [0:6] =  '{4'hA, 4'hB, 4'h8, 4'h5, 4'hE, 4'hF, 4'hF};
  const logic [N-1:0] vec_B [0:6] =  '{4'h6, 4'h2, 4'hC, 4'hE, 4'h5, 4'hF, 4'hF};
  const logic         v_mode[0:6] = '{1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b1};

  initial begin

    for (int i = 0; i < 7; i++) begin
      A   = vec_A[i];
      B   = vec_B[i];
      mode = v_mode[i];
      #10;
    end

    $finish;
  end

endmodule