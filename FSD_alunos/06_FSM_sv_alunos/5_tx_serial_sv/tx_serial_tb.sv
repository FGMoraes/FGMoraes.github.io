/**************************************************************
    Fernando Moraes - 21/abril/2025
**************************************************************/
module tb;

    logic clock = 0;
    logic reset, send;
    logic busy, linha;
    logic [7:0] palavra;

    // DUT instantiation
    transmissor dut (  .clock(clock),     .reset(reset),   .send(send),
                       .palavra(palavra), .busy(busy),    .linha(linha)  );

    always #10 clock = ~clock;

    initial begin
        reset = 1;
        #3 reset = 0;
    end

    // Send signal stimulus
    initial begin
        send = 0;
        #23  send = 1;
        #27  send = 0;
        #250 send = 1;
        #20  send = 0;
    end

    // Palavra de dados
    initial begin
        palavra = 8'b11010001;
        #300 palavra = 8'b00100110;
    end

endmodule
