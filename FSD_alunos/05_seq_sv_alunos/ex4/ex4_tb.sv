/**************************************************************
    Fernando Moraes - 20/abril/2025
**************************************************************/

module tb;

    logic reset;
    logic ck = 0;
    logic [7:0] saida;

    always #20 ck = ~ck;

    // Reset por 5 ns
    initial begin
        reset = 1;
        #5 reset = 0;
    end

    ex4 #(.N(8)) dut (
        .clock(ck),
        .reset(reset),
        .saida(saida)
    );

endmodule
