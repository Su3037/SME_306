#-------------------------------------------------
# Main Clock
#-------------------------------------------------
create_clock -name clk -period 3 [get_ports clk] 

# 模块层次保留
set_property KEEP_HIERARCHY TRUE [get_cells uut]
