
class monitor;
    transaction packet;
    mailbox mbox;
    event handover;

    function  new(mailbox m, event h);
        packet = new();
        mbox = m;
        handover = h;
    endfunction

    task run(virtual intf vif);
     
        @(posedge vif.CLK);
        forever begin
        @(posedge vif.CLK);
        #1step;
        packet.Data_out = vif.Data_out;
        packet.Address = vif.Address;
        packet.W_EN = vif.W_EN;
        packet.RST = vif.RST;
        packet.Data_in = vif.Data_in;
        mbox.put(packet);
        $display("Monitor: Data_out = %0d       time = %0t", packet.Data_out,$time());
        $display("Monitor: vif.data_out = %0d", vif.Data_out);
        @(handover);

     end
    endtask
endclass