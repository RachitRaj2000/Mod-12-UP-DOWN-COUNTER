package pkg;

   int no_of_transactions = 1;
  
	`include "count_trans.sv";
	`include "gen.sv";
	`include "count_write_drv.sv";
	`include "count_write_mon.sv";
	`include "count_rd_mon.sv";
	`include "count_model.sv";
	`include "count_sb.sv";
	`include "count_env.sv";
	`include "test.sv";
		
endpackage
