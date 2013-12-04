# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :test do
  watch(%r{^test/.+_test\.rb$})

  # Non-rails
  watch(%r{^lib/(.+)\.rb$}) { |m| "test/lib/#{m[1]}_test.rb" }
end
