node: CP*
define: /Users/rtruswe2/Dropbox/WhRel.def

coding_query: 

1: {
Rel: ((CP* iDomsFirst !\**) AND (CP-REL* iDomsFirst !\**))
Frl: ((CP* iDomsFirst !\**) AND (CP-FRL* iDomsFirst !\**))
Car: ((CP* iDomsFirst !\**) AND (CP-CAR* iDomsFirst !\**))
X: ELSE
   }

2: {
Which: (CP* iDomsMod W* WhichForm)
What: (CP* iDomsMod W* WhatForm)
HW: (CP* iDomsMod W* WhomForm|WhoForm|WhereForm|WhitherForm|WhetherForm|HowForm|WhenForm|WhyForm|WhenceForm|WherewithForm|WhereofForm|WhereinForm|WhoseForm|WheremidForm|WhereforForm|WherethroughForm|WherebyForm|WheretoForm|WhereasForm|WhOtherForm|WhereuponForm|WhereuntoForm|WhereatForm|Tohwon|tohwan|tohwon|humeta|Humeta|humete|hulucu)
X: ELSE
   }

3: {
N: ((CP* iDomsMod W* N|NS|NPR|NPRS|N^*|NR|NR^*) AND (CP* iDomsMod W* WD) AND (WD HasSister N|NS|NPR|NPRS|N^*|NR|NR^*))
X: ELSE
   }
