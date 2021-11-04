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
// This file contains the common checkers and tasks required for making test
// writing using the Cadence AXI 3 BFMs easier.
//----------------------------------------------------------------------------

//------------------------------------------------------------------------
// TEST LEVEL API TASKS
//------------------------------------------------------------------------

         

//------------------------------------------------------------------------
// TEST LEVEL API: CHECK_RESPONSE_VECTOR_OKAY
//------------------------------------------------------------------------
// Description:
// CHECK_RESPONSE_VECTOR_OKAY(response,burst_length)
// This task checks if the response vector returned from the READ_BURST
// task is equal to OKAY
//------------------------------------------------------------------------
task automatic CHECK_RESPONSE_VECTOR_OKAY;
   input [(`RESP_BUS_WIDTH*(`MAX_BURST_LENGTH+1))-1:0] response;
   input integer                                       burst_length;
   integer                                             i;
   begin
      for (i = 0; i < burst_length+1; i = i+1) begin
         CHECK_RESPONSE_OKAY(response[i*`RESP_BUS_WIDTH +: `RESP_BUS_WIDTH]);
      end
   end
endtask

//------------------------------------------------------------------------
// TEST LEVEL API: CHECK_RESPONSE_VECTOR_EXOKAY
//------------------------------------------------------------------------
// Description:
// CHECK_RESPONSE_VECTOR_EXOKAY(response,burst_length)
// This task checks if the response vector returned from the READ_BURST
// task is equal to EXOKAY
//------------------------------------------------------------------------
task automatic CHECK_RESPONSE_VECTOR_EXOKAY;
   input [(`RESP_BUS_WIDTH*(`MAX_BURST_LENGTH+1))-1:0] response;
   input integer                                       burst_length;
   integer                                             i;
   begin
      for (i = 0; i < burst_length+1; i = i+1) begin
         CHECK_RESPONSE_EXOKAY(response[i*`RESP_BUS_WIDTH +: `RESP_BUS_WIDTH]);
      end
   end
endtask


//------------------------------------------------------------------------
// TEST LEVEL API: CHECK_RESPONSE_OKAY
//------------------------------------------------------------------------
// Description:
// CHECK_RESPONSE_OKAY(response)
// This task checks if the return response is equal to OKAY
//------------------------------------------------------------------------
task automatic CHECK_RESPONSE_OKAY;
   input [`RESP_BUS_WIDTH-1:0] response;
   begin
      if (response !== `RESPONSE_OKAY) begin
         $display("TESTBENCH ERROR! Response is not OKAY",
                  "\n expected = 0x%h",`RESPONSE_OKAY,
                  "\n actual   = 0x%h",response);
         $stop;
      end
   end
endtask

//------------------------------------------------------------------------
// TEST LEVEL API: CHECK_RESPONSE_EXOKAY
//------------------------------------------------------------------------
// Description:
// CHECK_RESPONSE_EXOKAY(response)
// This task checks if the return response is equal to EXOKAY
//------------------------------------------------------------------------
task automatic CHECK_RESPONSE_EXOKAY;
   input [`RESP_BUS_WIDTH-1:0] response;
   begin
      if (response !== `RESPONSE_EXOKAY) begin
         $display("TESTBENCH ERROR! Response is not EXOKAY",
                  "\n expected = 0x%h",`RESPONSE_EXOKAY,
                  "\n actual   = 0x%h",response);
         $stop;
      end
   end
endtask

//------------------------------------------------------------------------
// TEST LEVEL API: COMPARE_DATA
//------------------------------------------------------------------------
// Description:
// COMPARE_DATA(expected,actual)
// This task checks if the actual data is equal to the expected data.
// X is used as don't care but it is not permitted for the full vector
// to be don't care.
//------------------------------------------------------------------------
task automatic COMPARE_DATA;
   input [(DATA_BUS_WIDTH*(`MAX_BURST_LENGTH+1))-1:0] expected;
   input [(DATA_BUS_WIDTH*(`MAX_BURST_LENGTH+1))-1:0] actual;
   begin
      if (expected === 'hx || actual === 'hx) begin
         $display("TESTBENCH ERROR! COMPARE_DATA cannot be performed with an expected or actual vector that is all 'x'!");
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

//----------------------------------------------------------------------------
// END OF FILE
//----------------------------------------------------------------------------
