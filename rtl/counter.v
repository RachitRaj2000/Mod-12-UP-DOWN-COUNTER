module mod12updowncounter(input clock,reset,load,mode,input[3:0]data_in,output reg [3:0]data_out);
  always@(posedge clock)
         begin
                 if(reset)
                         begin
                         data_out<=4'd0;
                         end
                 else if(load)
                         begin
                         data_out<=data_in;
                         end
                 else if(mode)
                         begin
                         if(data_out>4'd11)
                                 data_out<=4'd0;
                         else
                                 data_out<=data_out+1'b1;
                         end
                 else
                         begin
                        if(data_out==4'd0)
                                data_out<=4'd11;
                         else
                         data_out<=data_out-1'b1;
                         end
        end
 endmodule:mod12updowncounter
