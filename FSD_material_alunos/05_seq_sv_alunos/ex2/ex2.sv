/**************************************************************
    Fernando Moraes - 20/abril/2025
**************************************************************/

// ************************************************************
// REGISTRADOR DE DESLOCAMENTO
// ************************************************************

module shift_reg #(parameter int N = 4)
  (
    input  logic              ck, rst,
    input  logic [N-1:0]      in,
    output logic [N-1:0]      out
 );

    logic [N-1:0] A, B, C;

    assign out = C;

    always_ff @(posedge ck or posedge rst) begin
        if (rst) begin
            A <= '0;            
            B <= '0;            
            C <= '0;            
        end 
        else begin
            A <= in;             
            B <= A;             
            C <= B;  
        end
    end
 
endmodule


// ************************************************************
// TEST BENCH
// ************************************************************

module tb;

    logic ck = 0;
    logic reset;
    logic [7:0] entrada, saida;

    shift_reg #(.N(8)) sr (.ck(ck), .rst(reset), .in(entrada), .out(saida));
 
    always #5 ck = ~ck;

    initial begin
        reset = 1;
        #4 reset = 0;
    end

    initial begin
        int unsigned i;
        for (i = 0; i < 20; i++) begin
            entrada = i * 10;
            #10;
        end

        // $finish;
    end

    // Opcional: monitoramento
    initial begin
        $display("Time clk rst  D  Q");
        $monitor("%3t  %b  %b   %h %h", $time, ck, reset, entrada, saida);
    end

endmodule
