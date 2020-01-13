node: CP*
define: WhRel.def
add_to_ignore: PUNC|LINEBREAK|INS|META|INTJ|NP-VOC

coding_query: 

1: {
Rel: ((CP* iDomsFirst !\**) AND (CP-REL* iDomsFirst !\**))
Frl: ((CP* iDomsFirst !\**) AND (CP-FRL* iDomsFirst !\**))
Car: ((CP* iDomsFirst !\**) AND (CP-CAR* iDomsFirst !\**))
X: ELSE
   }

2: {
Which: (CP* iDomsMod W*|D+W*|ADV+W* *-which|*-sowhich)
What: (CP* iDomsMod W*|P+W* *-what|*-whatso|*-whatkin|*-whatsum|*-what.e.|*-what.h.|*-forwhat)
HW: (CP* iDomsMod W*|ADV+W*|P+W* *-who|*-sowho?|*-whom|*-whose|*-whoso|*-whosum|*-where|*-whither|*-whithersum|*-whitherward|*-whitherwardso|*-whether|*-whetherso|*-how|*-howso|*-howsumever|*-howgate|*-when|*-why|*-forwhy|*-whence|*-whereof|*-wherethrough|*-whereto|*-wherewith.w.|*-whereby|*-wherefore|*-wherein.i.|*-wherein.p.|*-whereon.p.|*-whereout|*-whereon.re.|*-wherethrough)
X: ELSE
   }

3: {
N: (CP* iDomsMod W* N|NS|NPR|NPRS|NX)
X: ELSE
   }
