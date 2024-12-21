class sequencer;
    // Declare a transaction packet
    transaction packet;
    // Declare a mailbox for communication
    mailbox mbox;
    // Loop variable
    int loop_var;
    // Event for synchronization
    event handover;

    // Constructor function
    function new(mailbox m, event h);
        // Initialize mailbox
        mbox = m;
        // Create a new transaction packet
        packet = new();
        // Initialize event
        handover = h;
        // Set loop variable to 50
        loop_var = 34;
    endfunction

    // Task to run the sequencer
    task run();
        // Loop for the number of iterations specified by loop_var
        for (int i=0; i<loop_var; ++i) begin
            // First iteration
            if (i == 0) begin
                // Initialize packet fields
                packet.Data_in = 0;
                packet.Address = 0;
                packet.W_EN = 0;
                packet.RST = 0;
                // Display messages
                $display("Seq: Rest mode %0d iteration", i);
                
                // Put the packet in the mailbox
                mbox.put(packet);
            end else if (i < loop_var/2) begin
                // Randomize packet fields with constraints
                packet.randomize() with {RST inside {1};
                                         W_EN inside {1};};
                // Display messages
                $display("Seq: Writing mode %0d iteration", i);
                
                // Put the packet in the mailbox
                mbox.put(packet);
            end 
            else begin
                // Randomize packet fields with constraints
                packet.randomize() with {RST inside {1};
                                         W_EN inside {0};};
                // Display messages
                $display("Seq: Reading mode %0d iteration", i);
                
                // Put the packet in the mailbox
                mbox.put(packet);
            end
            // Wait for the handover event to be triggered
            @(handover);
        end
        
    endtask
endclass