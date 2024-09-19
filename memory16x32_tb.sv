`include "transaction_class.sv"
`include "sequencer_class.sv"
`include "driver_class.sv"
`include "interface.sv"
`include "monitor_class.sv"
`include "enviroment_class.sv"

module memory_tb();

sequencer seq;
mailbox mbox;
driver div;
    initial
        begin
        mbox = new();
        seq = new(mbox);
        div = new(mbox);
        seq.run();
        div.run();
        end
    
endmodule