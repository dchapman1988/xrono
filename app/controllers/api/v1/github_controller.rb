class Api::V1::GithubController < ApplicationController

  skip_before_filter :authenticate_user!, :only => [:payload]
  def payload
 #   {"pusher"=>{"name"=>"adamgamble", "email"=>"adamgamble@gmail.com"}, "repository"=>{"name"=>"college_picks", "size"=>2064, "has_wiki"=>true, "created_at"=>"2011/11/24 21:24:54 -0800", "private"=>false, "watchers"=>1, "language"=>"Ruby", "fork"=>false, "url"=>"https://github.com/adamgamble/college_picks", "pushed_at"=>"2011/11/28 21:06:40 -0800", "open_issues"=>0, "has_downloads"=>true, "has_issues"=>true, "homepage"=>"", "description"=>"", "forks"=>1, "owner"=>{"name"=>"adamgamble", "email"=>"adamgamble@gmail.com"}}, "forced"=>true, "after"=>"60466fbc44959a4f9a338adfee987c942b169a7e", "deleted"=>false, "commits"=>[{"added"=>[], "modified"=>["README"], "timestamp"=>"2011-11-28T21:06:33-08:00", "author"=>{"name"=>"Adam Gamble", "username"=>"adamgamble", "email"=>"adamgamble@gmail.com"}, "removed"=>[], "url"=>"https://github.com/adamgamble/college_picks/commit/60466fbc44959a4f9a338adfee987c942b169a7e", "id"=>"60466fbc44959a4f9a338adfee987c942b169a7e", "distinct"=>true, "message"=>"touched readme"}], "ref"=>"refs/heads/feature/testing_branch", "before"=>"0000000000000000000000000000000000000000", "compare"=>"https://github.com/adamgamble/college_picks/commit/60466fb", "created"=>true}
    payload = JSON.parse(params["payload"])
    user = User.find_by_email payload["pusher"]["email"]
    ticket = Ticket.find_by_git_branch_name payload["ref"].gsub("refs/heads/","")
    ticket.comments.create(:user_id => user.id, :github_payload_hash => payload, :active => true)
    render :nothing => true, :status => 200
  rescue
    render :nothing => true, :status => 200
  end
end
