/********************************************************************************************

Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename       :  ram_env.sv   

Description    :  Environment class for dual port ram_testbench

Author Name    :  Putta Satish & 

Support e-mail :  techsupport_vm@maven-silicon.com 

Version        :  1.0

Date           :  02/06/2020

*********************************************************************************************/
/*module test();
bit [2:0] y;
bit z;

covergroup cg;

//option.per_instance=1;
//option.at_least=1;

CP_Y:coverpoint y{
	bins y1={0};
	bins y2={1};
	bins y3={2};
	bins y4={3};
	bins y5={4};
	bins y6={5};
	bins y7={6};
	bins y8={7};}

CP_Z:coverpoint z;

endgroup:cg

cg cg1,cg2;

initial
begin
	cg1=new();
	//cg2=new(2);
	
	for(int i=0;i<8;i++)
	begin
		//y<=i;
		//z<=~z;
		y=0;
		y=1;
		y=2;
		y=3;
		
		z=0;
		#10;
	end
		$display("coverage for cg1:%f",cg1.get_inst_coverage);
		//$display("coverage for cg2:%0f",cg2.get_inst_coverage);

end

endmodule*/

/*module coverage;
bit addr,data;

covergroup cg;
cp1:coverpoint addr;
cp2:coverpoint data;
cp1_x_cp2:cross cp1,cp2;
endgroup:cg

cg cg1=new();

initial
begin
cg1.start();
cg1.set_inst_name("my_cg");
//cg1.start();
cg1.sample();
end

initial
begin
$monitor("at time t=%0t:Addr=%0d,Data=%0d",$time,addr,data);
repeat(2)
begin
addr=$random;
data=$random;
#5;
$display("Coverage is %f",cg1.get_coverage());
end
cg1.stop();
//$display("Coverage is %f",my_cg.get_coverage());
end
endmodule*/


/*class ram_env;

   //Instantiate virtual interface with Write Driver modport,
   //Read Driver modport,Write monitor modport,Read monitor modport
 

   //Declare 6 mailboxes parameterized by ram_trans and construct it
  virtual ram_if.WR_DRV_MP wr_drv_if; 
  virtual ram_if.WR_MON_MP wr_mon_if;   
  virtual ram_if.RD_DRV_MP rd_drv_if; 
  virtual ram_if.RD_MON_MP rd_mon_if; 


 mailbox #(ram_trans) gen2wr=new();
 mailbox #(ram_trans) gen2rd=new();
 mailbox #(ram_trans) wr2rm=new();
 mailbox #(ram_trans) rd2rm=new();
 mailbox #(ram_trans) rd2sb=new();
 mailbox #(ram_trans) rm2sb=new();

	ram_gen gen_h;
	ram_write_drv wr_drv;
	ram_write_mon wr_mon;
	ram_read_mon rd_mon;
	ram_read_drv rd_drv;
	ram_model ref_model;
	ram_sb sb_h;
   
   
   
   
   
   
   
   
   //Create handle for ram_gen,ram_write_drv,ram_read_drv,ram_write_mon,
   //ram_read_mon,ram_model,ram_sb


   //In constructor
   //pass the Driver and monitor interfaces as the argument
   //connect them with the virtual interfaces of ram_env
   function new(
  virtual ram_if.WR_DRV_MP wr_drv_if, 
  virtual ram_if.RD_DRV_MP rd_drv_if,   
  virtual ram_if.WR_MON_MP wr_mon_if, 
  virtual ram_if.RD_MON_MP rd_mon_if);
	this.wr_drv_if=wr_drv_if;
	this.wr_mon_if=wr_mon_if;
	this.rd_mon_if=rd_mon_if;
	this.rd_drv_if=rd_drv_if;
endfunction:new
	
   //In virtual task build
   //create instances for generator,Write Driver,Read Driver,
   //Write monitor,Read monitor,Reference model,Scoreboard
	virtual task build();
		gen_h=new(gen2rd,gen2wr);
		wr_drv=new(wr_drv_if,gen2wr);
		rd_drv=new(rd_drv_if,gen2rd);
		wr_mon=new(wr_mon_if,wr2rm);
		rd_mon=new(rd_mon_if,rd2rm,rd2sb);
		ref_model=new(wr2rm,rd2rm,rm2sb);
		sb_h=new(rd2sb,rm2sb);
	endtask:build
   //Understand and include the virtual task reset_dut

   virtual task reset_dut();
      begin
         rd_drv_if.rd_drv_cb.rd_address<='0;
         rd_drv_if.rd_drv_cb.read<='0;

         wr_drv_if.wr_drv_cb.wr_address<=0;
         wr_drv_if.wr_drv_cb.write<='0;

         repeat(5) @(wr_drv_if.wr_drv_cb);
         for (int i=0; i<4096; i++)
            begin
               wr_drv_if.wr_drv_cb.write<='1;
               wr_drv_if.wr_drv_cb.wr_address<=i;
               wr_drv_if.wr_drv_cb.data_in<='0;
               @(wr_drv_if.wr_drv_cb);
            end
         wr_drv_if.wr_drv_cb.write<='0;
         repeat (5) @(wr_drv_if.wr_drv_cb);
      end
   endtask : reset_dut

   //In virtual task start
   //call the start methods of generator,Write Driver,Read Driver,
   //Write monitor,Read Monitor,reference model,scoreboard
	virtual task start();
		gen_h.start();
		wr_drv.start();
		rd_drv.start();
		wr_mon.start();
		rd_mon.start();
		ref_model.start();
		sb_h.start();
	endtask:start
   virtual task stop();
      wait(sb_h.DONE.triggered);
   endtask : stop 

   //In virtual task run, call reset_dut, start, stop methods & report function from scoreboard
	virtual task run();
		reset_dut();
		this.start();
		this.stop();
		sb_h.report();
	endtask:run
endclass : ram_env*/ 

//Environnemt


class environment;
	
	virtual count_if.wr_drv_mp wr_drv_if;
	virtual count_if.wr_mon_mp wr_mon_if;
	virtual count_if.rd_mon_mp rd_mon_if;

	mailbox #(count_trans) gen2wr=new();
	mailbox #(count_trans) wr2rm=new();
	mailbox #(count_trans)rdmon2sb=new();
	mailbox #(count_trans) rm2sb=new();


		generator gen;
		write_driver wr_drv;
		write_monitor wr_mon;
		read_monitor rd_mon;
		ref_model ref_mod;
		scoreboard scorebrd;

	function new(
	virtual count_if.wr_drv_mp wr_drv_if,
	virtual count_if.wr_mon_mp wr_mon_if,
	virtual count_if.rd_mon_mp rd_mon_if);

	this.wr_drv_if=wr_drv_if;
	this.wr_mon_if=wr_mon_if;
	this.rd_mon_if=rd_mon_if;
	endfunction:new


	
	virtual task build();
		gen=new(gen2wr);
		wr_drv=new(wr_drv_if,gen2wr);
		wr_mon=new(wr_mon_if,wr2rm);
		rd_mon = new(rd_mon_if,rdmon2sb);
		ref_mod=new(wr2rm,rm2sb);
		scorebrd= new(rm2sb,rdmon2sb);
	endtask:build

	virtual task start();
		gen.start();
		wr_drv.start();
		wr_mon.start();
		rd_mon.start();
		ref_mod.start();
		scorebrd.start();
	endtask:start
	virtual task stop();
		wait(scorebrd.DONE.triggered);
	endtask:stop

	virtual task reset_dut();
		@(wr_drv_if.wr_drv_cb)
		wr_drv_if.wr_drv_cb.reset<=1'b1;
		repeat(2)
		@(wr_drv_if.wr_drv_cb)
		wr_drv_if.wr_drv_cb.reset<=1'b0;
	endtask:reset_dut


	virtual task run();	
		reset_dut();
		start();
		stop();
		scorebrd.report();
	endtask:run


endclass:environment

