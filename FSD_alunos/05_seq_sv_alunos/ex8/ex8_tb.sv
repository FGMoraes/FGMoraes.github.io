/**************************************************************
    Fernando Moraes - 20/abril/2025
**************************************************************/

module tb;

    logic reset = 0;
    logic send  = 0;
    logic req   = 0;
    logic ck    = 0;
    logic [3:0] entrada;
    logic [3:0] saida;

    logic [3:0] padrao_de_teste [0:15] = '{
        4'h1, 4'h2, 4'h3, 4'h4,
        4'h5, 4'h6, 4'h7, 4'h8,
        4'h3, 4'h4, 4'h4, 4'h5,
        4'h2, 4'h1, 4'h1, 4'h3
    };

    always #5 ck = ~ck;

    initial begin
        reset = 1;
        #3 reset = 0;
    end

    ex8 dut ( .clock(ck),  .reset(reset),  .send(send),  .req(req),  .entrada(entrada),  .saida(saida) );

    // Processo de envio e requisição
    initial begin
        send = 0;
        req  = 0;

        for (int i = 0; i < 16; i++) begin
            entrada = padrao_de_teste[i];
            send = 1;
            #10;
            send = 0;
            #10;
        end

       #40;

       for (int i = 0; i < 4; i++) begin
            req = 1;
            #10;
            req = 0;
            #10;
        end
  
        #40 $finish;
    end

endmodule
