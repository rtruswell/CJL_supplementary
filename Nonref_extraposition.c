node: IP*
define: WhRel.def

coding_query:

1: {
No: ((IP* iDomsMod NP*|PP*|A* NP*) AND (NP* iDomsMod Q|NP-POS|NP-GEN* Q|Q+N|Q+ONE) AND (Q|Q+N|Q+ONE iDoms noForm) AND (NP* iDoms CP-REL*|CP-CAR*) AND (CP-REL*|CP-CAR* iDoms \*ICH\**))
Few: ((IP* iDomsMod NP*|PP*|A* NP*) AND (NP* iDomsMod Q|NP-POS*|NP-GEN*|QP Q*) AND (Q* iDoms fewForm) AND (NP* iDoms CP-REL*|CP-CAR*) AND (CP-REL*|CP-CAR* iDoms \*ICH\**))
Each: ((IP* iDomsMod NP*|PP*|A* NP*) AND (NP* iDoms CP-REL*|CP-CAR*) AND (NP* iDomsMod Q|NP-POS|NP-GEN*|QP|Q2* Q|Q+N|Q+ONE|Q+D|Q+NPR\$) AND (Q|Q+N|Q+ONE|Q+D|Q+NPR\$ iDoms eachForm) AND (CP-REL*|CP-CAR* iDoms \*ICH\**))
Every: ((IP* iDomsMod NP*|PP*|A* NP*) AND (NP* iDoms CP-REL*|CP-CAR*) AND (NP* iDomsMod Q|NP-POS|NP-GEN*|QP|Q2* Q|Q+N|Q+ONE|Q+D|Q+NPR\$) AND (Q|Q+N|Q+ONE|Q+D|Q+NPR\$ iDoms everyForm) AND (CP-REL*|CP-CAR* iDoms \*ICH\**))
Little: ((IP* iDomsMod NP*|PP*|A* NP*) AND (NP* iDoms CP-REL*|CP-CAR*) AND (NP* iDomsMod Q|NP-POS*|NP-GEN*|QP Q*) AND (Q* iDoms littleForm) AND (CP-REL*|CP-CAR* iDoms \*ICH\**))
X: ELSE
   }

2: {
WhichN: ((IP* iDomsMod NP*|PP*|A* NP*) AND (NP* iDoms [1]CP-REL*|CP-CAR*) AND ([1]CP-REL*|CP-CAR* iDoms \*ICH\**) AND (\*ICH\** SameIndex [2]CP-REL*|CP-CAR*) AND ([2]CP-REL*|CP-CAR* iDomsMod W* WhichForm) AND ([2]CP-REL*|CP-CAR* iDomsMod W* N|NS|NPR|NPRS|N^*|NR|NR^*) AND (WhichForm Precedes N|NS|NPR|NPRS|N^*|NR|NR^*))
Which: ((IP* iDomsMod NP*|PP*|A* NP*) AND (NP* iDoms [1]CP-REL*|CP-CAR*) AND ([1]CP-REL*|CP-CAR* iDoms \*ICH\**) AND (\*ICH\** SameIndex [2]CP-REL*|Cp-CAR*) AND ([2]CP-REL*|CP-CAR* iDomsMod W* WhichForm))
OtherExtraposed: ((IP* iDomsMod NP*|PP*|A* NP*) AND (NP* iDoms CP-REL*|CP-CAR*) AND (CP-REL*|CP-CAR* iDoms \*ICH\**))
X: ELSE
   }
