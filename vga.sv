module horizontal_counter(input clk,
	output reg enable_V_Counter =0,
	output reg [15:0] H_Count_Value =0
);
	reg clk25;
	

	clk25mhz clock_25(.clk(clk),.clk25(clk25));


	always@(posedge clk25)begin
		if(H_Count_Value < 799)begin
			H_Count_Value <= H_Count_Value+1; 
			enable_V_Counter <=0; 
		end
		else begin
			H_Count_Value <=0;
			enable_V_Counter <=1; 
		end
	end

endmodule

module vertical_counter(input clk, 
	input enable_V_Counter,
	output reg[15:0] V_Count_Value =0
);
reg clk25;

	clk25mhz clock_25(.clk(clk),.clk25(clk25));


	always@(posedge clk25)begin
		if(enable_V_Counter == 1'b1)begin
			if(V_Count_Value < 524) begin
				V_Count_Value <= V_Count_Value +1;
			end
			else begin
				V_Count_Value <=0; 
			end
		end

	end


endmodule


module clk25mhz(input clk, output reg clk25);
	always@(posedge clk)begin
		clk25 <= ~clk25;
	end
endmodule




module vga(
	input clk,
	output Hsynq,
	output Vsynq,
	output reg [15:0] x, y
);

wire enable_V_Counter;
wire [15:0] H_Count_Value;
wire [15:0] V_Count_Value;


horizontal_counter VGA_Horiz(clk,enable_V_Counter,H_Count_Value);
vertical_counter VGA_Verti(clk, enable_V_Counter,V_Count_Value);





//outputs 
assign Hsynq = (H_Count_Value <96) ? 1'b1:1'b0;
assign Vsynq = (V_Count_Value <2) ? 1'b1:1'b0;
assign x = H_Count_Value;
assign y =V_Count_Value;


endmodule





