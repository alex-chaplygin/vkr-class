use strict;
my $enumerate = 0;
my $itemize = 0;
my $line = 0;
while (<>) {
    $line++;
    if (m/begin\{enumerate/) {
	$enumerate = 1;
    } elsif (m/end\{enumerate/) {
	$enumerate = 0;
    } elsif (m/begin\{itemize/) {
	$itemize = 1;
    } elsif (m/end\{itemize/) {
	$itemize = 0;
    } else {
	s/^\s+//;
	s/\s+$//;
	if ($enumerate && !m/\.$/) {
	    printf("Точка в конце:\n");
	    printf("%i: %s\n", $line, $_);
	}
#	if ($itemize && !m/\;$/) {
#	    printf("Двоеточие в конце:\n");
#	    printf("%i: %s\n", $line, $_);
#	}
	if ($enumerate && !m/^\\item\s+[А-Я]/ && !m/^\\item\s+[A-Z]/) {
	    printf("С заглавной буквы:\n");
	    printf("%i: %s\n", $line, $_);
	}
    }
}
