/*
 * 
 * TEST BEHNCH PARA A NANO CPU 
 * Fernando Gehm Moraes
 * 02/maio/2025
 * 
*/
module tb;

  timeunit 1ns;
  timeprecision 1ps;

  logic ck, rst;
  logic [15:0] dataR, dataW;
  logic [7:0] address;
  logic we, ce;

  // Memory array signal for 256 x 16-bit positions
  typedef logic [15:0] memory_array_t [0:255];


    memory_array_t memory = '{     // fibonacci 
        0: 'h4111,  // (fib1) R1 <- 0
        1: 'h8200,  // (fib2) inc R2 (R2 <- R0 + 1)
        2: 'h4000,  // R0 <- 0 (constant)
        3: 'h1151,  // write fib1 to memory
        4: 'h6312,  // R3 <- R1 + R2 (next value)
        5: 'h4120,  // R1 <- R2 xor R0 (fib1 <- fib2)
        6: 'h4230,  // R2 <- R3 xor R0 (fib2 <- next)
        7: 'h0143,  // R3 <- *N
        8: 'h9333,  // dec N
        9: 'h1143,  // *N <- R0
       10: 'h7303,  // R3 = 1 if N < 0
       11: 'h3033,  // conditional jump to 3
       12: 'hF000,  // end
       20: 'h000E,  // 14 first elements of the series
       21: 'h0000,  // receives the values of the series
       default: 'h0000
    };


  // Generate clock and reset signals
  initial begin
    ck = 1'b0;
    rst = 1'b1;
    #2 rst = 1'b0;
  end

  always #1 ck = ~ck;

  // Instantiate the NanoCPU
  NanoCPU CPU (
    .ck(ck),
    .rst(rst),
    .address(address),
    .dataR(dataR),
    .dataW(dataW),
    .ce(ce),
    .we(we)
  );

  // Write to memory
  always_ff @(posedge ck) begin
    if (we) begin
      memory[address] <= dataW;
    end
  end

  // Read from memory
  assign dataR = memory[address];

endmodule
