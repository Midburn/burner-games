directories %w(app config lib spec)

rspec_options = {
  cmd: "bin/rspec --fail-fast",
  all_on_pass: true,
  failed_mode: :focus 
}

guard :rspec, rspec_options do
  # watch for changes in all spec files
  watch(%r{^spec/.+_spec\.rb$})

  # re-run all specs on changes to .rb files which have global impact
  watch("spec/*_helper.rb")          { "spec" }
  watch(%r{^spec/support/(.+)\.rb$}) { "spec" }
  watch(%r{^(?:config|lib)/.+\.rb$}) { "spec" }

  # when abc/xyz.rb changes, run spec/abc/xyz_spec.rb
  watch(/^(?:app|lib)(.+)\.(?:rb|rake)$/) { |m| "spec#{m[1]}_spec.rb" }

  # run all feature specs when relevant files change
  watch("config/locales/")              { "spec/features" }
  watch(%r{^app/controllers/.+\.rb$})   { "spec/features" }

  # run all controller specs when app controller changes
  watch("app/controllers/application_controller.rb")  { "spec/controllers" }
end
