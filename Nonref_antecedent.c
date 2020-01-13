node: NP*
define: WhRel.def

coding_query:

1: {
No: ((NP* iDomsMod Q|NP-POS|NP-GEN* Q|Q+N|Q+ONE) AND (Q|Q+N|Q+ONE iDoms noForm))
Few: ((NP* iDomsMod Q|NP-POS*|NP-GEN*|QP Q*) AND (Q* iDoms fewForm))
Each: ((NP* iDoms CP-REL*|CP-CAR*) AND (NP* iDomsMod Q|NP-POS|NP-GEN*|QP|Q2* Q|Q+N|Q+ONE|Q+D|Q+NPR\$) AND (Q|Q+N|Q+ONE|Q+D|Q+NPR\$ iDoms eachForm))
Every: ((NP* iDoms CP-REL*|CP-CAR*) AND (NP* iDomsMod Q|NP-POS|NP-GEN*|QP|Q2* Q|Q+N|Q+ONE|Q+D|Q+NPR\$) AND (Q|Q+N|Q+ONE|Q+D|Q+NPR\$ iDoms everyForm))
Little: ((NP* iDoms CP-REL*|CP-CAR*) AND (NP* iDomsMod Q|NP-POS*|NP-GEN*|QP Q*) AND (Q* iDoms littleForm))
X: ELSE
   }

2: {
WhichN: ((NP* iDoms CP-REL*|CP-CAR*) AND (CP-REL*|CP-CAR* iDomsMod W* WhichForm) AND (CP-REL*|CP-CAR* iDomsMod W* N|NS|NPR|NPRS|N^*|NR|NR^*) AND (WhichForm Precedes N|NS|NPR|NPRS|N^*|NR|NR^*))
Which: ((NP* iDoms CP-REL*|CP-CAR*) AND (CP-REL*|CP-CAR* iDomsMod W* WhichForm))
Extraposed: ((NP* iDoms CP-REL*|CP-CAR*) AND (CP-REL*|CP-CAR* iDoms \*ICH\**))
Rel: (NP* iDoms CP-REL*|CP-CAR*)
X: ELSE
   }
