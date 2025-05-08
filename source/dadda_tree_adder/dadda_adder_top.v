//=========================================================================================================
//                                   DADDA TREE ADDER FOR 6x6 MULTIPLIER
//=========================================================================================================
module dadda_mul6x6 (
    input  [5:0]  a ,
    input  [5:0]  b ,
    output [11:0] p
);
//-------------------------------------------------
// PART I : Partial Product Generation 
//-------------------------------------------------
    wire [5:0] pp [5:0];                                     // 6 partial products

    genvar i, j;
    generate
        for(i=0; i<6; i=i+1) begin:     gen_pp_row
            for(j=0; j<6; j=j+1) begin: gen_pp_col
                assign pp[i][j] = a[i] & b[j]; // 6T AND gate or NAND+INV
            end
        end
    endgenerate
//-------------------------------------------------
// PART II: DADDA TREE COMPRESSION (3 LEVELS)
//-------------------------------------------------

endmodule