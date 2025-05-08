//==============================================================================================================
// File Name    : half_adder.v
// Module Name  : half_adder
// Author       : Supan
// Version      : 1.0
// Modified     : 2024/05/8
// Description  : a simple full_adder
// Features     : 
//==============================================================================================================
module half_adder(
    input  a   , 
    input  b   , 
    output sum , 
    output cout
);
  assign sum  = a ^ b;               // Sum  = a xor b
  assign cout = a & b;               // Cout = a and b
endmodule