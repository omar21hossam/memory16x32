
class driver;

    transaction packet;
    mailbox mbox;

    function new(mailbox m);
        mbox = m;
    endfunction

    task run();
        packet = new();
        mbox.get(packet);
        $display("Driver: Packet = %p", packet);
        
    endtask

endclass