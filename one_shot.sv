module one_shot(
	input clk,
	input button,
	output remt
);

always_ff @(negedge pass, posedge sync_key)
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
	 
endmodule
