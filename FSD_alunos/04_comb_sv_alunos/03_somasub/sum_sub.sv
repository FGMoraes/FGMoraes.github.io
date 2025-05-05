/*
    Modulo que realizar soma/subtração em função de mode
    Fernando Moraes - 13/abril/2025
*/
module sum_sub #(parameter N = 4)
    (   input logic [N-1:0] A, B,
        input logic Cin,
        output logic [N-1:0] Sum,
        output logic Cout
    );

   logic [N:0] carry; // vetor de N+1 bits para carregar Cin até Cout
   
   assign carry[0] = Cin;

   // Geração de N instâncias de FA
   genvar i;
   generate
    for (i = 0; i < N; i++) begin 
        FA fa_inst (.a (A[i]), .b (B[i]), .c (carry[i]), .sum (Sum[i]), .cout (carry[i+1]));
       end
   endgenerate

   assign Cout = carry[N];

endmodule

