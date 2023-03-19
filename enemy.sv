module enemy(
	input clk,
	input reg[15:0] x,y,
	input reset,
	input button, collision,
	output reg[15:0] x_enemy,
	output reg[15:0] y_enemy,
	output reg[10:0] counter
);

initial begin
	rx_enemy= 700;
	ry_enemy= 400;
	state <=  INITIAL;
	counter =0;
end
reg [15:0] rx_enemy, ry_enemy;
reg clk_1ms;

typedef enum logic [3:0]{
	INITIAL,
	RESET,
	E1,
	E2,
	E3,
	E4
}state_t;

state_t state, next_state;
clk_1ms cl1 (.clk(clk), .clk_1ms(clk_1ms));

always @(posedge clk)begin
	if(~reset ) state <= INITIAL;
	if(collision) state<= INITIAL;
	else state <= next_state;
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

always @(posedge clk_1ms)begin
	case(state)
		INITIAL: begin
			rx_enemy <= 700;
			counter <= 0;
			if(button) next_state <= E2;
			else next_state <= INITIAL;
		end
		RESET: begin
			rx_enemy <= 700;
			counter <= 0;
			next_state <= E1;
		end
		E1:begin
			ry_enemy <= 400;
			rx_enemy <= rx_enemy - 1'b1;
			
			if(rx_enemy == 100)  // bottom limit handeling
			begin
				rx_enemy <= 700;
				counter <= counter +1;
				next_state <= E2;
			end
			else next_state <= E1;
		end
		E2:begin
			ry_enemy <= 300;
			rx_enemy <= rx_enemy -1'b1;
			
			if(rx_enemy == 100) begin // bottom limit handeling
				rx_enemy <= 700;
				counter <= counter +1;
				next_state <= E3;
			end
			else next_state <= E2;
		end
		E3:begin
			ry_enemy <= 400;
			rx_enemy <= rx_enemy -1'b1;
			
			if(rx_enemy == 100)  // bottom limit handeling
			begin
				rx_enemy <= 700;
				counter <= counter +1;
				next_state <= E4;
			end
			else next_state <= E3;
		end
		E4: begin
			ry_enemy <= 400;
			rx_enemy <= rx_enemy -4;
			
			if(rx_enemy == 100)  // bottom limit handeling
			begin
				rx_enemy <= 700;
				counter <= counter +1;
				next_state <= E1;
			end
			else next_state <= E4;
		end
	endcase
end

assign y_enemy = ry_enemy;
assign x_enemy = rx_enemy;

endmodule


