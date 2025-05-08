`timescale 1ns/1ps
module tb_basic_6x6_mul();
//=======================================
// parameter 
//=======================================
parameter width = 6; //width of the multiplier

//=======================================
// input & output
//=======================================
reg [width-1:0] x; //input x
reg [width-1:0] y; //input y
wire [2*width-1:0] mul_out; //output mul_out

//=======================================
// clk_gen
//=======================================
reg clk; //clock signal
initial begin
    clk = 1'b0;
    forever #5 clk = ~clk; //clock period is 10 time units
end
//=======================================
// instantiation    
//========================================
basic_mul_top#(
    .width(width)
) u_basic_mul_top(
    .x(x),
    .y(y),
    .mul_out(mul_out)
);
//=======================================
// stimulus
//=======================================
initial begin
    // Initialize inputs
    x = 0;
    y = 0;
    
    // Wait for the clock to stabilize
    #10;
    
    // Test case 1: 3 * 2 = 6
    x = 3;
    y = 2;
    #10;
    
    // Test case 2: 4 * 5 = 20
    x = 4;
    y = 5;
    #10;
    
    // Test case 3: 6 * 7 = 42
    x = 6;
    y = 7;
    #10;
    
    // Test case 4: 8 * 9 = 72
    x = 8;
    y = 9;
    #10;

    // Test case 5: 3 * 5 = 15
    x = 3;
    y = 5;
    #10;

    // Finish simulation
    $finish;
end

//======================================================
// waveform dump
//======================================================
initial begin
    $dumpfile("tb_basic_6x6_mul.wave");
    $dumpvars;
    $display("save to tb_basic_6x6_mul.wave");
end
endmodule