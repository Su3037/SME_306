library verilog;
use verilog.vl_types.all;
entity mul_row is
    generic(
        x_width         : integer := 6;
        row_now         : integer := 0
    );
    port(
        x_data          : in     vl_logic_vector;
        r_data          : in     vl_logic_vector;
        y_abit          : in     vl_logic;
        o_data          : out    vl_logic_vector;
        o_cout          : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of x_width : constant is 1;
    attribute mti_svvh_generic_type of row_now : constant is 1;
end mul_row;
