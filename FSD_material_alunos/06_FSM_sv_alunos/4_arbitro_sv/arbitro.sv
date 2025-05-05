/**************************************************************
    Fernando Moraes - 21/abril/2025
**************************************************************/
module arbitro (
    input  logic        clock,
    input  logic        reset,
    input  logic [3:0]  req,
    input  logic [3:0]  rrelease,
    output logic [3:0]  grant
);
    // DECLARAR  OS ESTADOS 
    // DECLARAR  OS ESTADOS  EA  e  PE

    logic [1:0] sel;

     // I N S E R I R   A   M A Q U I N A   D E   E S T A D O S 


    // Bloco de dados
    always_ff @(posedge clock or posedge reset) begin
        if (reset) begin
            sel <= 2'b00;
        end else if (EA == sselect) begin
            if ( req[(sel + 1) & 2'b11])
                sel <= sel + 1;
            else if (req[(sel + 2) & 2'b11])
                sel <= sel + 2;
            else if (req[(sel + 3) & 2'b11])
                sel <= sel + 3;
            else
                sel <= sel;
        end
    end

    // Grant logic
    assign grant = (EA == ack) ? (4'b0001 << sel) : 4'b0000;

endmodule
