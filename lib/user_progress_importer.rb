class UserProgressImporter
  include ActiveModel::Model

  def self.attributes
    [:file,:sheet_number,:header_row]
  end

  attr_accessor *self.attributes

  def import
    xls = Roo::Spreadsheet.open(file,extension: :xlsx)
    sheet = xls.sheet(sheet_number.to_i - 1)
    courses_external_ids = sheet.row(self.header_row.to_i)[2..-1]
    courses_map = Course.where(external_id: courses_external_ids).reduce({}) do |memo,c|
      memo[c.external_id] = c
      memo
    end
    ((header_row.to_i+1)..sheet.last_row).each do |row|
      email = sheet.cell(row,sheet.first_column)
      if(user = User.find_by_email(email))
        ((sheet.first_column + 2)..sheet.last_column).each do |col|
          course_id = courses_map[sheet.cell(header_row.to_i,col)].try(:id)
          if(course_id && (subscription = user.subscriptions.find_by_course_id(course_id)))
            finished = sheet.cell(row,col).to_i == 1
            subscription.update(finished: finished)
          end
        end
      end
    end
    true
  end

end
