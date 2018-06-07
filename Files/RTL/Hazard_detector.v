module Hazard_detector(ID_Rt,IF_Rs,IF_Rt,mem_read,stall);

input	[4:0]	ID_Rt,IF_Rs,IF_Rt;
input		mem_read;
output		stall;	

// stall pipeline, introduce bubble, forward data

assign stall = (mem_read) ?((ID_Rt == IF_Rs) ?1 :((ID_Rt == IF_Rt) ?1 :0)) :0;

endmodule 














