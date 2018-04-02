class UserImport
  include ActiveModel::Model

  attr_accessor :file


  def save_imported_users(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      user = User.find_by_id(row["email"]) || User.new
      user.attributes = row.to_hash
      unless user.save
      	puts '========================================================================================================'
      	puts '========================================================================================================'
      	puts 'NO SE GUARDÓ'
      	puts 'NO SE GUARDÓ'
      	puts 'NO SE GUARDÓ'
      	puts 'NO SE GUARDÓ'
      	puts 'NO SE GUARDÓ'
      	puts '========================================================================================================'
      	puts '========================================================================================================'
      end
    end
  end

  def open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::Csv.new(file.path)
    when ".xls" then Roo::Excel.new(file.path)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end