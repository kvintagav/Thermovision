module bidirec (oe, clk, inp, outp, bidir);

// Port Declaration

input   oe;
input   clk;
input   [15:0] inp;
output  [15:0] outp;
inout   [15:0] bidir;

reg     [15:0] a;
reg     [15:0] b;

assign bidir = oe ? a : 16'bZ ;
assign outp  = b;

// Always Construct

always @ (posedge clk)
begin
    b <= bidir;
    a <= inp;
end

endmodule
