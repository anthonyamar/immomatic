class Profitability
	
	attr_accessor :buying_price, :monthly_rent_estimation, :annual_charges, :monthly_charges

	def initialize
		@buying_price = 0
		@monthly_rent_estimation = 0
		@annual_charges = 0
		@monthly_charges = 0
	end

	def perform
		read_csv
	end

	def read_csv
		workbook = SimpleXlsxReader.open './flat.xlsx'
		worksheets = workbook.sheets
		puts "Found #{worksheets.count} worksheets"

		worksheets.each do |worksheet|
			puts "Reading: #{worksheet.name}"
			num_rows = 0
			worksheet.rows.each do |row|
			 	break if row.nil?
				row_cells = row
				num_rows += 1
				hash = calc_row(row)
				puts "================"
				pp hash
				puts "================"
			end
			puts "Read #{num_rows} rows"
		end
	end
	
	def calc_row(row)
		buying_price = row[1].to_f
		monthly_rent_estimation = row[2].to_f
		annual_charges = row[3].to_f
		monthly_charges = row[4].to_f
		puts "#{buying_price}, #{monthly_rent_estimation}, #{annual_charges}, #{monthly_charges}"
		
		calc = CalcFile.new(buying_price, monthly_rent_estimation, annual_charges, monthly_charges)
		hash = {name: row[0], annual_cashflow: calc.annual_cashflow,  }
	end

end