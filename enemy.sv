module enemy(
	input clk,
	
	input reg[15:0] x,y,
	output reg[15:0] x_enemy,
	output reg[15:0] y_enemy,
	output enemy_on,
	output player_on
);

initial begin
	x_enemy= 400;
	y_enemy= 80;
end
reg [15:0] rx_enemy, ry_enemy;
reg collision = 1'b0;
reg clk_1s;
collision_detection c1(.clk(clk), .x_paddle1(x_paddle1),.y_paddle1(y_paddle1), .x_enemy(x_enemy),.y_enemy(y_enemy), .collision(collision));
clk_1s s(.clk(clk),.clk_1s(clk_1s));


always @(posedge clk_1s)begin
	ry_enemy <= ry_enemy +1;
	rx_enemy <= rx_enemy;
	
	if(ry_enemy+20 == 450 && !collision)begin
		player_on = 1'b1; //if enemy reaches end and does not hit player
		//break;
	end
	else if(collision) begin
		player_on = 1'b0; //if enemy does not hit player
		player_on = 1'b0;
		//break;
	end
	
	
	if(ry_enemy >= 474 && ry_enemy+20 <= 494)  // bottom limit handeling
	begin
		player_on = 1'b1;
		ry_enemy <= 80;
	end


end

assign y_enemy = ry_enemy;

endmodule


module collision_detection(
	input clk,
	input reg[15:0] x_paddle1,
	input reg[15:0] y_paddle1,
	input reg[15:0] x_enemy,
	input reg[15:0] y_enemy,
	output reg collision
);

initial begin
	collision = 1'b0;
end

	always @(posedge clk)begin
		if((x_paddle1+50) < x_enemy && x_paddle1 > (x_enemy +50))begin
			if(y_enemy >= 440 && y_enemy >=460)begin
				collision = 1'b1;
			end
			else collision = 1'b0;
		end
		else collision = 1'b0;
	end



endmodule


module clk_1s(
    input clk,
    output reg clk_1s = 0
    );
    reg [37:0] i = 0;
    
	 always @ (posedge clk)
    begin
        if (i == 349999)
        begin
            i <= 0;
            clk_1s = ~clk_1s;
        end
        else i <= i+1;
    end
    
endmodule


