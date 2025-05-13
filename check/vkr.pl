use strict;
my $enumerate = 0;
my $itemize = 0;
my $line = 0;
my %itemize_array;
my %enumerate_array;
my $num_items = 0;

# Печать сообщения об ошибке
# $msg - сообщение
# $str - строка, где встретилась ошибка 
# $num - номер строки
sub print_msg {
    my ($msg, $str, $num) = @_;
    printf("%s\n", $msg);
    printf("%i: %s\n", $num, $str);
}

# печать сообщения о двоеточии
sub print_dot_comma {
    my ($str, $num) = @_;
    print_msg("Точка с запятой в конце:", $str, $num);
}

# печать сообщения о точке
sub print_dot {
    my ($str, $num) = @_;
    print_msg("Точка в конце:", $str, $num);
}

while (<>) {
    $line++;
    if (m/begin\{enumerate/) {
	$enumerate = 1;
    } elsif (m/end\{enumerate/) {
	$enumerate = 0;
    } elsif (m/begin\{itemize/) {
	$itemize = 1;
	$num_items = 0;
    } elsif (m/end\{itemize/) {
	$itemize = 0;
	for (my $i = 0; $i < $num_items; $i++) {
	    my $l = $itemize_array{$i};
	    if ($l !~ m/\;$/ && $i < $num_items - 1) {
		print_dot_comma($l, $line - ($num_items - $i));
	    } elsif ($l !~ m/\.$/ && $i == $num_items - 1) {
		print_dot($l, $line - ($num_items - $i));
	    }
	}
	#print(%itemize_array);
    } else {
	s/^\s+//;
	s/\s+$//;
	if ($enumerate && !m/\.$/) {
	    print_dot($_, $line);
	}
	if ($itemize) {
	    if (m/\\item/) {
		$itemize_array{$num_items} = $_;
	    } else {
		$itemize_array{$num_items} += $_;
	    }
	    if (m/\\item/) {
		$num_items++;
	    }
	}
	if ($enumerate && !m/^\\item\s+[А-Я]/) { # && !m/^\\item\s+[A-Z]/) {
	    printf("С заглавной буквы:\n");
	    printf("%i: %s\n", $line, $_);
	}
    }
}
