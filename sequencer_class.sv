
class sequencer;
    transaction packet;
    mailbox mbox;

    function new(mailbox m);
    mbox = m;
    endfunction

     task run();
        packet = new();
        packet.Data_in = 32'b11110000111100001111000011110000;
        packet.Address = 4'b0011;
        packet.W_EN = 1;
        packet.RST = 1;
        mbox.put(packet);
     endtask
endclass