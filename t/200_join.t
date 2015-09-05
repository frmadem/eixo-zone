use strict;
use Eixo::Zone::Driver;

my $flags = 0 | Eixo::Zone::Driver->CLONE_NEWPID | 17;

$flags |= Eixo::Zone::Driver->CLONE_NEWNS;

my $pid = Eixo::Zone::Driver->clone(sub {

	$SIG{TERM} = sub {

		print "Me han matado\n";

		`umount /proc`;

		exit 0;
	};

	if(my $p = fork){

		print "He forkeado un proceso con pid $p\n";
	}
	else{

		while(1) { sleep(1) };
	}

	`mount -t proc proc /proc`;

	while(1) {

		sleep(1);
	}

}, $flags);

my $pid2 = fork;


unless($pid2){

	select(undef, undef, undef, 0.75);
	

	Eixo::Zone::Driver->setns(

		"/proc/$pid/ns/pid",

		0,

		sub {
			print Dumper(\@_); use Data::Dumper;
		}
	);

	Eixo::Zone::Driver->setns(

		"/proc/$pid/ns/mnt",

		0
	);

	print "Dentro del namespace de ".&Eixo::Zone::Driver::getPid."\n";

	kill("TERM", 2); sleep(1);

	opendir(D, "/proc");

	my @d = grep { $_ =~ /^\d+$/ } readdir(D);

	closedir(D);


	print "Soy $$\n";
	print "En su proc tiene : \n";
	print "$_\n" foreach(@d);

	if(kill(0, $pid)){
		print "Veo el $pid\n";
	}
	
	kill("TERM", $pid);

	exit 0;
}

waitpid($pid, 0);
