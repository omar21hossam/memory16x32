
class scoreboard;
    // Inputs
    transaction packet;
    logic [31:0] ref_memory [0:15];
    mailbox mbox;
    event handover;
    integer test_passed = 0;
    

    function new(mailbox m, event h);
        packet = new();
        mbox = m;
        handover = h;
    endfunction

    task run();
        forever begin
            mbox.get(packet);
            if(packet.W_EN == 1) begin
                ref_memory[packet.Address] = packet.Data_in;
            end
            else begin
                if(ref_memory[packet.Address] != packet.Data_out) begin
                    $display("Scoreboard: Error at Address %0d", packet.Address);
                    $display("Expected: %0d, Received: %0d", ref_memory[packet.Address], packet.Data_out);
                    $display("time = %0t", $time);
                end
                else begin
                    $display("Scoreboard: Address %0d matched", packet.Address);
                    test_passed++;
                end
            end
            // Display messages
            $display("Scoreboard: test_passed = %0d", test_passed);
            ->handover;
        end
    endtask
endclass