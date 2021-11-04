// (c) Copyright 2011 - 2012 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.

//----------------------------------------------------------------------------
// Project    : Pheidippides
// Company    : Cadence Design Systems
//----------------------------------------------------------------------------
// Description: 
// This file is a simple testbench for the AXI 4 Streaming BFMs.
//----------------------------------------------------------------------------

//----------------------------------------------------------------------------
// Required timescale.
//----------------------------------------------------------------------------
`timescale 1ns / 1ps

//----------------------------------------------------------------------------
// Local Defines.
//----------------------------------------------------------------------------

// Response Type Defines
`define RESPONSE_OKAY   2'b00
`define RESPONSE_EXOKAY 2'b01
`define RESPONSE_SLVERR 2'b10
`define RESPONSE_DECERR 2'b11

// AMBA AXI 4 streaming Range Constants
`define MAX_BURST_LENGTH 1
   
// AMBA AXI 4 streaming Bus Size Constants
`define PROT_BUS_WIDTH 3
`define RESP_BUS_WIDTH 2

// Define for intenal control value
`define DESTVALID_FALSE 1'b0
`define DESTVALID_TRUE  1'b1
`define IDVALID_TRUE  1'b1
`define IDVALID_FALSE 1'b0

//----------------------------------------------------------------------------
// Create the testbench.
//----------------------------------------------------------------------------

module cdn_axi4_streaming_example_tb;
   
   //------------------------------------------------------------------------
   // Configuration Parameters
   //------------------------------------------------------------------------
   parameter MASTER_NAME = "MASTER_0";
   parameter SLAVE_NAME = "SLAVE_0";
   parameter DATA_BUS_WIDTH = 32;
   parameter ID_BUS_WIDTH   = 8;
   parameter DEST_BUS_WIDTH = 4;
   parameter USER_BUS_WIDTH = 8;
   parameter MAX_PACKET_SIZE = 10;
   parameter MAX_OUTSTANDING_TRANSACTIONS = 8;
   parameter STROBE_NOT_USED = 0;
   parameter KEEP_NOT_USED = 0;
   
   //------------------------------------------------------------------------
   // Other testbench signals
   //------------------------------------------------------------------------
   
   reg tb_ACLK;
   reg tb_ARESETn;

   //------------------------------------------------------------------------
   // Add an instance of the AXI 4 streaming MASTER BFM
   //------------------------------------------------------------------------
   cdn_axi4_streaming_master_bfm #(MASTER_NAME,
                                   DATA_BUS_WIDTH,
                                   ID_BUS_WIDTH,
                                   DEST_BUS_WIDTH,
                                   USER_BUS_WIDTH,
                                   MAX_PACKET_SIZE,
                                   MAX_OUTSTANDING_TRANSACTIONS,
                                   STROBE_NOT_USED,
                                   KEEP_NOT_USED)
   master_0(.ACLK    (tb_ACLK),
            .ARESETn (tb_ARESETn),
            // Transfer Channel
            .TVALID (slave_0.TVALID),
            .TREADY (slave_0.TREADY),
            .TDATA  (slave_0.TDATA),
            .TSTRB  (slave_0.TSTRB),
            .TKEEP  (slave_0.TKEEP),
            .TLAST  (slave_0.TLAST),
            .TID    (slave_0.TID),
            .TDEST  (slave_0.TDEST),
            .TUSER  (slave_0.TUSER));
   
   //------------------------------------------------------------------------
   // Add an instance of the AXI 4 streaming SLAVE BFM
   //------------------------------------------------------------------------
   cdn_axi4_streaming_slave_bfm #(SLAVE_NAME,
                                  DATA_BUS_WIDTH,
                                  ID_BUS_WIDTH,
                                  DEST_BUS_WIDTH,
                                  USER_BUS_WIDTH,
                                  MAX_PACKET_SIZE,
                                  MAX_OUTSTANDING_TRANSACTIONS,
                                  STROBE_NOT_USED,
                                  KEEP_NOT_USED)
   slave_0(.ACLK    (tb_ACLK),
           .ARESETn (tb_ARESETn),
           // Transfer Channel
           .TVALID (master_0.TVALID),
           .TREADY (master_0.TREADY),
           .TDATA  (master_0.TDATA),
           .TSTRB  (master_0.TSTRB),
           .TKEEP  (master_0.TKEEP),
           .TLAST  (master_0.TLAST),
           .TID    (master_0.TID),
           .TDEST  (master_0.TDEST),
           .TUSER  (master_0.TUSER));
   
   //------------------------------------------------------------------------
   // Include Test Level API
   //------------------------------------------------------------------------
   `include "cdn_axi_test_level_api.v"

   //------------------------------------------------------------------------
   // Simple Reset Generator and test
   //------------------------------------------------------------------------

   initial begin
      
      tb_ARESETn = 1'b1;
      #10 tb_ARESETn = 1'b0;
      #50;
      // Release the reset on the posedge of the clk.
      @(posedge tb_ACLK);
      tb_ARESETn = 1'b1;
      @(posedge tb_ACLK);
   end

   
   //------------------------------------------------------------------------
   // Simple Clock Generator
   //------------------------------------------------------------------------
   initial tb_ACLK = 1'b0;
   always #10 tb_ACLK = !tb_ACLK;

   //------------------------------------------------------------------------
   // TEST LEVEL API: COMPARE_TDATA
   //------------------------------------------------------------------------
   // Description:
   // COMPARE_TDATA(expected,actual)
   // This task checks if the actual tdata is equal to the expected tdata.
   // X is used as don't care but it is not permitted for the full vector
   // to be don't care.
   //------------------------------------------------------------------------
   task automatic COMPARE_TDATA;
      input [DATA_BUS_WIDTH-1:0] expected;
      input [DATA_BUS_WIDTH-1:0] actual;
      begin
         if (expected === 'hx || actual === 'hx) begin
            $display("TESTBENCH ERROR! COMPARE_TDATA cannot be performed with an expected or actual vector that is all 'x'!");
            $stop;
         end
         
         if (actual != expected) begin
            $display("TESTBENCH ERROR! TDATA expected is not equal to actual.",
                     "\n expected = 0x%h",expected,
                     "\n actual   = 0x%h",actual);
            $stop;
         end
      end
   endtask
   
   //------------------------------------------------------------------------
   // TEST LEVEL API: COMPARE_TUSER
   //------------------------------------------------------------------------
   // Description:
   // COMPARE_TUSER(expected,actual)
   // This task checks if the actual tuser is equal to the expected tuser.
   // X is used as don't care but it is not permitted for the full vector
   // to be don't care.
   //------------------------------------------------------------------------
   task automatic COMPARE_TUSER;
      input [USER_BUS_WIDTH-1:0] expected;
      input [USER_BUS_WIDTH-1:0] actual;
      begin
         if (expected === 'hx || actual === 'hx) begin
            $display("TESTBENCH ERROR! COMPARE_TUSER cannot be performed with an expected or actual vector that is all 'x'!");
            $stop;
         end
         
         if (actual != expected) begin
            $display("TESTBENCH ERROR! TUSER expected is not equal to actual.",
                     "\n expected = 0x%h",expected,
                     "\n actual   = 0x%h",actual);
            $stop;
         end
      end
   endtask

   //------------------------------------------------------------------------
   // TEST LEVEL API: COMPARE_TID
   //------------------------------------------------------------------------
   // Description:
   // COMPARE_TID(expected,actual)
   // This task checks if the actual tid is equal to the expected tid.
   // X is used as don't care but it is not permitted for the full vector
   // to be don't care.
   //------------------------------------------------------------------------
   task automatic COMPARE_TID;
      input [ID_BUS_WIDTH-1:0] expected;
      input [ID_BUS_WIDTH-1:0] actual;
      begin
         if (expected === 'hx || actual === 'hx) begin
            $display("TESTBENCH ERROR! COMPARE_TID cannot be performed with an expected or actual vector that is all 'x'!");
            $stop;
         end
         
         if (actual != expected) begin
            $display("TESTBENCH ERROR! TID expected is not equal to actual.",
                     "\n expected = 0x%h",expected,
                     "\n actual   = 0x%h",actual);
            $stop;
         end
      end
   endtask

   //------------------------------------------------------------------------
   // TEST LEVEL API: COMPARE_TDEST
   //------------------------------------------------------------------------
   // Description:
   // COMPARE_TDEST(expected,actual)
   // This task checks if the actual tdest is equal to the expected tdest.
   // X is used as don't care but it is not permitted for the full vector
   // to be don't care.
   //------------------------------------------------------------------------
   task automatic COMPARE_TDEST;
      input [DEST_BUS_WIDTH-1:0] expected;
      input [DEST_BUS_WIDTH-1:0] actual;
      begin
         if (expected === 'hx || actual === 'hx) begin
            $display("TESTBENCH ERROR! COMPARE_TDEST cannot be performed with an expected or actual vector that is all 'x'!");
            $stop;
         end
         
         if (actual != expected) begin
            $display("TESTBENCH ERROR! TDEST expected is not equal to actual.",
                     "\n expected = 0x%h",expected,
                     "\n actual   = 0x%h",actual);
            $stop;
         end
      end
   endtask

   //------------------------------------------------------------------------
   // TEST LEVEL API: COMPARE_TSTRB
   //------------------------------------------------------------------------
   // Description:
   // COMPARE_TSTRB(expected,actual)
   // This task checks if the actual tstrb is equal to the expected tstrb.
   // X is used as don't care but it is not permitted for the full vector
   // to be don't care.
   //------------------------------------------------------------------------
   task automatic COMPARE_TSTRB;
      input [(DATA_BUS_WIDTH/8)-1:0] expected;
      input [(DATA_BUS_WIDTH/8)-1:0] actual;
      begin
         if (expected === 'hx || actual === 'hx) begin
            $display("TESTBENCH ERROR! COMPARE_TSTRB cannot be performed with an expected or actual vector that is all 'x'!");
            $stop;
         end
         
         if (actual != expected) begin
            $display("TESTBENCH ERROR! TSTRB expected is not equal to actual.",
                     "\n expected = 0x%h",expected,
                     "\n actual   = 0x%h",actual);
            $stop;
         end
      end
   endtask

   //------------------------------------------------------------------------
   // TEST LEVEL API: COMPARE_TKEEP
   //------------------------------------------------------------------------
   // Description:
   // COMPARE_TKEEP(expected,actual)
   // This task checks if the actual tkeep is equal to the expected tkeep.
   // X is used as don't care but it is not permitted for the full vector
   // to be don't care.
   //------------------------------------------------------------------------
   task automatic COMPARE_TKEEP;
      input [(DATA_BUS_WIDTH/8)-1:0] expected;
      input [(DATA_BUS_WIDTH/8)-1:0] actual;
      begin
         if (expected === 'hx || actual === 'hx) begin
            $display("TESTBENCH ERROR! COMPARE_TKEEP cannot be performed with an expected or actual vector that is all 'x'!");
            $stop;
         end
         
         if (actual != expected) begin
            $display("TESTBENCH ERROR! TKEEP expected is not equal to actual.",
                     "\n expected = 0x%h",expected,
                     "\n actual   = 0x%h",actual);
            $stop;
         end
      end
   endtask

   //------------------------------------------------------------------------
   // TEST LEVEL API: COMPARE_TLAST
   //------------------------------------------------------------------------
   // Description:
   // COMPARE_TLAST(expected,actual)
   // This task checks if the actual tlast is equal to the expected tlast.
   //------------------------------------------------------------------------
   task automatic COMPARE_TLAST;
      input expected;
      input actual;
      begin
         if (expected === 'hx || actual === 'hx) begin
            $display("TESTBENCH ERROR! COMPARE_TLAST cannot be performed with an expected or actual vector that is all 'x'!");
            $stop;
         end
         
         if (actual != expected) begin
            $display("TESTBENCH ERROR! TLAST expected is not equal to actual.",
                     "\n expected = 0x%h",expected,
                     "\n actual   = 0x%h",actual);
            $stop;
         end
      end
   endtask

   //------------------------------------------------------------------------
   // TEST LEVEL API: COMPARE_TDATA_VECTOR
   //------------------------------------------------------------------------
   // Description:
   // COMPARE_TDATA_VECTOR(expected,actual)
   // This task checks if the actual data is equal to the expected data.
   // X is used as don't care but it is not permitted for the full vector
   // to be don't care.
   //------------------------------------------------------------------------
   task automatic COMPARE_TDATA_VECTOR;
      input [(DATA_BUS_WIDTH*(MAX_PACKET_SIZE+1))-1:0] expected;
      input [(DATA_BUS_WIDTH*(MAX_PACKET_SIZE+1))-1:0] actual;
      begin
         if (expected === 'hx || actual === 'hx) begin
            $display("TESTBENCH ERROR! COMPARE_TDATA_VECTOR cannot be performed with an expected or actual vector that is all 'x'!");
            $stop;
         end
         
         if (actual != expected) begin
            $display("TESTBENCH ERROR! Data expected is not equal to actual.",
                     "\n expected = 0x%h",expected,
                     "\n actual   = 0x%h",actual);
            $stop;
         end
      end
   endtask

   //------------------------------------------------------------------------
   // TEST LEVEL API: COMPARE_TUSER_VECTOR
   //------------------------------------------------------------------------
   // Description:
   // COMPARE_TUSER_VECTOR(expected,actual)
   // This task checks if the actual user data is equal to the expected user
   // data.
   // X is used as don't care but it is not permitted for the full vector
   // to be don't care.
   //------------------------------------------------------------------------
   task automatic COMPARE_TUSER_VECTOR;
      input [(USER_BUS_WIDTH*(MAX_PACKET_SIZE+1))-1:0] expected;
      input [(USER_BUS_WIDTH*(MAX_PACKET_SIZE+1))-1:0] actual;
      begin
         if (expected === 'hx || actual === 'hx) begin
            $display("TESTBENCH ERROR! COMPARE_TUSER_VECTOR cannot be performed with an expected or actual vector that is all 'x'!");
            $stop;
         end
         
         if (actual != expected) begin
            $display("TESTBENCH ERROR! User data expected is not equal to actual.",
                     "\n expected = 0x%h",expected,
                     "\n actual   = 0x%h",actual);
            $stop;
         end
      end
   endtask
   
   //------------------------------------------------------------------------
   // TEST LEVEL API: COMPARE_DATASIZE
   //------------------------------------------------------------------------
   // Description:
   // COMPARE_DATASIZE(expected,actual)
   // This task checks if the actual datasize is equal to the expected datasize.
   //------------------------------------------------------------------------
   task automatic COMPARE_DATASIZE;
      input integer expected;
      input integer actual;
      begin
         if (actual != expected) begin
            $display("TESTBENCH ERROR! DATASIZE expected is not equal to actual.",
                     "\n expected = %0d",expected,
                     "\n actual   = %0d",actual);
            $stop;
         end
      end
   endtask

   //------------------------------------------------------------------------
   // TEST BENCH LEVEL API: REPORT_MASTER_STATUS
   //------------------------------------------------------------------------
   // Description:
   // REPORT_MASTER_STATUS(number_of_expected_errors_warnings_and_pending)
   // This task calls the masters report_status function which returns the 
   // total of the errors + warnings + pending counters. This return number 
   // is compared with the input 
   // number_of_expected_errors_warnings_and_pending
   //------------------------------------------------------------------------
   task automatic REPORT_MASTER_STATUS;
      input integer number_of_expected_errors_warnings_and_pending;
      integer       result;
      begin
         result = tb.master_0.report_status(0);
         if (result != number_of_expected_errors_warnings_and_pending) begin
            $display("-------------------------------------------------------");
            $display("EXAMPLE TEST : MASTER FAILED");
            $display("-------------------------------------------------------");
            $finish;
         end
         else begin
            $display("-------------------------------------------------------");
            $display("EXAMPLE TEST : MASTER PASSED");
            $display("-------------------------------------------------------");
         end
      end
   endtask
   
   //------------------------------------------------------------------------
   // TEST BENCH LEVEL API: REPORT_SLAVE_STATUS
   //------------------------------------------------------------------------
   // Description:
   // REPORT_SLAVE_STATUS(number_of_expected_errors_warnings_and_pending)
   // This task calls the slaves report_status function which returns the 
   // total of the errors + warnings + pending counters. This return number 
   // is compared with the input 
   // number_of_expected_errors_warnings_and_pending
   //------------------------------------------------------------------------
   task automatic REPORT_SLAVE_STATUS;
      input integer number_of_expected_errors_warnings_and_pending;
      integer       result;
      begin
         result = tb.slave_0.report_status(0);
         if (result != number_of_expected_errors_warnings_and_pending) begin
            $display("-------------------------------------------------------");
            $display("EXAMPLE TEST : SLAVE FAILED");
            $display("-------------------------------------------------------");
            $finish;
         end
         else begin
            $display("-------------------------------------------------------");
            $display("EXAMPLE TEST : SLAVE PASSED");
            $display("-------------------------------------------------------");
         end
      end
   endtask
   
endmodule

//----------------------------------------------------------------------------
// END OF FILE
//----------------------------------------------------------------------------
