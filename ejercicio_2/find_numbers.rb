# Busca recursviamente dos números del array que sumen el target
def find_number numbers = [], target = nil, index1 = 0
  raise "Target no puede estar en blanco" if target.nil?
  if numbers.count > 1
    first = numbers.slice!(0)
    index2 = nil
    numbers.each_with_index do |number, index|
      if (first + number) == target
        index2 = index1 + index + 1 and break
      end
    end
    if index2.nil?
      find_number(numbers, target, index1 + 1)
    else
      puts "index1=#{index1}, index2=#{index2}"
    end
  else
    puts "No se encontraron coincidencias"
  end
end