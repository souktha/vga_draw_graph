/*
* $Date: 2016-01-13 13:59:54 -0800 (Wed, 13 Jan 2016) $
* $Author: ssop $
* $Revision: 11 $
*/
`timescale 1 ns / 100 ps

/* 1k x 8 bit rom lookup  */
module rom_lookup #(parameter WIDTH=8) (
    input [9:0] rom_addr, //1024x8
    output reg [WIDTH-1:0] rom_data
);

    always @(*)
        case(rom_addr)
            'd40: rom_data = 8'd49;
            'd80: rom_data = 8'd49;
            'd84: rom_data = 8'd0;
            'd90: rom_data = 8'd77;
            'd180: rom_data = 8'd46;
            'd190: rom_data = 8'd0;

            'd200: rom_data = 8'd100;
            'd210: rom_data = 8'd89;
            'd224: rom_data = 8'd80;
            'd233: rom_data = 8'd90;
            'd300: rom_data = 8'd55;
            'd320: rom_data = 8'd66;
            
            'd400: rom_data = 8'd40;
            'd440: rom_data = 8'd20;
            'd500: rom_data = 8'd26;
            'd540: rom_data = 8'd59;
            'd570: rom_data = 8'd100;
            'd590: rom_data = 8'd10;
            'd610: rom_data = 8'd10;
            'd620: rom_data = 8'd41;
            default: rom_data = 8'h0;
        endcase
endmodule
