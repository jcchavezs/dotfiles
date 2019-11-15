# Open the Pull Request URL for your current directory's branch (base branch defaults to master)
function open_pr() {
  github_url=`git remote -v | awk '/fetch/{print $2}' | sed -Ee 's#(git@|git://)#https://#' -e 's@com:@com/@' -e 's@biz:@biz/@' -e 's%\.git$%%' | awk '/github/'`;
  branch_name=`git symbolic-ref HEAD | cut -d"/" -f 3,4`;
  pr_url=$github_url"/compare/master..."$branch_name
  echo "Creating a PR for '${branch_name}' via ${pr_url}"
  open $pr_url;
}