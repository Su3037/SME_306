library verilog;
use verilog.vl_types.all;
entity tb_basic_6x6_mul is
    generic(
        width           : integer := 6
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
end tb_basic_6x6_mul;
