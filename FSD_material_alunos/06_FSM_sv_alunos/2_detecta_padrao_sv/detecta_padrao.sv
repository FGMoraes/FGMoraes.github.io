/**************************************************************
    Fernando Moraes - 21/abril/2025
**************************************************************/
module fsm (
    input  logic clk,
    input  logic rst,
    input  logic din,
    output logic dout
);

    typedef enum logic [2:0] { S0, S1, S11, S110, S1101 } state_t;

    state_t EA, PE;

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            EA <= S0;
        else
            EA <= PE;
    end

    always_comb begin
        unique case (EA)
            S0:    PE = (din == 1'b1) ? S1   : S0;
            S1:    PE = (din == 1'b1) ? S11  : S0;
            S11:   PE = (din == 1'b0) ? S110 : S11;
            S110:  PE = (din == 1'b1) ? S1101 : S0;
            S1101: PE = (din == 1'b1) ? S11   : S0;
            default: PE = S0;
        endcase
    end

    assign dout = (EA == S1101);

endmodule