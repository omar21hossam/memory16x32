

class Enviroment;

    sequencer seq;
    mailbox mbox;
    mailbox mbox2;
    event handover;
    event handover2;
    driver div;
    monitor mon;
    scoreboard sb;

    function  new();
        mbox = new();
        mbox2 = new();
        seq = new(mbox, handover);
        div = new(mbox, handover);
        mon = new(mbox2, handover2);
        sb = new(mbox2, handover2);
    endfunction
    

    task run(virtual intf vif);
     fork
        seq.run();
        div.run(vif);
        mon.run(vif);
        sb.run();
     join_any
        foreach (ref_memory[i]) begin
            $display("Enviroment: Index %0d: %0d", i, ref_memory[i]);
        end 
        @(negedge vif.CLK);
        $finish();
    endtask


endclass