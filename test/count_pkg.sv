package pkg;

   int no_of_transactions = 1;
  
	`include "count_trans.sv";
	`include "gen.sv";
	`include "count_write_drv.sv";
	`include "count_write_mon.sv";
	`include "count_read_mon.sv";
	`include "count_model.sv";
	`include "count_sb.sv";
	`include "env.sv";
	`include "test.sv";
		
endpackage
