// Descriptions:        �����ļ�������4��ģʽ��
//						Forward Registered ����valid����
//						Backward Registered ����ready����
//						Fully Registered ��ͬʱ��valid��ready����
//						Pass Through ��Bypass����������
module handshake_top#( parameter WIDTH = 8)(
	input clk,
	input rst_n,
	input m_en,
	input s_en,
	output [WIDTH-1:0] data_out
	);
	
	wire m_ready;
	wire m_valid;
	wire [WIDTH-1:0] m_data;

	wire s_valid;
	wire s_ready;
	wire [WIDTH-1:0] s_data_in;
	wire [WIDTH-1:0] s_data_out;

	assign data_out = s_data_out;


//===========================================================================
//Pass Through

/*	assign m_ready = s_ready;
	assign s_data_in = m_data;
	assign s_valid = m_valid;

	master #(
			.WIDTH(WIDTH)
		) inst_master (
			.clk     (clk),
			.rst_n   (rst_n),
			.en      (m_en),
			.m_ready (m_ready),
			.m_data  (m_data),
			.m_valid (m_valid)
		);

	slave #(
			.WIDTH(WIDTH)
		) inst_slave (
			.clk        (clk),
			.rst_n      (rst_n),
			.en         (s_en),
			.s_valid    (s_valid),
			.s_data_in  (s_data_in),
			.s_ready    (s_ready),
			.s_data_out (s_data_out)
		);*/
//===========================================================================
//===========================================================================
//Forward Registered

/*	master #(
			.WIDTH(WIDTH)
		) inst_master (
			.clk     (clk),
			.rst_n   (rst_n),
			.en      (m_en),
			.m_ready (m_ready),
			.m_data  (m_data),
			.m_valid (m_valid)
		);

	Forward_Registered #(
			.WIDTH(WIDTH)
		) inst_Forward_Registered (
			.clk     (clk),
			.rst_n   (rst_n),
			.m_valid (m_valid),
			.m_data  (m_data),
			.m_ready (m_ready),
			.s_valid (s_valid),
			.s_data  (s_data_in),
			.s_ready (s_ready)
		);

	slave #(
			.WIDTH(WIDTH)
		) inst_slave (
			.clk        (clk),
			.rst_n      (rst_n),
			.en         (s_en),
			.s_valid    (s_valid),
			.s_data_in  (s_data_in),
			.s_ready    (s_ready),
			.s_data_out (s_data_out)
		);*/
//===========================================================================
//===========================================================================
//Backward Registered

/*	master #(
			.WIDTH(WIDTH)
		) inst_master (
			.clk     (clk),
			.rst_n   (rst_n),
			.en      (m_en),
			.m_ready (m_ready),
			.m_data  (m_data),
			.m_valid (m_valid)
		);

	Backward_Registered #(
			.WIDTH(WIDTH)
		) inst_Backward_Registered (
			.clk     (clk),
			.rst_n   (rst_n),
			.m_valid (m_valid),
			.m_data  (m_data),
			.m_ready (m_ready),
			.s_valid (s_valid),
			.s_data  (s_data_in),
			.s_ready (s_ready)
		);

	slave #(
			.WIDTH(WIDTH)
		) inst_slave (
			.clk        (clk),
			.rst_n      (rst_n),
			.en         (s_en),
			.s_valid    (s_valid),
			.s_data_in  (s_data_in),
			.s_ready    (s_ready),
			.s_data_out (s_data_out)
		);*/

//===========================================================================
//===========================================================================
//Fully Registered 
	
	wire s_valid_back;
	wire s_ready_back;
	wire [WIDTH-1:0] s_data_back;

	master #(
			.WIDTH(WIDTH)
		) inst_master (
			.clk     (clk),
			.rst_n   (rst_n),
			.en      (m_en),
			.m_ready (m_ready),
			.m_data  (m_data),
			.m_valid (m_valid)
		);


	Backward_Registered #(
			.WIDTH(WIDTH)
		) inst_Backward_Registered (
			.clk     (clk),
			.rst_n   (rst_n),
			.m_valid (m_valid),
			.m_data  (m_data),
			.m_ready (m_ready),
			.s_valid (s_valid_back),
			.s_data  (s_data_back),
			.s_ready (s_ready_back)
		);


	Forward_Registered #(
			.WIDTH(WIDTH)
		) inst_Forward_Registered (
			.clk     (clk),
			.rst_n   (rst_n),
			.m_valid (s_valid_back),
			.m_data  (s_data_back),
			.m_ready (s_ready_back),
			.s_valid (s_valid),
			.s_data  (s_data_in),
			.s_ready (s_ready)
		);
	slave #(
			.WIDTH(WIDTH)
		) inst_slave (
			.clk        (clk),
			.rst_n      (rst_n),
			.en         (s_en),
			.s_valid    (s_valid),
			.s_data_in  (s_data_in),
			.s_ready    (s_ready),
			.s_data_out (s_data_out)
		);

endmodule

	