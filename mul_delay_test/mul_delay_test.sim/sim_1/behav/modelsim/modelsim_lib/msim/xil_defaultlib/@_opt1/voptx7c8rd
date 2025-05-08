library verilog;
use verilog.vl_types.all;
entity basic_mul_top is
    generic(
        width           : integer := 6
    );
    port(
        x               : in     vl_logic_vector;
        y               : in     vl_logic_vector;
        mul_out         : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
end basic_mul_top;
