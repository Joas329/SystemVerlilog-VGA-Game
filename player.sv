module player(
	input clk_1ms, 
	input button, button1,
	input reg[15:0] x, y,
	output reg [15:0] x_player,
	output reg [15:0] y_player
	);
	
	initial
	begin
	x_player = 300;
	y_player = 420;
	end

	
	always @ (posedge clk_1ms)
	begin
		if(button)begin
			x_player <= x_player-1; // move to the left
		end
		if(button1)begin
			x_player <= x_player+1;	//move to the right
		end
		
		
		if(x_player <= 264 && x_player + 50 <= 314)  // left limit handeling
		begin
			x_player <= 265;
		end
		if( x_player+50 >= 664 && x_player >= 613)begin //right limit handeling
			x_player <= 613;
		end
		
	end
	
	
	
endmodule


