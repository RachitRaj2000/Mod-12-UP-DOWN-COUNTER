class read_monitor;
	mailbox #(count_trans) rdmon2sb;
	virtual count_if.rd_mon_mp rd_mon_if;
	count_trans rd_data;
	count_trans rd_shallow_copy;	

	function  new(
	virtual count_if.rd_mon_mp rd_mon_if,
	mailbox #(count_trans) rdmon2sb);
	this.rd_mon_if=rd_mon_if;
	this.rdmon2sb=rdmon2sb;
	this.rd_data=new();
	endfunction:new


	virtual task monitor();
		@(rd_mon_if.rd_mon_cb);
		begin
		rd_data.data_out=rd_mon_if.rd_mon_cb.data_out;
		rd_data.display("Data from read monitor");
		end
	endtask:monitor

	

	virtual task start();
		fork
			forever
				begin
					monitor();
					rd_shallow_copy= new rd_data;
					rdmon2sb.put(rd_shallow_copy);
				end
		join_none
	endtask:start


endclass:read_monitor

