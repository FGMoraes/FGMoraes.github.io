/*
    FA - Full Adder
    Fernando Moraes - 13/abril/2025
*/
module FA (
  input  logic a, b, c,
  output logic sum, cout
);

  always_comb begin
    sum  = a ^ b ^ c; 
    cout = (a & b) | (a & c) | (b & c);
  end

endmodule