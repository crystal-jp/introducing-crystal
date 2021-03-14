# frozen_string_literal: true

# Ruby のプログラム！

Dir['foo/*.rb'].sort.each do |file|
  require file
end
