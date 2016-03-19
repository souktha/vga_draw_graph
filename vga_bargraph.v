/*
* $Revision: 9 $
* $Date: 2016-01-13 13:49:13 -0800 (Wed, 13 Jan 2016) $
* $Author: ssop $
*/
`timescale 1 ns / 100 ps
/*
Draw bar on screen for VGA 640x480@60HZ
*/
module vga_drawgraph (
    input CLK100MHZ, CPU_RESETN,
    output VGA_HS, VGA_VS,
    output [3:0] VGA_R, VGA_G, VGA_B
    );
    wire video_on, p_tick;
    wire [9:0] x, y;
	reg [11:0] rgb;

    vga_sync vga_drawgraph (.clk(CLK100MHZ),
                         ._rst(CPU_RESETN),
                         ._hsync(VGA_HS),
                         ._vsync(VGA_VS),
                         .video_on(video_on),
                         .p_tick(p_tick),
                         .pixel_x(x),
                         .pixel_y(y));



    /* draw cross hair of 1 pixel at center of screen + at (x,y)=(319,y), (x,239) */
	assign VGA_R = rgb[11:8];
	assign VGA_G = rgb[7:4];
	assign VGA_B = rgb[3:0];

	/* Plotting data of array data[x], x=0..639 along the (x,y) axis 
	*
		|   
		|   |    |
		|   |  | |
	 ---------------------	>x direction
	 d0 d1  d2  d4   d6 ..	
	* */
    wire [7:0] data; //rom data = address[x]

    rom_lookup rom(.rom_addr(x),.rom_data(data));

    always@(posedge p_tick)
		if (video_on ) begin
            if ( (y >= 10'd239-data) && (y < 10'd239) )
                rgb <= 12'hf00;
            else 
                if ( y == 10'd239 ) //middle screen horizontal line (x,239)
                    rgb <= 12'h0f0;
                else
                    rgb <= 12'h0; //nothing pass horizontal line
		end else 
			rgb <= 12'h0;

endmodule
