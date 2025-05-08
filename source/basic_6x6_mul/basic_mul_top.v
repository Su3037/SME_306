//==============================================================================================================
// File Name    : basic_mul_top.v
// Module Name  : basic_mul_top
// Author       : Supan
// Version      : 1.0
// Modified     : 2024/05/8
// Description  : a simple 6x6 multiplier
// Features     : using array architecture
//==============================================================================================================
module basic_mul_top#(
    parameter width = 6
)(
    input  [width-1:0]   x      ,
    input  [width-1:0]   y      ,
    output [2*width-1:0] mul_out
);

//==============================================================================================================
// 1. wire declaration
//==============================================================================================================
    wire  [width-1:0] mul_row_out [width:0]; //mul_row_out[i] is the output of row i
    wire  [width-1:0] r_data_chain[width:0]; //mul_row_cout[i] is the cout of row i
    wire  [width:0]   mul_row_cout         ; //mul_row_cout[i] is the cout of row i

//==============================================================================================================
// 2. prepare inner assignments
//==============================================================================================================
    assign mul_row_out[0] = {width{1'b0}} ; //row 0 is all 0s
    assign mul_row_out[0] = 1'b0          ; //row width is the final output
    assign mul_out[2*width-1:width] = {mul_row_cout[width],mul_row_out[width][width-1:1]}; //final output is the last row's output

//==============================================================================================================
// 3. generate mul_row
//==============================================================================================================
    genvar i,j;
    generate 
        assign r_data_chain[0] = {width{1'b0}};
        for(j=1;j<width+1;j=j+1)begin
            assign r_data_chain[j] = {mul_row_cout[j],mul_row_out[j][width-1:1]};
        end

        for(i=0;i<width;i=i+1)begin:gen_mul_row

            mul_row#(
                .x_width (width),
                .row_now (i    )
            ) u_mul_row(
                .x_data  (x      ),
                .r_data  (r_data_chain[i]  ),
                .y_abit  (y[i]   ),
                .o_data  (mul_row_out [i+1]),
                .o_cout  (mul_row_cout[i+1])
            );
            assign mul_out[i]=mul_row_out[i+1][0]; //mul_out[i] is the output of row i
        end
    endgenerate
endmodule