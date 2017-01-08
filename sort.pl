use strict;
use Cwd;
use Git;

sub commitDate
  {
      my $file = $_[0];
      my $version = Git::command_oneline('log', '-1', '--format=%ct', $file);
      return $version;
  }

## read in text files
sub sortByCommit
  {
  	my $dir = $_[0]; ## argument passed in
  	opendir (DIR, $dir)||die "Failed to open target directory";
  	my @dir= grep { $_ ne '.' && $_ ne '..' && $_=~/\.txt$/}  readdir(DIR);
  	closedir(DIR);
	@dir = sort { commitDate($b) <=> commitDate($a) } (@dir);

  return @dir;	  
  }

print sortByCommit(getcwd); 
