/**************************************************************
    Fernando Moraes - 21/abril/2025
**************************************************************/

module fsm1 (
    input  logic  clk, reset, Ta, Tb,
    output logic [1:0]  La,
    output logic [1:0]  Lb
);

    typedef enum logic [1:0] { S0, S1, S2, S3 } state;
    state EA, PE;

    // Estado atual 
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            EA <= S0;
        else
            EA <= PE;
    end

    // Transições de estado
    always_comb begin
        unique case (EA) 
            S0:    PE = (Ta == 1'b0) ? S1 : S0;
            S1:    PE = S2;
            S2:    PE = (Tb == 1'b0) ? S3 : S2;
            S3:    PE = S0;
            default: PE = S0;
        endcase
    end

    // Saída La depende do estado
    assign La = (EA == S0) ? 2'b01 :
                (EA == S1) ? 2'b10 :
                             2'b00;

    // Saída Lb depende do estado
    assign Lb = (EA == S2) ? 2'b01 :
                (EA == S3) ? 2'b10 :
                             2'b00;
endmodule
