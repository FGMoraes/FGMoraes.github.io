/**************************************************************
    Fernando Moraes - 20/abril/2025
**************************************************************/

module tb;

    logic clock = 0;
    logic reset, SA, enableA, SB, enableB;
    logic [7:0] X, Y;
    logic [7:0] RB;

    always #10 clock = ~clock;

    ex5 dut (
        .reset(reset),
        .clock(clock),
        .SA(SA),
        .enableA(enableA),
        .SB(SB),
        .enableB(enableB),
        .X(X),
        .Y(Y),
        .RB(RB)
    );

    initial begin
        reset = 1;
        #5 reset = 0;
    end

    initial begin
        SA = 1;
        #60  SA = 0;
        #80  SA = 1;
    end

    initial begin
        enableA = 1;
        #85  enableA = 0;
        #40 enableA  = 1;
    end

    initial begin
        SB = 1;
        #60  SB = 0;
        #80  SB = 1;
    end

    initial begin
        enableB = 1;
        #85  enableB = 0;
        #40 enableB = 1;
    end

    initial begin
        X = 8'h20;
        #20  X = 8'h32;
        #20  X = 8'h43;
        #60  X = 8'h54;
    end

    initial begin
        Y = 8'h44;
        #20  Y = 8'h55;
        #20  Y = 8'h66;
        #60  Y = 8'h77;
    end

endmodule
