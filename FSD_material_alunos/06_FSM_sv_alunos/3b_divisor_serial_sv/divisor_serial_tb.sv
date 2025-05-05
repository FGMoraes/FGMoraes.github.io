/**************************************************************
    Fernando Moraes - 21/abril/2025
**************************************************************/
module tb;

    parameter int N = 8;

    logic clock = 0;
    logic reset, start, end_div;
    logic [N-1:0] op1, op2, QUO, RES;

    // Tipo de vetor de teste com inteiros
    typedef struct {
        int a;
        int b;
    } test_record_t;

    // Lista de padrões de teste
    test_record_t tests[] = '{
        '{27, 5},       //   5/2  
        '{163, 17},     //   9/10
        '{217, 41},     //   5/12
        '{254, 253},    //   1/1
        '{5, 124},      //   0/5
        '{225, 15},     //   15/0
        '{0, 255}       //   0/0
    };

    // Instância do DUT
    div_serial #(.N(N)) dut (
        .clock(clock),
        .reset(reset),
        .start(start),
        .A(op1),
        .B(op2),
        .end_div(end_div),
        .QUO(QUO),
        .RES(RES)
    );

    // Clock de 10 ns (5 ns por borda)
    always #5 clock = ~clock;

    // Sequência de teste
    initial begin
        reset = 1;
        start = 0;
        #10 reset = 0;

        foreach (tests[i]) begin
            op1 = tests[i].a[N-1:0];  // conversão implícita com truncamento
            op2 = tests[i].b[N-1:0];
            start = 1;
            #10 start = 0;
            wait (end_div == 1);
            #10;
        end
        #400
        $finish;
    end

endmodule