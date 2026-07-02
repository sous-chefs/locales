# frozen_string_literal: true

name 'locales'

run_list 'test::default'

cookbook 'locales', path: '.'
cookbook 'test', path: 'test/cookbooks/test'

Dir.entries('./test/cookbooks/test/recipes').select { |f| f.end_with?('.rb') }.each do |test|
  test = test.delete_suffix('.rb')
  named_run_list :"#{test}", "test::#{test}"
end
