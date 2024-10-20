/********************************************************************************************

Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename       :  test.sv   

Description    :  Test class for dual port ram_testbench

Author Name    :  Putta Satish

Support e-mail :  techsupport_vm@maven-silicon.com 

Version        :  1.0

Date           :  02/06/2020

********************************************************************************************/

//class ram_trans_extnd1
/*class ram_trans_extnd1 extends ram_trans;
      
   //define a constraint valid_random_data with data inside the range which is not covered 
   //define a constraint valid_random_rd  with rd_address inside the range which is not covered
	constraint valid_random_data {data inside {[1500:3000],4294};}
	constraint valid_random_rd {rd_address inside {0,4095};}
	//constraint valid_random_rd  {rd_address inside }
endclass:ram_trans_extnd1 

   //extend the ram trans if required to cover all the bins

class ram_base_test;

   //Instantiate virtual interface with Write Driver modport,
   //Read Driver modport, Write monitor modport, Read monitor modport
   virtual ram_if.RD_DRV_MP rd_drv_if;
   virtual ram_if.WR_DRV_MP wr_drv_if; 
   virtual ram_if.RD_MON_MP rd_mon_if; 
   virtual ram_if.WR_MON_MP wr_mon_if;
   
   // Declare a handle for ram_env 
   ram_env env_h;
     
   //In constructor
   //pass the Driver interface and monitor interface as arguments
   //create an object for env_h and pass the virtual interfaces 
   //as arguments in new() function
   function new(virtual ram_if.WR_DRV_MP wr_drv_if, 
                virtual ram_if.RD_DRV_MP rd_drv_if,
                virtual ram_if.WR_MON_MP wr_mon_if,
                virtual ram_if.RD_MON_MP rd_mon_if);
      this.wr_drv_if = wr_drv_if;
      this.rd_drv_if = rd_drv_if;
      this.wr_mon_if = wr_mon_if;
      this.rd_mon_if = rd_mon_if;
      
      env_h = new(wr_drv_if,rd_drv_if,wr_mon_if,rd_mon_if);
   endfunction: new

   //Understand and include the virtual task build 
   //which builds the TB environment
   virtual task build();
      env_h.build();
   endtask: build
   
   //Understand and include the virtual task run 
   //which runs the simulation for different testcases
   virtual task run();              
      env_h.run();
   endtask: run   
   
endclass: ram_base_test

class ram_test_extnd1 extends ram_base_test;
      
   //Declare a handle for ram_trans_extnd1
   ram_trans_extnd1 data_h1;
   
   //In constructor
   //pass the Driver interface and monitor interface as arguments
   //create an object for env_h and pass the virtual interfaces 
   //as arguments in new() function
   function new(virtual ram_if.WR_DRV_MP wr_drv_if, 
                virtual ram_if.RD_DRV_MP rd_drv_if,
                virtual ram_if.WR_MON_MP wr_mon_if,
                virtual ram_if.RD_MON_MP rd_mon_if);
      super.new(wr_drv_if,rd_drv_if,wr_mon_if,rd_mon_if);      
   endfunction: new

   //Understand and include the virtual task build 
   //which builds the TB environment
   virtual task build();
      super.build();
   endtask: build
   
   //Understand and include the virtual task run 
   //which runs the simulation for different testcases
   virtual task run();  
      data_h1 = new();
      env_h.gen_h.gen_trans = data_h1;
      super.run();
   endtask: run      
   
endclass: ram_test_extnd1
*/

//test
class test;


virtual count_if.wr_drv_mp wr_drv_if;
virtual count_if.wr_mon_mp wr_mon_if;
virtual count_if.rd_mon_mp rd_mon_if;


environment env;
function new(
virtual count_if.wr_drv_mp wr_drv_if,
virtual count_if.wr_mon_mp wr_mon_if,
virtual count_if.rd_mon_mp rd_mon_if);


this.wr_drv_if=wr_drv_if;
this.wr_mon_if=wr_mon_if;
this.rd_mon_if=rd_mon_if;
env=new(wr_drv_if,wr_mon_if,rd_mon_if);
endfunction:new

virtual task build();
	env.build();
endtask:build


virtual task run();
	env.run();
endtask:run



endclass:test
//extended transaction class
class count_trans_extnd1 extends count_trans;
	constraint c2{mode==0->data_in==1;mode==1->data_in inside {[0:6]};}
endclass:count_trans_extnd1

//extended test class
class test_extnd1 extends test;
	environment env;
	count_trans_extnd1 trans_1;
virtual count_if.wr_drv_mp wr_drv_if;
virtual count_if.wr_mon_mp wr_mon_if;
virtual count_if.rd_mon_mp rd_mon_if;
	function new(
virtual count_if.wr_drv_mp wr_drv_if,
virtual count_if.wr_mon_mp wr_mon_if,
virtual count_if.rd_mon_mp rd_mon_if);
super.new(wr_drv_if,wr_mon_if,rd_mon_if);
endfunction:new




virtual task build();
	super.build();
endtask:build

virtual task run();
	trans_1=new();
	env.gen.gen_trans=trans_1;
	super.run();
endtask:run

endclass:test_extnd1
