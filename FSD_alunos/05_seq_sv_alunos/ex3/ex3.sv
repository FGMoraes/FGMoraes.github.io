/**************************************************************
    Fernando Moraes - 20/abril/2025
**************************************************************/

// ************************************************************
// MÓDULO EX3 — Sequência com Soma (semelhante a Fibonacci)
// ************************************************************

module ex3 (
    input  logic             clock,
    input  logic             reset,
    output logic [7:0]       saida
);

    logic [7:0] R1, R2;

    always_ff @(posedge clock or posedge reset) begin
        if (reset) begin
            R1 <= 8'h01;
            R2 <= '0;
        end else begin
            R1 <= saida;
            R2 <= R1;
        end
    end

    assign saida  = R1 + R2;

endmodule


// ************************************************************
// TEST BENCH
// ************************************************************
module tb;

    logic reset;
    logic ck = 0;
    logic [7:0] saida;

    always #20 ck = ~ck;

    initial begin
        reset = 1;
        #5 reset = 0;
    end

    ex3 dut (
        .clock(ck),
        .reset(reset),
        .saida(saida)
    );

endmodule
