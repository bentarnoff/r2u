require 'uri'
require 'colorize'

@bigboy = {
	:'docs-app-distribution' => "http://docs.pivotal.io/app-dist/",
	:'docs-appydynamics' => "http://docs.pivotal.io/appdynamics/",
	:'docs-book-cloudfoundry' => "http://docs.cloudfoundry.org/",
	:'docs-book-pivotalcf' => "http://docs.pivotal.io/",
	:'docs-bosh' => "http://bosh.io/docs/",
	:'docs-buildpacks' => ["http://docs.pivotal.io/pivotalcf/buildpacks/", "http://docs.run.pivotal.io/buildpacks/", "http://docs.cloudfoundry.org/buildpacks/"], 
	:'docs-cassandra' => "http://docs.pivotal.io/cassandra/",
	:'docs-cf-admin' => ["http://docs.pivotal.io/pivotalcf/adminguide/", "http://docs.cloudfoundry.org/adminguide/"],
	:'docs-cf-cli' => ["http://docs.pivotal.io/pivotalcf/cf-cli/", "http://docs.run.pivotal.io/cf-cli/", "http://docs.cloudfoundry.org/cf-cli/"],
	:'docs-cloudbees' => "http://docs.pivotal.io/cloudbees/Jenkins.html",
	:'docs-cloudbees-cjoc' => "http://docs.pivotal.io/cjoc/Jenkins.html",
	:'docs-cloudfoundry-concepts' => ["http://docs.pivotal.io/pivotalcf/concepts/", "http://docs.run.pivotal.io/concepts/", "http://docs.cloudfoundry.org/concepts/"],
	:'docs-deploying-cf' =>"http://docs.cloudfoundry.org/deploying/",
	:'docs-dev-guide' => ["http://docs.pivotal.io/pivotalcf/devguide/", "http://docs.run.pivotal.io/devguide/", "http://docs.cloudfoundry.org/devguide/"],
	:'docs-elk-stayupio' => "http://docs.pivotal.io/elk/",
	:'docs-gemfire-cf' => "http://docs.pivotal.io/gemfire-cf/",
	:'docs-gitlab' => "http://docs.pivotal.io/gitlab/",
	:'docs-identity' => "http://docs.pivotal.io/p-identity/",
	:'docs-jfrog' => "http://docs.pivotal.io/jfrog/",
	:'docs-klacloud' => "http://docs.pivotal.io/knowtify/",
	:'docs-loggregator' => ["http://docs.pivotal.io/pivotalcf/loggregator/", "http://docs.cloudfoundry.org/loggregator/"],
	:'docs-mongodb' => "http://docs.pivotal.io/mongodb/",
	:'docs-mysql' => "http://docs.pivotal.io/p-mysql/",
	:'docs-neo4j' => "http://docs.pivotal.io/neo4j/",
	:'docs-new-relic' => "http://docs.pivotal.io/newrelic/",
	:'docs-ops-guide' => "http://docs.pivotal.io/pivotalcf/opsguide/",
	:'docs-partners' => "http://docs.pivotal.io/partners/",
	:'docs-pcf-gsg' => "http://docs.pivotal.io/pivotalcf/getstarted/",
	:'docs-pcf-install' => "http://docs.pivotal.io/pivotalcf/customizing/",
	:'docs-pcf-mobileservices' => "http://docs.pivotal.io/mobile/",
	:'docs-phd-ds' => "http://docs.pivotal.io/pivotalhd-ds/",
	:'docs-hd-staging' => "http://pivotalhd.docs.pivotal.io/",
	:'docs-pivotalcf-console' => "http://docs.pivotal.io/pivotalcf/console/",
	:'docs-push-notifications' => "http://docs.pivotal.io/push/",
	:'docs-pws-gsg' => "http://docs.run.pivotal.io/starting/",
	:'docs-pws-release-notes' => "http://docs.run.pivotal.io/release-notes/",
	:'docs-pws-services' => "http://docs.run.pivotal.io/marketplace/",
	:'docs-rabbitmq-staging' => "http://docs.pivotal.io/rabbitmq-cf/",
	:'docs-redis' => "http://docs.pivotal.io/redis/",
	:'docs-riakcs' => "http://docs.pivotal.io/p-riakcs/",
	:'docs-running-cf' => "http://docs.cloudfoundry.org/running/",
	:'docs-services' => ["http://docs.pivotal.io/pivotalcf/services/", "http://docs.run.pivotal.io/services/", "http://docs.cloudfoundry.org/services/"],	
	:'docs-spring-cloud-data-flow' => "http://docs.pivotal.io/spring-cloud-data-flow/",
	:'docs-spring-cloud-services' => "http://docs.pivotal.io/spring-flo/",
	:'docs-spring-xd' => "http://docs.pivotal.io/spring-xd",
	:'docs-ssc-gemfire-cf' => "http://docs.pivotal.io/ssc-gemfire/",
	:'docs-tracker-pcf' => "http://docs.pivotal.io/tracker-pcf/",
	:'pcf-release-notes' => "http://docs.pivotal.io/pivotalcf/pcf-release-notes/"
}

def uri_to_repo(uri)
	parsed = URI.parse(uri)
	new_uri = parsed.to_s
	new_uri.gsub!("https", "http") if parsed.scheme == "https"
	if @bigboy.value?(new_uri)
		puts "\nThe repo for " + "#{ARGV[0]} ".green + "is " + "#{@bigboy.key(new_uri)}".red
	elsif @bigboy.values.flatten.include?(new_uri)
		arrays = @bigboy.values.select { |n| n.is_a?(Array) }
		matches = arrays.select { |n| n.include?(new_uri) }
		puts  "\nThe repo for " + "#{ARGV[0]} ".green + "is " + "#{@bigboy.key(matches.flatten)}".red
	else 
		puts "\nSorry, I can't find that URI.".magenta
	end
end

def repo_to_uri(repo)
	if @bigboy.key?(repo.to_sym)
		if @bigboy[repo.to_sym].is_a?(Array)
			puts "\nThe URIs for " + "#{ARGV[0]}".red + " are: "
			@bigboy[repo.to_sym].each { |n| puts n.green }
		else
			puts "\nThe URI for " + "#{ARGV[0]} ".red + "is " + " #{@bigboy[repo.to_sym]}".green
		end
	else
		puts "\nSorry, I can't find that repo.".magenta
	end
end

if ARGV[0] =~ URI.regexp
	uri_to_repo(ARGV[0])
elsif ARGV[0] =~ /[a-z]{3,4}-[a-z]+/
	repo_to_uri(ARGV[0])
elsif ARGV[0] == "--all"
	@bigboy.each { |k, v| puts k.to_s.red + "\n" + v.to_s.green + "\n\n" }
elsif ARGV.empty?
	puts "\nNAME:\n".bold + " r2u - A tool to convert URIs to Docs repo names, and vice versa.\n"
	puts "\nUSAGE:\n".bold + "ruby r2u.rb" + " [URI or repo name]" 
	puts "Converts a URI to a repo name, and vice versa".red
	puts "ruby r2u.rb" + " --all"  
	puts "Prints the whole hash".red
	puts "\nEXAMPLE\n".bold + "$ ruby r2u.rb docs-services"
	puts "The URIs for" + " docs-services".red + " are: "
	puts "http://docs.pivotal.io/pivotalcf/services/".green
	puts "http://docs.run.pivotal.io/services/".green
	puts "http://docs.cloudfoundry.org/services/".green
else
	puts "\nSomething went wrong. Check the spelling of your URI or repo and try again.".magenta
end