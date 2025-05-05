/**************************************************************
    Fernando Moraes - 21/abril/2025
**************************************************************/
module tb;

    logic clock = 0;
    logic reset, start, end_mul;
    logic [31:0] op1, op2;
    logic [63:0] produto;

   typedef struct packed {
        logic [31:0] A;
        logic [31:0] B;
    } test_vector_t;

    // Vetores de teste
    test_vector_t tests[4] = '{  '{32'h12345678, 32'h33333333}, '{32'hFFFFFFFF, 32'hFFFFFFFF},
                                 '{32'h00123045, 32'h33333333}, '{32'hABCDEF89, 32'h98FEDCBA} };
    
    mult_serial dut (  .clock(clock), .reset(reset),  .start(start),  .A(op1),   .B(op2),  .end_mul(end_mul),  .produto(produto)  );

    always #5 clock = ~clock;

    initial begin
        reset = 1;
        #3 reset = 0;
    end
    
    initial begin   // Geração dos operandos

      for(int i=0; i<4; i++) begin
            op1 = tests[i].A;
            op2 = tests[i].B;
            start = 1;
            #10 start = 0;
            wait (end_mul == 1);
            $display("Produto: %h * %h = %h", op1, op2, produto);
            #40;
        end

        #100;   
        $finish;
    end

   

endmodule
