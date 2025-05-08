module half_adder(
    input  a   , 
    input  b   , 
    output sum , 
    output cout
);
  assign sum  = a ^ b;               // Sum  = a xor b
  assign cout = a & b;               // Cout = a and b
endmodule