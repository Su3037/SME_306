module mul_row#(
    parameter x_width  = 6, 
    parameter row_now  = 0 
)(
    input  [x_width-1:0]  x_data, //data of this row 
    input  [x_width-1:0]  r_data, //data of the row above
    input                 y_abit, 
    output [x_width-1:0]  o_data,
    output                o_cout
);



genvar i;
generate
    if(row_now == 0)begin:gen_first_row
        assign o_data = x_data & {x_width{y_abit}}; 
        assign o_cout = 1'b0;
    end 
    
    else if(row_now==x_width-1)begin:gen_last_row

        wire [x_width-1:0] a_data=x_data & {x_width{y_abit}};
        wire [x_width-1:0] b_data=r_data;
        wire [x_width-1:0] c_data;
        assign o_cout = c_data[x_width-1];

        for(i=0;i<x_width;i=i+1)begin:gen_last_row_adder
            if(i==0)begin:gen_last_row_adder0_HA

                half_adder u_half_adder(
                    .a    	(a_data[i]     ),
                    .b    	(b_data[i]     ),
                    .sum  	(o_data[i]     ),
                    .cout 	(c_data[i]     )
                );
                
            end 
            else begin:gen_last_row_adderx_FA

                
                full_adder u_full_adder(
                    .a    	(a_data[i]     ),
                    .b    	(b_data[i]     ),
                    .cin  	(c_data[i-1]   ),
                    .sum  	(o_data[i]     ),
                    .cout 	(c_data[i]     )
                );
                
            end
        end
    end

    else begin:gen_mid_row
        wire [x_width-1:0] a_data=x_data & {x_width{y_abit}};
        wire [x_width-1:0] b_data=r_data;
        wire [x_width-1:0] c_data;
        assign o_cout = c_data[x_width-1];

        for(i=0;i<x_width;i=i+1)begin:gen_last_row_adder
            if(i==0)begin:gen_last_row_adder0_HA

                half_adder u_half_adder(
                    .a    	(a_data[i]     ),
                    .b    	(b_data[i]     ),
                    .sum  	(o_data[i]     ),
                    .cout 	(c_data[i]     )
                );
                
            end 
            else if(i==x_width-1)begin:gen_last_row_adderl_HA

                half_adder u_full_adder(
                    .a    	(a_data[i]     ),
                    .b    	(b_data[i]     ),
                    .sum  	(o_data[i]     ),
                    .cout 	(c_data[i]     )
                );
                
            end
            else begin:gen_last_row_adderx_FA

                
                full_adder u_full_adder(
                    .a    	(a_data[i]     ),
                    .b    	(b_data[i]     ),
                    .cin  	(c_data[i-1]   ),
                    .sum  	(o_data[i]     ),
                    .cout 	(c_data[i]     )
                );
                
            end
        end
    end
endgenerate
endmodule