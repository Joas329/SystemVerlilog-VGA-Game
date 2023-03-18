module player(
	input clk_1ms,
	input clk,
	input button, button1,
	input reg[15:0] x, y,
	output reg [15:0] x_player,
	output reg [15:0] y_player
	);
	
	initial
	begin
	rx_player = 300;
	ry_player = 420;
	state <= GROUND;
	end
	
	typedef enum logic [2:0] {
		UP,
		DOWN,
		GROUND
	} state_t;
	
	 state_t state, next_state;
	 
	  always @(posedge clk)begin
		state<= next_state;
		end

	reg [15:0] rx_player;
	reg [15:0] ry_player;
	
	always@(posedge clk_1ms)begin
		case(state)
			GROUND: begin
				rx_player <= rx_player;
				ry_player <= 400;
				if(button)begin
					next_state <= UP;
				end
				else next_state <= GROUND;
			end
			
			UP: begin
				ry_player <= ry_player -1;
				if(ry_player == 50)begin
					next_state <= DOWN;
				end
				else next_state <= UP;
				
			end
			
			DOWN: begin
				ry_player <= ry_player +1;
				if(ry_player == 400)begin
					next_state <= GROUND;
				end
				else next_state <= DOWN ;
			end
		
		endcase
	end
	
	assign y_player = ry_player;
	assign x_player = rx_player;
	
	
	
endmodule
