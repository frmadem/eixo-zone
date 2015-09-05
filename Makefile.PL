use 5.018002;
use ExtUtils::MakeMaker;
use Devel::AssertOS qw(Linux);
use Devel::CheckBin;

check_bin('brctl');


# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Eixo::Zone',
    VERSION_FROM      => 'lib/Eixo/Zone.pm', # finds $VERSION
    PREREQ_PM         => {

		"Devel::CheckBin" => 0,


	}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Eixo/Zone.pm', # retrieve abstract from module
       AUTHOR         => 'root <root@>') : ()),
    LIBS              => [''], # e.g., '-lm'
    DEFINE            => '', # e.g., '-DHAVE_SOMETHING'
    INC               => '-I.', # e.g., '-I. -I/usr/include/other'
	# Un-comment this if you add C files to link with later:
    # OBJECT            => '$(O_FILES)', # link all the C files too
);
