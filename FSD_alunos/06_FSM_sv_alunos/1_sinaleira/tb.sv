/**************************************************************
    Fernando Moraes - 21/abril/2025
**************************************************************/

module tb;

    logic clk = 0;
    logic rst = 0;
    logic Ta = 1;
    logic Tb = 0;
    logic [1:0] La, Lb;

    // Instância do DUT
    fsm1 UUT (.clk(clk), .reset(rst), .Ta(Ta),. Tb(Tb), .La(La), .Lb(Lb));

    // Clock de 5 ns período (2.5 ns high/low)
    always #2.5 clk = ~clk;

    // Reset ativo por 3 ns
    initial begin
        rst = 1;
        #3 rst = 0;
    end

    // Estímulo das entradas
    initial begin
        forever begin
            #50 Ta = ~Ta;
        end
    end

    initial begin
        forever begin
            #50 Tb = ~Tb;
        end
    end

endmodule
