
module render(
	input clk, 
	input reg [15:0] x, y,//position of point
	input reset,
	input reg[15:0] x_player, x_enemy,
	input reg[15:0] y_player, y_enemy,
	input button,
	output [3:0] Red,
	output [3:0] Green,
	output [3:0] Blue,
	output led, collision
	);
	
	reg [3:0] r_red;
	reg [3:0] r_green;
	reg [3:0] r_blue;

	reg flag = 1'b0;
	
	
	typedef enum logic [2:0] {
		INITIAL,
		PLAYING,
		DEAD
	
	}state_t;
	
	state_t state, next_state;
	
	initial begin
		state <= INITIAL;
		next_state <= state;
		collision = 0;
	end
	
	 reg key_detect;
	 reg sync_key;
	 reg sync_key_temp;
	 reg one_shot;
	 reg remt;
	 reg sync_key_detect;
	 
	 
	 
	 always_ff @(negedge button, posedge sync_key)
	 begin
		if (sync_key) key_detect <=0;
		else key_detect <= 1;
	 end
	 
	 always_ff @(posedge clk)begin
		sync_key_temp <= key_detect;
		sync_key <= sync_key_temp;
		one_shot <= sync_key;
		remt = sync_key & ~one_shot;
	 end
	
	always@(posedge clk,  negedge reset)begin
		if(!reset)begin
			state <= INITIAL;
		end
		else state <= next_state;
	end
	
	always_ff @(posedge clk, negedge reset)begin
		case(state)
			INITIAL: begin
				r_red <= 4'hF;
				r_blue <= 4'h0; //yelow
				r_green <= 4'hF;
				flag =1'b0;
				//P
				if(x>240 && x<300 && y>200 && y<330)begin
						r_red <= 4'h0;
						r_blue <= 4'h0;
						r_green <= 4'h0;
				end
				if(x>260 && x<290 && y>220 && y<250)begin
						r_red <= 4'hF;
						r_blue <= 4'h0;
						r_green <= 4'hF;
				end
				if(x>260 && x<300 && y>270 && y<330)begin
						r_red <= 4'hF;
						r_blue <= 4'h0;
						r_green <= 4'hF;
				end
				//-
				if(x>320 && x<380 && y>250 && y<270)begin
						r_red <= 4'h0;
						r_blue <= 4'h0;
						r_green <= 4'h0;
				end
				
				//D
				if(x>400 && x<460 && y>200 && y<330)begin
						r_red <= 4'h0;
						r_blue <= 4'h0;
						r_green <= 4'h0;
				end
				if(x>445 && x<460 && y>200 && y<220)begin
						r_red <= 4'hF;
						r_blue <= 4'h0;
						r_green <= 4'hF;
				end
				if(x>445 && x<460 && y>310 && y<330)begin
						r_red <= 4'hF;
						r_blue <= 4'h0;
						r_green <= 4'hF;
				end
				if(x>415 && x<445 && y>220 && y<310)begin
						r_red <= 4'hF;
						r_blue <= 4'h0;
						r_green <= 4'hF;
				end
				
				//A
				if(x>480 && x<540 && y>200 && y<330)begin
						r_red <= 4'h0;
						r_blue <= 4'h0;
						r_green <= 4'h0;
				end
				if(x>500 && x<520 && y>220 && y<250)begin
						r_red <= 4'hF;
						r_blue <= 4'h0;
						r_green <= 4'hF;
				end
				if(x>500 && x<520 && y>270 && y<330)begin
						r_red <= 4'hF;
						r_blue <= 4'h0;
						r_green <= 4'hF;
				end
				
				//S
				if(x>560 && x<620 && y>200 && y<330)begin
						r_red <= 4'h0;
						r_blue <= 4'h0;
						r_green <= 4'h0;
				end
				if(x>580 && x<620 && y>220 && y<250)begin
						r_red <= 4'hF;
						r_blue <= 4'h0;
						r_green <= 4'hF;
				end
				if(x>560 && x<600 && y>270 && y<310)begin
						r_red <= 4'hF;
						r_blue <= 4'h0;
						r_green <= 4'hF;
				end
				
				//H
				if(x>640 && x<700 && y>200 && y<330)begin
						r_red <= 4'h0;
						r_blue <= 4'h0;
						r_green <= 4'h0;
				end
				if(x>670 && x<690 && y>200 && y<250)begin
						r_red <= 4'hF;
						r_blue <= 4'h0;
						r_green <= 4'hF;
				end
					if(x>670 && x<690 && y>270 && y<330)begin
						r_red <= 4'hF;
						r_blue <= 4'h0;
						r_green <= 4'hF;
				end
				
				
				if(remt)next_state<= PLAYING;
				else next_state <= INITIAL;
			
			end
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
				if(y>y_enemy  && y<y_enemy+60&& x> x_enemy&& x<(x_enemy+60))
				begin
					r_red <= 4'h0; //red
					r_blue <= 4'h0;
					r_green <= 4'h0;
				end
				
				//render player
				//Changing the render to get dynamic y values
				if(y>y_player &&y<(y_player +60) && x> x_player && x< (x_player + 60))
				begin
					r_red <= 4'hF;
					r_blue <= 4'h0; //yelow
					r_green <= 4'hF;
					if(y>y_player+10 &&y<(y_player +50) && x> x_player+10 && x< (x_player + 90))begin
						r_red <= 4'hF;
						r_blue <= 4'hF; //WHITE 
						r_green <= 4'hF;
					end
					if(y_enemy >= (y_player) && y_enemy <= (y_player +60 ) && ((x_player >= x_enemy && x_player <= x_enemy+60)||(x_player+60 >= x_enemy && x_player+60 <= x_enemy+60) ))begin
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
					collision <= 1;
					
					next_state<= DEAD;
				end
				else next_state <= PLAYING;
			end
		
			DEAD: begin
				led = 1'b1;
					r_red <= 4'hF;
					r_blue <= 4'h0;
					r_green <= 4'h0;
					
					//Y
					if(x>390 && x<430 && y>200 && y<260)begin
						r_red <= 4'h0;
						r_blue <= 4'h0;
						r_green <= 4'h0;
					end
					if(x>400 && x<420 && y>200 && y<220)begin
						r_red <= 4'hF;
						r_blue <= 4'h0;
						r_green <= 4'h0;
					end
					if(x>390 && x<405 && y>230 && y<260)begin
						r_red <= 4'hF;
						r_blue <= 4'h0;
						r_green <= 4'h0;
					end
					if(x>415 && x<430 && y>230 && y<260)begin
						r_red <= 4'hF;
						r_blue <= 4'h0;
						r_green <= 4'h0;
					end
					
					//O
					if(x>440 && x<480 && y>200 && y<260)begin
						r_red <= 4'h0;
						r_blue <= 4'h0;
						r_green <= 4'h0;
					end
					if(x>460 && x<470 && y>210 && y<250)begin
						r_red <= 4'hF;
						r_blue <= 4'h0;
						r_green <= 4'h0;
					end
					
					//U
					if(x>490 && x<530 && y>200 && y<260)begin
						r_red <= 4'h0;
						r_blue <= 4'h0;
						r_green <= 4'h0;
					end
					if(x>500 && x<520 && y>200 && y<250)begin
						r_red <= 4'hF;
						r_blue <= 4'h0;
						r_green <= 4'h0;
					end
					/////////////////////////////////////////
					//L
					if(x>365 && x<405 && y>280 && y<340)begin
						r_red <= 4'h0;
						r_blue <= 4'h0;
						r_green <= 4'h0;
					end
					if(x>385 && x<405 && y>280 && y<330)begin
						r_red <= 4'hF;
						r_blue <= 4'h0;
						r_green <= 4'h0;
					end
					
					//O
					if(x>415 && x<455 && y>280 && y<340)begin
						r_red <= 4'h0;
						r_blue <= 4'h0;
						r_green <= 4'h0;
					end
					if(x>435 && x<445 && y>290 && y<330)begin
						r_red <= 4'hF;
						r_blue <= 4'h0;
						r_green <= 4'h0;
					end
					
					//S
					if(x>465 && x<505 && y>280 && y<340)begin
						r_red <= 4'h0;
						r_blue <= 4'h0;
						r_green <= 4'h0;
					end
					if(x>475 && x<505 && y>290 && y<310)begin
						r_red <= 4'hF;
						r_blue <= 4'h0;
						r_green <= 4'h0;
					end
					if(x>465 && x<495 && y>320 && y<330)begin
						r_red <= 4'hF;
						r_blue <= 4'h0;
						r_green <= 4'h0;
					end
					
					//E
					if(x>510 && x<550 && y>280 && y<340)begin
						r_red <= 4'h0;
						r_blue <= 4'h0;
						r_green <= 4'h0;
					end
					if(x>530 && x<550 && y>290 && y<310)begin
						r_red <= 4'hF;
						r_blue <= 4'h0;
						r_green <= 4'h0;
					end
					if(x>530 && x<550 && y>320 && y<330)begin
						r_red <= 4'hF;
						r_blue <= 4'h0;
						r_green <= 4'h0;
					end
					
					
					
					
				if(~reset)begin
					flag = 1'b0;
					collision <= 0;
					next_state <= INITIAL;
				end
				else next_state <= DEAD;
			end
		endcase
	end

	assign Red = (x > 144 && x <= 783 && y > 35 && y <= 514) ? r_red : 4'h0;
	assign Blue = (x > 144 && x <= 783 && y > 35 && y <= 514) ? r_blue : 4'h0;
	assign Green = (x > 144 && x <= 783 && y > 35 && y <= 514) ? r_green : 4'h0;
	
endmodule
