// 采用Dadda树压缩的6×6乘法器，门级优化
module mul6x6 (
    input [5:0] a,
    input [5:0] b,
    output [11:0] p
);

// 第一部分：部分积生成（使用NAND+INV替代AND）
wire [5:0] pp [5:0]; // 6个部分积
genvar i, j;
generate
for(i=0; i<6; i=i+1) begin: gen_pp_row
    for(j=0; j<6; j=j+1) begin: gen_pp_col
        // 每个AND门用NAND+INV实现（共6T）
        wire nand_out;
        nand2 U1(.a(a[i]), .b(b[j]), .y(nand_out));
        inv  U2(.a(nand_out), .y(pp[i][j]));
    end
end
endgenerate

// 第二部分：Dadda树压缩（3级压缩）
// Level 3: 高度6→4
wire [10:0] level3 [3:0];
dadda_level3 U_level3 (
    .pp(pp),
    .out(level3)
);

// Level 2: 高度4→3
wire [10:0] level2 [2:0]; 
dadda_level2 U_level2 (
    .in(level3),
    .out(level2)
);

// Level 1: 高度3→2 
wire [10:0] sum, carry;
dadda_level1 U_level1 (
    .in(level2),
    .sum(sum),
    .carry(carry)
);

// 第三部分：最终加法器（进位传播加法器）
// 使用传输门优化的行波进位加法器
rca12 U_rca (
    .a({1'b0, sum}),
    .b({carry, 1'b0}),
    .sum(p)
);

endmodule

// 关键子模块实现
module dadda_level3(
    input [5:0] pp [5:0],
    output [10:0] out [3:0]
);
// 第一级压缩规则：
// 使用全加器(FA)和半加器(HA)压缩高度6→4
// 具体布线省略（需按Dadda算法精确排列）
// 每个FA用优化的门电路实现（约28T）
endmodule

// 优化后的全加器（镜像加法器结构，约28T）
module fa(
    input a, b, cin,
    output sum, cout
);
wire w1,w2,w3,w4;
// Sum = a ^ b ^ cin
xor2 U1(.a(a), .b(b), .y(w1));
xor2 U2(.a(w1), .b(cin), .y(sum));

// Cout = a&b | (a^b)&cin 
nand2 U3(.a(a), .b(b), .y(w2));
nand2 U4(.a(w1), .b(cin), .y(w3));
nand2 U5(.a(w2), .b(w3), .y(cout));
endmodule

// 优化后的半加器（约12T）
module ha(
    input a, b,
    output sum, cout
);
xor2 U1(.a(a), .b(b), .y(sum));
nand2 U2(.a(a), .b(b), .y(cout));
endmodule