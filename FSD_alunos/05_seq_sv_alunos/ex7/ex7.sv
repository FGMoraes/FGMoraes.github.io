/**************************************************************
    Fernando Moraes - 20/abril/2025
**************************************************************/

module ex7 (
    input  logic fin,
    input  logic rst,
    output logic fout
);

    logic A, B, C;

    always_ff @(posedge fin or posedge rst) begin
        if (rst)
            A <= 0;
        else
            A <= ~A;
    end

    always_ff @(posedge A or posedge rst) begin
        if (rst)
            B <= 0;
        else
            B <= ~B;
    end

    always_ff @(posedge B or posedge rst) begin
        if (rst)
            C <= 0;
        else
            C <= ~C;
    end

    assign fout = C;

endmodule
