`default_nettype none

//  Top level io for this module should stay the same to fit into the scan_wrapper.
//  The pin connections within the user_module are up to you,
//  although (if one is present) it is recommended to place a clock on io_in[0].
//  This allows use of the internal clock divider if you wish.
module user_module_341419328215712339(
  input [7:0] io_in, 
  output [7:0] io_out
);
  wire clk = io_in[0];
  reg [9:0] hcnt;
  reg [9:0] vcnt;
  wire hsync;
  wire vsync;
  wire px_r = 0;
  wire px_g = 0;
  wire px_b = 0;
  assign io_out[0] = hsync;
  assign io_out[1] = vsync;
  assign io_out[2] = px_r;
  assign io_out[3] = px_g;
  assign io_out[4] = px_b;
  always @ (posedge clk) begin
	  if (hcnt == 799) begin
		  hcnt <= 0;
		  if (vcnt == 524)
			  vcnt <= 0;
		  else
			  vcnt <= vcnt + 1'b1;
	  end else
		  hcnt <= hcnt + 1'b1;
  end

  assign vsync = (vcnt >= 490 && vcnt < 492) ? 1'b0 : 1'b1;
  assign hsync = (hcnt >= 656 && hcnt < 752) ? 1'b0 : 1'b1;

endmodule
