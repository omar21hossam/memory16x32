module Memory #(
    parameter DATA_IN      = 32,
    parameter ADDRESS      = 4,
    parameter MEMORY_DEPTH = 16,
    parameter DATA_OUT     = 32
) (
    input wire [DATA_IN - 1 : 0]     Data_in,
    input wire [ADDRESS - 1 : 0]     Address,
    input wire                       W_EN,
    input wire                       CLK,
    input wire                       RST,
    output reg [DATA_OUT - 1 : 0]    Data_out
);

reg [DATA_IN - 1:0] memory [0:MEMORY_DEPTH-1];

integer i;

always @(posedge CLK or negedge RST) begin
    if (!RST) begin
        for ( i=0; i<MEMORY_DEPTH; ++i) begin
            memory[i] <= 32'b0;
        end
    end else if (W_EN) begin
        memory[Address] <= Data_in ;
    end 
end

always @(posedge CLK or negedge RST) begin
    if (!RST) begin
        Data_out <= 32'b0;
    end else begin
        Data_out <= memory[Address];
    end
end

    
endmodule