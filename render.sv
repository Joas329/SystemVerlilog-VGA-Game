
module render(
	input clk, 
	input reg [15:0] x, y,//position of point
	input reset,
	input reg[15:0] x_player, x_enemy,
	input reg[15:0] y_player, y_enemy,
	output [3:0] Red,
	output [3:0] Green,
	output [3:0] Blue,
	output led
	);
	
	reg [3:0] r_red;
	reg [3:0] r_green;
	reg [3:0] r_blue;

	reg flag = 1'b0;
	
	//posible idea for a state machine for the game.
	
	typedef enum logic [2:0] {
		PLAYING,
		DEAD,
		INITIAL
	
	}state_t;
	
	state_t state, next_state;
	
	initial begin
		state <= PLAYING;;
	end
	
	always@(posedge clk)begin
		if(!reset) state <= INITIAL;
		else state <= next_state;
	end
	
	always @(posedge clk)begin
		case(state)
			PLAYING: begin
				r_red <= 4'h87;    // BLUE
				r_blue <= 4'hEB;
				r_green <= 4'hEE;
				
				if(y> 0 && y < 50)begin
					r_red <= 4'h0; //GREEN
					r_blue <= 4'h0;
					r_green <= 4'hFF;
				end
				
				//render enemy
				if(y>y_enemy  && y<y_enemy+60&& x> x_enemy&& x<(x_enemy+100))
				begin
					r_red <= 4'h0; //red
					r_blue <= 4'h0;
					r_green <= 4'h0;
				end
				
				//render player
				//Changing the render to get dynamic y values
				if(y>y_player &&y<(y_player +60) && x> x_player && x< (x_player + 100))
				begin
					r_red <= 4'hF;
					r_blue <= 4'h0; //yelow
					r_green <= 4'hF;
					if(y>y_player+10 &&y<(y_player +50) && x> x_player+10 && x< (x_player + 90))begin
						r_red <= 4'hF;
						r_blue <= 4'hF; //WHITE 
						r_green <= 4'hF;
					end
					if(y_enemy >= (y_player) && y_enemy <= (y_player +60 ) && ((x_player >= x_enemy && x_player <= x_enemy+100)||(x_player+100 >= x_enemy && x_player+100 <= x_enemy+100) ))begin
						flag = 1'b1;
					end
					
				end
				
				if(y > 460)begin
					r_red <= 4'h0;
					r_blue <= 4'h0;
					r_green <= 4'hFF;
				end
				if(flag)begin
					led = 1'b1;
					r_red <= 4'hF;
					r_blue <= 4'h0;
					r_green <= 4'h0;
					next_state<= DEAD;
				end
				else next_state <= PLAYING;
			end
			INITIAL: begin
			
			end
			DEAD: begin
				led = 1'b1;
					r_red <= 4'hF;
					r_blue <= 4'h0;
					r_green <= 4'h0;
				if(!reset)begin
					flag = 1'b0;
					next_state <= PLAYING;
				end
				else next_state <= DEAD;
			end
		endcase
	end

	assign Red = (x > 144 && x <= 783 && y > 35 && y <= 514) ? r_red : 4'h0;
	assign Blue = (x > 144 && x <= 783 && y > 35 && y <= 514) ? r_blue : 4'h0;
	assign Green = (x > 144 && x <= 783 && y > 35 && y <= 514) ? r_green : 4'h0;
	
	
endmodule
