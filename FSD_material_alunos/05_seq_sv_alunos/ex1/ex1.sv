/**************************************************************
    Fernando Moraes - 20/abril/2025
**************************************************************/

// ************************************************************
// LATCH DE N BITS
// ************************************************************

module latch #(parameter int N = 16) (
    input  logic             ck,
    input  logic             rst,
    input  logic             ce,
    input  logic [N-1:0]     D,
    output logic [N-1:0]     Q
);
    always_latch begin
        if (rst)
            Q = '0;
        else if (ck && ce)
            Q = D;
    end
endmodule

// ************************************************************
// FLIP-FLOP MESTRE-ESCRAVO DE N BITS
// ************************************************************

module ffd_ms #(parameter int N = 16) (
    input  logic             ck,
    input  logic             rst,
    input  logic             ce,
    input  logic [N-1:0]     D,
    output logic [N-1:0]     Q
);
    always_ff @(posedge ck or posedge rst) begin
        if (rst)
            Q <= '0;
        else if (ce)
            Q <= D;
    end
endmodule



// ************************************************************
// TEST BENCH
// ************************************************************

module tb;

    logic reset, ce;
    logic ck = 0;
    logic [7:0] D, q_ms, q_lt;

    always #20 ck = ~ck;

    initial begin
        reset = 1;
        #5 reset = 0;
    end

    initial begin
        ce = 1;
        #50 ce = 0;
        #30 ce = 1;
    end

    initial begin
        D = 8'hAA;        // t = 0
        #18 D = 8'h11;    // t = 18
        #4  D = 8'h20;    // t = 22
        #2  D = 8'h31;    // t = 24
        #2  D = 8'h40;    // t = 26
        #4  D = 8'h51;    // t = 30
        #4  D = 8'h60;    // t = 34
        #2  D = 8'h71;    // t = 36
        #9  D = 8'h80;    // t = 45
        #3  D = 8'h91;    // t = 48
        #10 D = 8'hA0;    // t = 58
        #12 D = 8'hB1;    // t = 70
        #5  D = 8'hC0;    // t = 75
        #14 D = 8'hD1;    // t = 89
        #1  D = 8'hE0;    // t = 90
        #20 D = 8'hF1;    // t = 110
        #60 D = 8'h00;    // t = 170
        #60 D = 8'hEE;    // t = 230
        // #50 $finish;
    end

    // Instância do latch
    latch #(.N(8)) regLT (
        .ck(ck),
        .rst(reset),
        .ce(ce),
        .D(D),
        .Q(q_lt)
    );

    // Instância do registrador mestre-escravo
    ffd_ms #(.N(8)) regMS (
        .ck(ck),
        .rst(reset),
        .ce(ce),
        .D(D),
        .Q(q_ms)
    );

endmodule

