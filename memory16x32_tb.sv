`include "transaction_class.sv"
`include "sequencer_class.sv"
`include "driver_class.sv"
`include "interface.sv"
`include "monitor_class.sv"
`include "scoreboard_class.sv"
`include "enviroment_class.sv"

module memory_tb();
    

    Enviroment env;
    intf intf1 ();

    initial
        begin
        env = new();
        env.run(intf1);
        end

    initial
        begin
            intf1.CLK = 1;
            forever #5 intf1.CLK = ~intf1.CLK;
            #500;
            $finish();
        end

    initial begin
        $dumpfile("Memory_file.vcd");
        $dumpvars(0, memory_tb); // Top-level
        $dumpvars(1, memory_tb.mem_unit); // Memory module instance
        $dumpvars(2, memory_tb.mem_unit.memory); // Directly target the memory array

        end


    Memory mem_unit (
    .Data_in(intf1.Data_in),
    .Address(intf1.Address),
    .W_EN(intf1.W_EN),
    .CLK(intf1.CLK),
    .RST(intf1.RST),
    .Data_out(intf1.Data_out)
    );
    
endmodule