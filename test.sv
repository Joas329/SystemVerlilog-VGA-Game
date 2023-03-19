
module test(
	input clk,
	input reset,button, button1, 
	output Hsynq,
	output Vsynq,
	output [3:0] Red,
	output [3:0] Green,
	output [3:0] Blue,
	output led,
	output reg [7:0] seg_left,
	output reg [7:0] seg_right
);

wire clk_1ms;
wire [15:0] x;
wire [15:0] y;
wire [15:0] x_player, y_player;
wire [15:0] x_enemy, y_enemy;
wire jump;
wire collision;
reg [10:0] counter, tens, ones; 


//VGA interface module declaration
vga v1	(.clk(clk), .Hsynq(Hsynq), .Vsynq(Vsynq), .x(x), .y(y));
	
//1ms clock
clk_1ms c1 (.clk(clk), .clk_1ms(clk_1ms));

//render module
render r1	(.clk(clk), .x(x), .y(y), .reset(reset),
					.x_player(x_player),.x_enemy(x_enemy),.y_player(y_player), .y_enemy(y_enemy),.button(button),
					.Red(Red),.Green(Green),.Blue(Blue),.led(led) , .collision(collision));
					
	
//enemy module
enemy en1(.clk(clk),.x(x), .y(y), .reset(reset), .button(button),
				.collision(collision), .x_enemy(x_enemy),.y_enemy(y_enemy),
				.counter(counter));	

//player module
player p1	(.clk_1ms(clk_1ms), .clk(clk), .button(button), 
					.x(x), .y(y), .reset(reset),
					.x_player(x_player), .y_player(y_player));
					

//Hex display and score module	
				
	task hexDisplay(input [6:0] value, output reg [7:0] display);
		case(value)
			4'd0: display = 8'b11000000;	//0
			4'd1: display = 8'b11111001;	//1
			4'd2: display = 8'b10100100;	//2
			4'd3: display = 8'b10110000;	//3
			4'd4: display = 8'b10011001;	//4
			4'd5: display = 8'b10010010;	//5
			4'd6: display = 8'b10000010;	//6
			4'd7: display = 8'b11111000;	//7
			4'd8: display = 8'b10000000;	//8
			4'd9: display = 8'b10011000;	//9
			default: display = 8'b11111111; //off
		endcase
endtask



 always_comb begin
		tens = counter / 10;
		ones = counter % 10;
		  
		hexDisplay(tens, seg_left);
		hexDisplay(ones, seg_right);
 end
endmodule

