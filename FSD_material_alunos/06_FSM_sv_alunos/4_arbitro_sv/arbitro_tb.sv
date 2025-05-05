/**************************************************************
    Fernando Moraes - 21/abril/2025
**************************************************************/
module tb;

    logic clock = 0;
    logic reset;
    logic [3:0] req, grant, rrelease;

    // DUT
    arbitro dut ( .clock(clock),  .reset(reset),  .req(req),  .rrelease(rrelease),  .grant(grant) );

    always #5 clock = ~clock;

     initial begin    // reset
        reset = 1;
        #3 reset = 0;
     end

    initial begin    // geração do req
        fork
            begin
                req[0]=1;  #800 req[0]=0;  #500 req[0]=1;  #300 req[0]=0;
            end

            begin
                req[1]=0;  #300 req[1]=1;   #700 req[1]=0;
            end

            begin
                req[2]=0; #300 req[2]=1;  #700 req[2]=0;  #300 req[2]=1;   #300 req[2]=0;
            end

            begin
                req[3]=0; #300 req[3]=1;  #700 req[3]=0;
            end
        join
    end

    // Release de cada módulo
    initial begin
        rrelease = 0;

        for (int i = 0; i < 4; i++) begin
            fork
                automatic int idx = i; // importante!
                forever begin
                    wait (grant[idx]);
                    #40 rrelease[idx] = 1;
                    #20 rrelease[idx] = 0;
                end
            join_none
        end
    end


endmodule

