module full_adder(
    input  a   , 
    input  b   , 
    input  cin ,
    output sum , 
    output cout
);

wire gen_c;
wire pro_c;

assign gen_c = a & b;               // Generate carry
assign pro_c = a ^ b;               // Propagate carry

assign sum  = a ^ b ^ cin;               // Sum  = a xor b xor cin
assign cout = gen_c | (cin & pro_c);     // Cout = g or (p and cin)

endmodule