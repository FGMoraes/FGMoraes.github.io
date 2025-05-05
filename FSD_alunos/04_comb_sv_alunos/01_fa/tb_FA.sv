/*
    testbench do FA - Full Adder
    Fernando Moraes - 13/abril/2025
*/
module tb;

  logic a, b, c;
  logic sum, cout;

  // Instancia o módulo FA
  FA dut (
    .a(a),
    .b(b),
    .c(c),
    .sum(sum),
    .cout(cout)
  );

  initial begin
 
    // Varredura completa de combinações binárias para {a,b,c}
    for (int i = 0; i < 8; i++) begin
      {a, b, c} = i[2:0];
      #10;
      $display("a=%b b=%b c=%d --- cout=%b sum=%b", a, b, c, cout, sum,);
    end

    $finish;
  end

endmodule