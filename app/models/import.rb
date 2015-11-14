class Import < ActiveRecord::Base
  validates :name, uniqueness: true
  validates :email, uniqueness:true
  validates :shopname, uniqueness:true

  COLUMN = ["id","shopname","location","tel","fax","postalcode","name","company","email","created_at", "updated_at"]

  def self.import(file)

    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      product = Import.find_or_initialize_by(id: row["id"])
      if product.id then
        #上書き
        attr = row.slice(*COLUMN)
        # product.attributes = attr
        # binding.pry
        product.update(attr)
      else
        # attr = row.select{|k,v| column.include?(k)}
        attr = row.slice(*COLUMN)
        product.attributes = attr
        product.save!
      end
    end
  end


  #to_csv  csvへ保存するメソッド
  def self.to_csv(option = {})
    CSV.generate(option) do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end

    def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then
      Roo::Spreadsheet.open(file.path, extension: :csv)
    when ".xls" then
      Roo::Spreadsheet.open(file.path, extension: :xls)
    when ".xlsx" then
      Roo::Spreadsheet.open(file.path, extension: :xlsx)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end



end
