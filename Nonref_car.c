node: IP*
define: WhRel.def

coding_query:

1: {
No: ((IP* iDomsMod NP*|PP*|A* NP*) AND (NP* iDomsMod Q|NP-POS|NP-GEN* Q|Q+N|Q+ONE) AND (Q|Q+N|Q+ONE iDoms noForm))
Few: ((IP* iDomsMod NP*|PP*|A* NP*) AND (NP* iDomsMod Q|NP-POS*|NP-GEN*|QP Q*) AND (Q* iDoms fewForm))
Each: ((IP* iDomsMod NP*|PP*|A* NP*) AND (NP* iDomsMod Q|NP-POS|NP-GEN*|QP|Q2* Q|Q+N|Q+ONE|Q+D|Q+NPR\$) AND (Q|Q+N|Q+ONE|Q+D|Q+NPR\$ iDoms eachForm))
Every: ((IP* iDomsMod NP*|PP*|A* NP*) AND (NP* iDomsMod Q|NP-POS|NP-GEN*|QP|Q2* Q|Q+N|Q+ONE|Q+D|Q+NPR\$) AND (Q|Q+N|Q+ONE|Q+D|Q+NPR\$ iDoms everyForm))
Little: ((IP* iDomsMod NP*|PP*|A* NP*) AND (NP* iDomsMod Q|NP-POS*|NP-GEN*|QP Q*) AND (Q* iDoms littleForm))
X: ELSE
   }

2: {
WhichN: ((IP* iDoms CP-CAR|CP-CAR-SPE) AND (CP-CAR|CP-CAR-SPE iDomsMod W* WhichForm) AND (CP-CAR|CP-CAR-SPE iDomsMod W* N|NS|NPR|NPRS|N^*|NR|NR^*) AND (WhichForm Precedes N|NS|NPR|NPRS|N^*|NR|NR^*))
Which: ((IP* iDoms CP-CAR|CP-CAR-SPE) AND (CP-CAR|CP-CAR-SPE iDomsMod W* WhichForm))
Rel: (IP* iDoms CP-CAR|CP-CAR-SPE)
X: ELSE
   }
