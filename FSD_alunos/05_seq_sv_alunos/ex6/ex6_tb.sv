/**************************************************************
    Fernando Moraes - 20/abril/2025
**************************************************************/

module tb;

    logic reset = 0;
    logic ck    = 0;
    logic DS    = 0;
    logic [1:0] mu = 2'b00;
    logic [7:0] X = 8'h00, Y = 8'h00, Z = 8'h00;
    logic [7:0] RA, RB;

    always #10 ck = ~ck;

    initial begin
        reset = 1;
        #5 reset = 0;
    end

    always #60 DS = ~DS;

    // Estímulos sincronizados com clock
    always_ff @(posedge ck) begin
        mu <= mu + 1;
        X  <= X + 8'd16;
        Y  <= Y + 8'd5;
        Z  <= Z + 8'd2;
    end

    // Instância do DUT
    ex6 dut (
        .reset(reset),
        .clock(ck),
        .DS(DS),
        .mu(mu),
        .X(X),
        .Y(Y),
        .Z(Z),
        .RA(RA),
        .RB(RB)
    );

endmodule
