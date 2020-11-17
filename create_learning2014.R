Age      Age (in years) derived from the date of birth
Gender   Male = 1  Female = 2
Years    Year_Study   Student's year of study (Number)
Courses  How many courses are you enrolled in this semester? (Number)
Hours    How many hours are you using to study statistic in the week (Number)
Degree   Which is the degree (Insert Name) 1=SocSci,2=other
Lar      Learning as Reproducing   ~Aa+Ac+Ad
Lat      Learning as Transforming  ~Ab+Ae+Af
d_sm     Seeking Meaning           ~D03+D11+D19+D27
d_ri     Relating Ideas            ~D07+D14+D22+D30
d_ue     Use of Evidence           ~D06+D15+D23+D31
su_lp    Lack of Purpose           ~SU02+SU10+SU18+SU26
su_um    Unrelated Memorising      ~SU05+SU13+SU21+SU29
su_sb    Syllabus-boundness        ~SU08+SU16+SU24+SU32
st_os    Organized Studying        ~ST01+ST09+ST17+ST25
st_tm    Time Management           ~ST04+ST12+ST20+ST28
Deep     Deep approach             ~d_sm+d_ri+d_ue
Surf     Surface approach          ~su_lp+su_um+su_sb
Stra     Strategic approach        ~st_os+st_tm
Deep_adj Deep_adjusted             ~Deep/12
Surf_adj Surface_adjusted          ~Surf/12
Stra_adj Strategic_adjusted        ~Stra/8
Su_Ti    Transmitting information (related to Surf) ~Ca+Cd+Ce+Ch
D_Su     Supporting understanding (related to Deep) ~Cb+Cc+Cf+Cg
StatConf Confidence in doing statistics    ~Da+Df
Value    Value of statistics               ~Db+Dj
Interest Interest in statistics            ~Dc+De
MathConf Confidence in doing math          ~Dd+Di
Affect   Affect toward statistics          ~Dg+Dh
Attitude Global attitude toward statistics ~Da+Db+Dc+Dd+De+Df+Dg+Dh+Di+Dj
FSVdeep  Factor score (Varimax rotation) Deep
FSVstra  Factor score (Varimax rotation) Strategic
FSVsurf  Factor score (Varimax rotation) Surface
FSOdeep  Factor score (Oblimin rotation) Deep
FSOstra  Factor score (Oblimin rotation) Strategic
FSOsurf  Factor score (Oblimin rotation) Surface
Points   Yhteispisteet (max kaikista)
Fails    Hylkyjen lkm ennen läpäisyä (toimii paremmin Italian datassa!)


Mittareiden taustaa:

Mittarit A ja C vastaavat osia A ja C ASSIST-lomakkeessa
(Approaches and Study Skills Inventory for Students)
http://www.etl.tla.ed.ac.uk/publications.html#measurement
ja D:n pohjana on SATS (Survey of Attitudes Toward Statistics)
http://www.evaluationandstatistics.com/

Tutkimuksessa keskeisimmällä sijalla olleen mittarin (ASSIST B)
osiot on nimetty siten, että niistä pystyy näkemään yhteyden
ajateltuun ulottuvuuteen (Deep/SUrface/STrategic). ASSIST:in
alkuperäisen mittarin (52 osiota) sijaan tutkimuksessa käytettiin
ryhmän aiemmin lyhentämää versiota, johon kuului vain 32 osiota.

Mittarien A,C,D suomennokset: Kimmo Vehkalahti ja Liisa Myyry.
Mittarin B suomennos (alun perin): Miia Erkkilä (2008), ks.
http://lib.tkk.fi/Raportit/2009/isbn9789512297719.pdf
(pieniä säätöjä sanamuotoihin / KV & LM & Reijo Sund 2014).

Taustoista osa on muiden maiden kanssa yhteisiä, osa omia.
JYTOPKYS2-data.txt sisältää kaikkien 183 vastaajan tiedot.
Opiskelijanumero on korvattu anonyymilla tunnisteella (Id).
Puuttuvat tiedot on merkitty koodilla "NA" (Not Applicable).

Aineisto tulee vapaaseen opetuskäyttöön syksyn 2016 kurssilla
sekä uudella, 1/2017 alkavalla englanninkielisellä kurssilla
Introduction to Open Data Science.

Alustavia tuloksia (esitetty 60. ISI-kokouksessa Riossa 7/2015):

http://www.slideshare.net/kimmovehkalahti/the-relationship-between-learning-approaches-and-students-achievements-in-an-introductory-statistics-course-in-finland

--------------------------------------------------------------

Summamuuttujien muodostamissäännöt (A, B, C, D) ym. ohjeita
in English (see the web links above for more information):

(VAR expressions are related to Survo R, which was used for
computations, calculations, analyses, and visualizations.)

*/ACTIVATE +   / (in Survo, all other lines are just comments)
*
+VAR Lar:1=Aa+Ac+Ad    TO ASSIST2015FI
+VAR Lat:1=Ab+Ae+Af
*
*Lar       Aa + Ac + Ad
*Learning as Reproducing
*Lat       Ab + Ae + Af
*Learning as Transforming
*
+VAR d_sm:1=D03+D11+D19+D27
+VAR d_ri:1=D07+D14+D22+D30
+VAR d_ue:1=D06+D15+D23+D31
+VAR su_lp:1=SU02+SU10+SU18+SU26
+VAR su_um:1=SU05+SU13+SU21+SU29
+VAR su_sb:1=SU08+SU16+SU24+SU32
+VAR st_os:1=ST01+ST09+ST17+ST25
+VAR st_tm:1=ST04+ST12+ST20+ST28
+VAR Deep:1=d_sm+d_ri+d_ue
+VAR Surf:1=su_lp+su_um+su_sb
+VAR Stra:1=st_os+st_tm
+VAR Deep_adj:4=Deep/12
+VAR Surf_adj:4=Surf/12
+VAR Stra_adj:4=Stra/8
*
*d_sm      D03 + D11 + D19 + D27
*Seeking Meaning
*d_ri      D07 + D14 + D22 + D30
*Relating Ideas
*d_ue      D06 + D15 + D23 + D31
*Use of Evidence
*su_lp     SU02 + SU10 + SU18 + SU26
*Lack of Purpose
*su_um     SU05 + SU13 + SU21 + SU29
*Unrelated Memorising
*su_sb     SU08 + SU16 + SU24 + SU32
*Syllabus-boundness
*st_os     ST01 + ST09 + ST17 + ST25
*Organized Studying
*st_tm     ST04 + ST12 + ST20 + ST28
*Time Management
*Deep      d_sm + d_ri + d_ue (min = 12, max = 60)
*Deep approach
*Surface   su_lp + su_um + su_sb (min =12, max = 60)
*Surface approach
*Strategic           st_os + st_tm (min = 8, max = 40)
*Strategic approach
*Deep_adjusted       Deep/12 (min = 1, max = 5) - previous Deep score divided by the number of the items of the scale
*Surface_adjusted    Surface/12 (min = 1, max = 5) - previous Surface score divided by the number of the items of the scale
*Strategic_adjusted  Strategic/8 (min = 1, max = 5) - previous Strategic score divided by the number of the items of the scale
*
+VAR Su_Ti:1=Ca+Cd+Ce+Ch
+VAR D_Su:1=Cb+Cc+Cf+Cg
*
*Su_Ti     Ca + Cd + Ce + Ch
*Supporting understanding (related to a deep approach)
*D_Su      Cb + Cc + Cf + Cg
*Transmitting information (related to a surface approach)
*
*Obs!! Df and Dh must be reversed first:
*
+VAR Df:1=6-Df
+VAR Dh:1=6-Dh
*
+VAR StatConf:1=Da+Df
+VAR Value:1=Db+Dj
+VAR Interest:1=Dc+De
+VAR MathConf:1=Dd+Di
+VAR Affect:1=Dg+Dh
+VAR Attitude:1=Da+Db+Dc+Dd+De+Df+Dg+Dh+Di+Dj
*
*Stat_Conf           Da + Df
*Confidence in doing statistics
*Value     Db + Dj
*Value of statistics
*Interest  Dc + De
*Interest in statistics
*Math_Conf           Dd + Di
*Confidence in doing math
*Affect    Dg + Dh
*Affect toward statistics
*Attitude  Da + Db + Dc + Dd + De + Df + Dg + Dh + Di + Dj
*Global attitude toward statistics
*
+
