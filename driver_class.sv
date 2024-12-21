
class driver;

    transaction packet;
    mailbox mbox;
    event handover;

    function new(mailbox m, event h);
        mbox = m;
        packet = new();
        handover = h;
    endfunction

    task run(virtual intf vif);
        forever begin
            mbox.get(packet);
            @(negedge vif.CLK);
            $display("Driver: Packet = %p       time = %0t", packet, $time());
            // connecting the transaction packect in the driver class to the virtual intereface to pass the data to the DUT
            vif.Data_in = packet.Data_in;
            vif.Address = packet.Address;
            vif.W_EN = packet.W_EN;
            vif.RST = packet.RST;
            ->handover;
        end
        
        
    endtask

    

endclass