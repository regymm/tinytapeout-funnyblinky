`default_nettype none

//  Top level io for this module should stay the same to fit into the scan_wrapper.
//  The pin connections within the user_module are up to you,
//  although (if one is present) it is recommended to place a clock on io_in[0].
//  This allows use of the internal clock divider if you wish.
module user_module_341419328215712339(
	input [7:0] io_in, 
	output reg [7:0] io_out
);
	wire clk25 = io_in[0];
	reg [24:0]cnt;
	always @ (posedge clk25) begin
		cnt <= cnt + 1;
	end
	wire clkslow = cnt[22];
	reg [6:0]cntslow;
	always @ (posedge clkslow) begin
		cntslow <= cntslow == 101 ? 0 : cntslow + 1;
	end
	always @ (*) begin
		io_out = 0;
		if (cntslow >= 1 && cntslow <= 8) io_out = 8'b10000000 >>> cntslow;
		else if (cntslow >= 9 && cntslow <= 16) io_out = 8'b11111111 << (cntslow - 9);
		else if (cntslow >= 17 && cntslow <= 24) io_out = 8'b10000000 >> (cntslow - 17);
		else if (cntslow >= 25 && cntslow <= 32) io_out = 8'b00000001 << (cntslow - 25);
		else if (cntslow >= 33 && cntslow <= 53) io_out = cntslow[0] ? 8'b00000000 : 8'b11111111;
		else if (cntslow >= 54 && cntslow <= 70) io_out = cntslow[0] ? 8'b11110000 : 8'b00001111;
		//else if (cntslow >= 71 && cntslow <= 101 && cntslow[0] == 0) io_out = cntslow[0] ? 8'b11110000 : 8'b00001111;
	end
endmodule
