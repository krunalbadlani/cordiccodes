`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2022 17:26:27
// Design Name: 
// Module Name: angletable
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module rotating();
    reg [15:0] m [0:8];
    reg [15:0] angle;
    reg [7:0] outputc[0:7];
    reg [15:0] mf [0:7];
    reg clk;
    reg signed [32:0] x1 [0:8];
    reg signed [32:0] y1 [0:8];
    reg [32:0] y2;
    reg [32:0] x2;
    
    initial begin:my_fn
    integer i;

    m[0] =16'b0001_0001_1001_0100;
    m[1] =16'b0000_1010_0000_0111;
    m[2] =16'b0000_0101_0111_1011;
    m[3] =16'b0000_0010_1100_1000;
    m[4] =16'b0000_0001_0110_0101;
    m[5] =16'b0000_0000_1011_0011;
    m[6] =16'b0000_0000_0101_1001;
    m[7] =16'b0000_0000_0010_1100;
    m[8] =16'b0000_0000_0001_0110;
    //m[8] =16'b0000000000001011;

    angle = 16'b10000010101001;

    @(posedge clk)
    if ( m[0] > angle) begin
        mf[0] = m[0]-m[1];
        outputc[0] = 8'b00000000;end

    else if ( m[0] < angle)begin
        mf[0]= m[0]+m[1];
        outputc[0] = 8'b00000001;end

    @(posedge clk)
    if ( mf[0] > angle) begin
        mf[1] = mf[0]-m[2];outputc[1] = 8'b00000000;
    end

    else if ( mf[0] < angle)begin
        mf[1] = mf[0]+m[2];outputc[1] = 8'b00000001;
    end


    @(posedge clk)
    if ( mf[1] > angle) begin
        mf[2] = mf[1]-m[3];
        outputc[2] = 8'b00000000;end

    else if ( mf[1] < angle)begin
        mf[2] = mf[1]+m[3];
        outputc[2] = 8'b00000001;end

    @(posedge clk)
    if ( mf[2] > angle) begin
        mf[3] = mf[2]-m[4];
        outputc[3] = 8'b00000000;end

    else if ( mf[2] < angle)begin
        mf[3] = mf[2]+m[4];
        outputc[3] = 8'b00000001;end

    @(posedge clk)
    if ( mf[3] > angle) begin
        mf[4] = mf[3]-m[5];
        outputc[4] = 8'b00000000;end

    else if ( mf[3] < angle)begin
        mf[4] = mf[3]+m[5];
        outputc[4] = 8'b00000001;end

    @(posedge clk)
    if ( mf[4] > angle) begin
        mf[5] = mf[4]-m[6];
        outputc[5] = 8'b00000000;end

    else if ( mf[4] < angle)begin
        mf[5] = mf[4]+m[6];
        outputc[5] = 8'b00000001;end

    @(posedge clk)
    if ( mf[5] > angle) begin
        mf[6] = mf[5]-m[7];
        outputc[6] = 8'b00000000;end

    else if ( mf[5] < angle)begin
        mf[6] = mf[5]+m[7];
        outputc[6] = 8'b00000001;end

    @(posedge clk)
    if ( mf[6] > angle) begin
        mf[7] = mf[6]-m[8];
        outputc[7] = 8'b00000000;end

    else if ( mf[6] < angle)begin
        mf[7] = mf[6]+m[8];
        outputc[7] = 8'b00000001;end



    
end:my_fn
    initial begin
        clk= 0;
        forever
            #5 clk= ~clk;
    end
initial
begin
x1[0]=32'b101110111000;

y1[0]=32'b111110100000;
@(posedge clk)
if (outputc[0] == 8'b0) begin
x1[1]  = x1[0]-y1[0];
y1[1]  = x1[0]+y1[0];end
else if(outputc[0] == 8'b1) begin
x1[1]  = x1[0]+y1[0];
y1[1]  = -x1[0]+y1[0];end

@(posedge clk)
if (outputc[1] == 8'b0) begin
y2= y1[1]>>>1; 
x1[2]  = x1[1]-y2;
x2= x1[1]>>>1;
y1[2]  = x2+y1[1];
end
else if(outputc[1] == 8'b1) begin
y2= y1[1]>>>1;
x1[2]  = x1[1]+y2;
x2= x1[1]>>>1;
y1[2]  = -x2+y1[1];
end

@(posedge clk)
if (outputc[2] == 8'b0) begin
y2 = y1[2] >>> 2; 
x1[3]  = x1[2] - y2; 
x2= x1[2] >>> 2;
y1[3]  = x2+y1[2];
end
else if(outputc[2] == 8'b1) begin
y2= y1[2]>>>2;
x1[3]= x1[2]+y2;
x2= x1[2]>>>2;
y1[3]  = -x2+y1[2];
end

@(posedge clk)
if (outputc[3] == 8'b0) begin
y2= y1[3] >>> 3; 
x1[4]  = x1[3]-y2;
x2= x1[3]>>>3; 
y1[4]  = x2+y1[3];
end
else if(outputc[3] == 8'b1) begin
y2= y1[3]>>>3;
x1[4]  = x1[3]+y2; 
x2= x1[3]>>>3;
y1[4]  = -x2+y1[3];
x1[3]= x1[3]<<<3;end

@(posedge clk)
if (outputc[4] == 8'b0) begin
y2= y1[4]>>>4; 
x1[5]  = x1[4]-y2;
x2= x1[4]>>>4; 
y1[5]  = x2+y1[4];
end
else if(outputc[4] == 8'b1) begin
y2= y1[4]>>>4;
x1[5]  = x1[4]+y2; 
x2= x1[4]>>>4;
y1[5]  = -x2+y1[4];
end

@(posedge clk)
if (outputc[5] == 8'b0) begin
y2= y1[5]>>>5; 
x1[6]  = x1[5]-y2;
x2= x1[5]>>>5; 
y1[6]  = x2+y1[5];
end
else if(outputc[5] == 8'b1) begin
y2= y1[5]>>>5;
x1[6]  = x1[5]+y2; 
x2= x1[5]>>>5;
y1[6]  = -x2+y1[5];
end

@(posedge clk)
if (outputc[6] == 8'b0) begin
y2= y1[6]>>>6; 
x1[7]  = x1[6]-y2;
x2= x1[6]>>>6;
 
y1[7]  = x2+y1[6];
end
else if(outputc[6] == 8'b1) begin
y2= y1[6]>>>6;
x1[7]  = x1[6]+y2; 
x2= x1[6]>>>6;
y1[7]  = -x2+y1[6];
end

@(posedge clk)
if (outputc[7] == 8'b0) begin
y2= y1[7]>>>7; 
x1[8]  = x1[7]-y2;
x2= x1[7]>>>7; 
y1[8]  = x2+y1[7];
end
else if(outputc[7] == 8'b1) begin
y2= y1[7]>>>7;
x1[8]  = x1[7]+y2; 
x2= x1[7]>>>7;
y1[8]  = -x2+y1[7];end
    end
endmodule
