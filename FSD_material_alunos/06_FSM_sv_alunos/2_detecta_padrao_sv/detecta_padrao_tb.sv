/**************************************************************
    Fernando Moraes - 21/abril/2025
**************************************************************/
module tb;

    logic clk = 0;
    logic rst;
    logic din;
    logic dout;

    fsm dut ( .clk(clk),  .rst(rst), .din(din), .dout(dout));

    always #5 clk = ~clk;

    logic [15:0] padrao_de_teste = 16'b1011011010011010;

    initial begin
        rst = 1;
        #5 rst = 0;
    end

    initial begin
        for (int i = 15; i >= 0; i--) begin
            din = padrao_de_teste[i];
            #10;
        end

        $finish;
    end

endmodule