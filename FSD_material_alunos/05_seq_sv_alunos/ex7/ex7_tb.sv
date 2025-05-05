/**************************************************************
    Fernando Moraes - 21/abril/2025
**************************************************************/

module tb;

    logic rst = 0;
    logic fin = 0;
    logic fout;

    always #10 fin = ~fin;

    initial begin
        rst = 1;
        #5 rst = 0;
    end
    
    ex7 dut (  .rst(rst),  .fin(fin),  .fout(fout)  );

endmodule
