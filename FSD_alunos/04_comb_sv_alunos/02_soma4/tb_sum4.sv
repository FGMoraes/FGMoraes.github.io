/*
    Testbench para o somador de 4 bits
    Fernando Moraes - 13/abril/2025
*/
module tb;

  parameter N = 4;

  logic [N-1:0] A, B;
  logic Cin;
  logic [N-1:0] Sum;
  logic Cout, ov;

  // Instancia o DUT (Device Under Test)
  Adder4 #(.N(N)) 
         dut ( .A(A),  .B(B),  .Cin(Cin), .Sum(Sum), .Cout(Cout)  );

  // Vetores de entrada constantes (exemplos de 4 bits)
  const logic [N-1:0] vec_A [0:4] = '{4'd3,  4'd7, 4'd2, 4'd8, 4'd15};
  const logic [N-1:0] vec_B [0:4] = '{4'd1,  4'd4, 4'd5, 4'd6, 4'd3};
  const logic         vec_Cin[0:4] = '{1'b0, 1'b1, 1'b0, 1'b1, 1'b0};

  initial begin

    for (int i = 0; i < 5; i++) begin
      A   = vec_A[i];
      B   = vec_B[i];
      Cin = vec_Cin[i];
      #10;
      $display("A=%d B=%d Cin=%b Sum=%d Cout=%b", A, B, Cin, Sum, Cout);
    end

    $finish;
  end

endmodule