/**************************************************************
    Fernando Moraes - 21/abril/2025
**************************************************************/
module div_serial #(
    parameter int N = 32
)(
    input  logic  clock, reset, start,
    input  logic [N-1:0]   A,
    input  logic [N-1:0]   B,
    output logic           end_div,
    output logic [N-1:0]   QUO,
    output logic [N-1:0]   RES
);
    typedef enum logic [1:0] { INICIO, DESLOCA, SUBTRAI, FIM } state;
    state EA, PE;

    logic [2*N:0] regPA;
    logic [N:0]   regB, sub;
    int           cont;

    // Subtração combinacional
    assign sub = regPA[2*N:N] - regB;

    // Fim de operação
    assign end_div = (EA == FIM);

    // Controle de estado atual
    always_ff @(posedge clock or posedge reset) begin
        if (reset)
            EA <= INICIO;
        else
            EA <= PE;
    end

    // Lógica de transição de estados
    always_comb begin
        unique case (EA)
            INICIO:   PE = (start) ? DESLOCA : INICIO;
            DESLOCA:  PE = SUBTRAI;
            SUBTRAI:  PE = (cont == N-1) ? FIM : DESLOCA;
            FIM:      PE = INICIO;
            default:  PE = INICIO;
        endcase
    end

    // block de dados
    always_ff @(posedge clock or posedge reset) begin
        if (reset) begin
            QUO <= '0;
            RES <= '0;
            cont <= 0;
            regPA <= '0;
            regB  <= '0;
        end else begin
            case (EA)
                INICIO: begin
                    regPA <= { {(N+1){1'b0}}, A };
                    regB <= {1'b0, B};  // extensão para comparação com sinal
                    cont <= 0;
                end

                DESLOCA: begin
                    regPA <= {regPA[2*N-1:0], 1'b0};  // desloca à esquerda
                end

                SUBTRAI: begin
                    if (!sub[N])  // sub >= 0
                        regPA[2*N:N] <= sub;

                    regPA[0] <= ~sub[N];  // bit de quociente
                    cont <= cont + 1;
                end

                FIM: begin
                    QUO <= regPA[N-1:0];
                    RES <= regPA[2*N-1:N];
                end
            endcase
        end
    end

endmodule
