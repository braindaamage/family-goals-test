module Importers
  class FamilyGoals
    def initialize file_path
      @spreadsheet = Roo::Spreadsheet.open(file_path)
      @spreadsheet.default_sheet = @spreadsheet.sheets.first
    end

    def import
      @data = {}

      parse_xlsx
      import_data
      update_users
    end

    def self.read file_path
      new(file_path)
    end

    private

      # Recorre Planilla formateando la data final
      def parse_xlsx
        2.upto(@spreadsheet.last_row).each do |row_index|
          row = info_hash(row_index)
  
          unless row.nil?
            @data[row[:name]] ||= {
              code: row[:code],
              worlds: [],
              areas: [],
              positions: []
            }

            @data[row[:name]][:worlds]    << row[:world]    if !row[:world].blank? && !@data[row[:name]][:worlds].include?(row[:world])
            @data[row[:name]][:areas]     << row[:area]     if !row[:area].blank? && !@data[row[:name]][:areas].include?(row[:area])
            @data[row[:name]][:positions] << row[:position] if !row[:position].blank? && !@data[row[:name]][:positions].include?(row[:position])
          end
        end
      end

      # Importa los datos obtenidos al modelo
      def import_data
        @data.each do |row|
          name = row.first
          family_data = row.last

          family = FamilyGoal.find_or_create_by(name: name)
          
          family_data[:worlds].each do |world|
            family_data[:areas].each do |area|
              family_data[:positions].each do |position|
                family_goal_attribute = family.family_goal_attributes.find_or_create_by(world: world, area: area, position: position)
              end
            end
          end
        end
      end

      # Actualiza la familia de los usuarios existentes
      def update_users
        User.all.each do |user|
          user.update_family_goal
        end
      end

      # obtiene los datos por fila
      def info_hash(row_index)
        if @spreadsheet.row(row_index).nil? or @spreadsheet.row(row_index).compact.empty?
          return nil
        else
          parsed_data = {}

          begin
            parsed_data[:name]      = @spreadsheet.cell(row_index, 1).present? ? @spreadsheet.cell(row_index, 1).to_s : raise
            parsed_data[:code]      = @spreadsheet.cell(row_index, 2).to_s
            parsed_data[:position]  = @spreadsheet.cell(row_index, 3).to_s
            parsed_data[:area]      = @spreadsheet.cell(row_index, 4).to_s
            parsed_data[:world]     = @spreadsheet.cell(row_index, 5).to_s
          rescue
            return nil
          end

          return parsed_data
        end
      end
  end
end