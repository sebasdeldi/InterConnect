class UserImport
  include ActiveModel::Model

  attr_accessor :file


  def save(file)
  	imported_users = imported_users(file)
		if imported_users.map(&:valid?).all?
		 imported_users.each(&:save)
		  true
		else
		  imported_users.each_with_index do |user, index|
		    user.errors.full_messages.each do |message|
		      errors.add :base, "Row #{index+2}: #{message}"
		    end
		  end
		  false
		end
  end

  def imported_users(file)
    @imported_users ||= load_imported_users(file)
  end

  def load_imported_users(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      user = User.find_by_id(row["email"]) || User.new
      user.attributes = row.to_hash
      user
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