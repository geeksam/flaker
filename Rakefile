namespace :spec do
  CMD = "bundle exec rspec order_dependent_specs.rb --format documentation"

  task :pass do
    sh CMD
  end

  task :fail do
    sh "FAIL_ON_LAST=yep #{CMD}"
  end

  task :bisect do
    sh "FAIL_ON_LAST=yep #{CMD} --bisect=verbose"
  end
end
