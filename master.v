module master#( parameter WIDTH = 8)(
	input clk,
	input rst_n,
	input en,
	input m_ready,
	output reg [WIDTH-1:0] m_data,
	output reg m_valid
);

	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			m_data <= {WIDTH{1'b0}};
		end
		else if (m_valid&m_ready) begin
			m_data <= m_data + 1'b1;
		end
		else begin
			m_data <= m_data;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			m_valid <= 1'b0;
		end
		else begin
			m_valid <= en;
		end
	end


endmodule