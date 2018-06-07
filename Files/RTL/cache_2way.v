module cache(
    clk,
    proc_reset,
    proc_read,
    proc_write,
    proc_addr,
    proc_rdata,
    proc_wdata,
    proc_stall,
    mem_read,
    mem_write,
    mem_addr,
    mem_rdata,
    mem_wdata,
    mem_ready
);

//==== test ===============================================
/**/
    integer readcount, writecount, readmiss, writemiss;
    initial begin
        readcount = 0;
        writecount = 0;
        readmiss = 0;
        writemiss = 0;
    end

//==== input/output definition ============================
    input          clk;
    // processor interface
    input          proc_reset;
    input          proc_read, proc_write;
    input   [29:0] proc_addr;
    input   [31:0] proc_wdata;
    output reg     proc_stall;
    output reg [31:0] proc_rdata;
    // memory interface
    input  [127:0] mem_rdata;
    input          mem_ready;
    output reg     mem_read, mem_write;
    output reg [27:0] mem_addr;
    output reg [127:0] mem_wdata;
    
    reg real_mem_ready;

//==== wire/reg definition ================================
    reg [31:0] data_a [0:3] [0:3];
    reg [31:0] data_b [0:3] [0:3];
    reg [24:0] proc_tag;
    reg [1:0] index;
    reg [1:0] offset;
    reg [25:0] tag_a [0:3]; // 30-2-2=26 2-bit for index, 2-bit for offset
    reg [25:0] tag_b [0:3];
    reg valid_a [0:3];
    reg dirty_a [0:3];
    reg valid_b [0:3];
    reg dirty_b [0:3];
    reg read_miss;
    reg write_miss;
    reg wb_memory_ready;
    reg al_memory_ready;

    integer i, j;
    reg [1:0] state;
    parameter IDLE = 2'd0;
    parameter COMPARE_TAG = 2'd1;
    parameter WRITE_BACK = 2'd2;
    parameter ALLOCATE = 2'd3;

//==== combinational circuit ==============================
always@(*) begin
    proc_tag = proc_addr[29:4];
    index = proc_addr[3:2];
    offset = proc_addr[1:0];
end

always@(*) begin //FSM
    if(proc_reset) begin
        read_miss = 0;
        write_miss = 0;
        proc_stall = 0;
    end
    case (state)
    IDLE: begin
    end
    COMPARE_TAG: begin
        /*
        $display( "    Total %d rc detected so far! >\"< \n", readcount[14:0] );
        $display( "    Total %d rm detected so far! >\"< \n", readmiss[14:0] );
        $display( "    Total %d wc detected so far! >\"< \n", writecount[14:0] );
        $display( "    Total %d wm detected so far! >\"< \n", writemiss[14:0] );
        */
        mem_read = 0;
        mem_write = 0;
        if( proc_read ) begin
            //readcount = readcount + 1; // test
            if (valid_a[index] & (proc_tag==tag_a[index])) begin // read hit
                proc_rdata = data_a[index][offset];
                read_miss = 0;
                proc_stall = 0;
            end
            else if (valid_b[index] & (proc_tag==tag_b[index])) begin
                proc_rdata = data_b[index][offset];
                read_miss = 0;
                proc_stall = 0;
            end
            else begin // read miss
                //readmiss = readmiss + 1; // test
                read_miss = 1;
                proc_stall = 1;
            end
        end
        if( proc_write ) begin
            //writecount = writecount + 1; //test
            proc_stall = 1;
            if ((proc_tag==tag_a[index]) | (proc_tag==tag_b[index])) write_miss = 0; // write hit
            else begin
                //writemiss = writemiss + 1; // test
                write_miss = 1;
            end
        end
    end
    WRITE_BACK: begin
        mem_write = 1;
        mem_read = 0;
        mem_addr = {tag_a[index], index};
    end
    ALLOCATE: begin
        if( proc_read ) begin
            mem_read = 1;
            mem_write = 0;
            mem_addr = proc_addr[29:2];
        end
        if( proc_write ) begin
            if(al_memory_ready) proc_stall = 0;
        end
    end
    endcase
end

always@( posedge mem_ready ) begin
    real_mem_ready <= (1'b1 ^ real_mem_ready);
end

//==== sequential circuit =================================
always@( posedge clk or posedge proc_reset ) begin
    if( proc_reset ) begin
        for(i=0;i<4;i=i+1) begin
            for(j=0;j<4;j=j+1) begin
                data_a[i][j] <= 0;
                data_b[i][j] <= 0;
            end
            valid_a[i] <= 0;
            dirty_a[i] <= 0;
            tag_a[i] <= 0;
            valid_b[i] <= 0;
            dirty_b[i] <= 0;
            tag_b[i] <= 0;
        end
        real_mem_ready <= 0;
        state <= COMPARE_TAG;
    end
    else begin
        case (state)
        IDLE: begin
        end
        COMPARE_TAG: begin
            if( proc_read ) begin
                if( read_miss & (!dirty_a[index] | !dirty_b[index])) begin
                    state <= ALLOCATE; // cache read miss and clean
                    al_memory_ready <= 0;
                end
                else if( read_miss & dirty_a[index] & dirty_b[index] ) begin
                    state <= WRITE_BACK; // cache read miss and dirty
                    wb_memory_ready <= 0;
                end
            end
            if( proc_write ) begin
                if( !write_miss ) state <= ALLOCATE;
                else begin
                    if (dirty_a[index] & dirty_b[index]) state <= WRITE_BACK;
                    else state <= ALLOCATE;
                end
            end
        end
        WRITE_BACK: begin
            if(wb_memory_ready) begin
                state <= ALLOCATE;
                al_memory_ready <= 0;
            end
            if(!real_mem_ready & mem_ready) wb_memory_ready <= 1;
            mem_wdata <= {data_a[index][3], data_a[index][2], data_a[index][1], data_a[index][0]};
            valid_a[index] <= 0;
            dirty_a[index] <= 0;
        end
        ALLOCATE: begin
            if(al_memory_ready) state <= COMPARE_TAG;
            if( proc_read ) begin
                if(!real_mem_ready & mem_ready) begin
                    if(!dirty_a[index]) begin // data_a
                        data_a[index][3] <= mem_rdata[127:96];
                        data_a[index][2] <= mem_rdata[95:64];
                        data_a[index][1] <= mem_rdata[63:32];
                        data_a[index][0] <= mem_rdata[31:0];
                        tag_a[index] <= proc_tag;
                        valid_a[index] <= 1;
                        dirty_a[index] <= 0;
                    end
                    else begin // data_b
                        data_b[index][3] <= mem_rdata[127:96];
                        data_b[index][2] <= mem_rdata[95:64];
                        data_b[index][1] <= mem_rdata[63:32];
                        data_b[index][0] <= mem_rdata[31:0];
                        tag_b[index] <= proc_tag;
                        valid_b[index] <= 1;
                        dirty_b[index] <= 0;
                    end
                    al_memory_ready <= 1;
                end
            end
            if( proc_write ) begin
                if ((proc_tag==tag_b[index])|!dirty_b[index]) begin
                    data_b[index][offset] <= proc_wdata;
                    tag_b[index] <= proc_tag;
                    valid_b[index] <= 1;
                    dirty_b[index] <= 1;
                end
                else if ((proc_tag==tag_a[index])|!dirty_a[index]) begin
                    data_a[index][offset] <= proc_wdata;
                    tag_a[index] <= proc_tag;
                    valid_a[index] <= 1;
                    dirty_a[index] <= 1;
                end
                if(real_mem_ready) begin
                    al_memory_ready <= 1;
                end
            end
        end
        endcase
    end
end

endmodule    