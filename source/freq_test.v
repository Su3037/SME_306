module freq_test#(
    parameter width = 6
)(
    input                clk    ,
    input                rst_n  ,
    input  [width-1:0]   x      ,
    input  [width-1:0]   y      ,
    output [2*width-1:0] mul_out
);

//=======================================
// wire & reg
//=======================================
reg [width-1:0] x_reg; //input x
reg [width-1:0] y_reg; //input y
reg [2*width-1:0] mul_out_reg; //output mul_out
wire [2*width-1:0] mul_out_gen; //wire for mul_out

//=======================================
// instance
//=======================================
basic_mul_top#(
    .width(width)
) uut (
    .x(x_reg),
    .y(y_reg),
    .mul_out(mul_out_gen)
);
//=======================================
// always block
//=======================================
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        x_reg <= 0;
        y_reg <= 0;
        mul_out_reg <= 0;
    end else begin
        x_reg <= x;
        y_reg <= y;
        mul_out_reg <= mul_out_gen;
    end
end
//=======================================
// assign output
//=======================================
assign mul_out = mul_out_reg;
endmodule