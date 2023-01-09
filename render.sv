
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
	
	
	always @(posedge clk)
	begin	
		//always output background color if nothing is being displayed on
				r_red <= 4'h0;    // black
				r_blue <= 4'h0;
				r_green <= 4'h0;
				
				//render enemy
				if(y>y_enemy  && y<y_enemy+20&& x> 400&& x<450)
				begin
					r_red <= 4'hF; //red
					r_blue <= 4'h0;
					r_green <= 4'h0;
				end
				
				//render player
				if(y>440 &&y<460 && x> x_player && x< (x_player +50))
				begin
					r_red <= 4'hF;
					r_blue <= 4'h0; //yelow
					r_green <= 4'hF;
					if(y_enemy > 440 && y_enemy < 460 && ((x_player > x_enemy && x_player < x_enemy+50)||(x_player+50 > x_enemy && x_player+50 < x_enemy+50) ))begin
						flag = 1'b1;
					end
					
				end
				
				if(flag)begin
					led = 1'b1;
					r_red <= 4'hF;
					r_blue <= 4'h0;
					r_green <= 4'h0;
				end
				
				
				
				if(!reset)begin
					flag = 1'b0;
				end
			
		
	end

	assign Red = (x > 144 && x <= 783 && y > 35 && y <= 514) ? r_red : 4'h0;
	assign Blue = (x > 144 && x <= 783 && y > 35 && y <= 514) ? r_blue : 4'h0;
	assign Green = (x > 144 && x <= 783 && y > 35 && y <= 514) ? r_green : 4'h0;
	
	
endmodule