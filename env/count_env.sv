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

