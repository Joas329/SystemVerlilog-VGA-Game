
module test(
	input clk,
	input reset,button, button1, 
	output Hsynq,
	output Vsynq,
	output [3:0] Red,
	output [3:0] Green,
	output [3:0] Blue,
	output led
);

wire clk_25, clk_1ms;
wire [15:0] x;
wire [15:0] y;
wire [3:0] red_paddle1;
wire [3:0] green_paddle1;
wire [3:0] blue_paddle1;
wire paddle1_on;
wire [15:0] x_player, y_player;
wire [3:0] p1_score;
wire [1:0] game_state;
wire [15:0] x_enemy, y_enemy;
wire enemy_on;
wire player_dead;
wire video_on;

vga v1	(.clk(clk), .Hsynq(Hsynq), .Vsynq(Vsynq), .x(x), .y(y));
	

clk_1ms c1 (.clk(clk), .clk_1ms(clk_1ms));


render r1	(.clk(clk), .x(x), .y(y), .reset(reset),
					.x_player(x_player),.x_enemy(x_enemy),.y_player(y_player), .y_enemy(y_enemy),
					.Red(Red),.Green(Green),.Blue(Blue),.led(led)   );
					
	

enemy en1(.clk(clk), .x(x), .y(y), .x_enemy(x_enemy),.y_enemy(y_enemy),.enemy_on(enemy_on),.player_on(player_on));	
player p1	(.clk_1ms(clk_1ms), .button(button), .button1(button1), 
					.x(x), .y(y),
					.x_player(x_player), .y_player(y_player) );
					





endmodule





