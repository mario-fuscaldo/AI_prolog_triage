# AI_prolog_triage
a prolog project to simulate a triage for a covid patient


# documentation (italian):

L’Intelligenza Artificiale e il suo utilizzo sono molto più reali di quanto si possa immaginare e vengono oggi utilizzati in molti settori.
Non ci proponiamo (ancora) di popolare colonie extra-terrestri, piuttosto vogliamo replicare attraverso software e macchine comportamenti tipici dell'essere umano: l'essere pensante e intelligente.
Alcune teorie differenziano l'intelligenza in più tipi, ognuno dei quali collocato in una certa sezione del cervello: ciò ci permette di dare una definizione più ampia di intelligenza e proprio in funzione di questa si cerca di modellare un sistema in grado di modellare queste forme.
Dunque, dimostrata la versatilità di tale disciplina, possiamo renderci conto della sua applicabilità alle più svariate necessità.

TrIAge

Modellazione del problema


Da qui parte l'idea di automatizzare il processo di collocazione in fasce di priorità tipico del pronto soccorso. Ogni qual volta un soggetto si reca al pronto soccorso vi è la necessità di schedulare il problema che l'ha condotto in modo empirico per poter definire un ordine di priorità che sia proporzionale al problema riportato. Supponendo che tale meccanismo possa essere influenzato da fattori quali:

• Tipo di danno riportato 

• Intensità del dolore registrata

• Zona del corpo di interesse

• Età del soggetto in questione


Abbiamo cercato di attribuire in modo coerente il peso di ogni fattore:

• Il sintomo presentato è elencato della KB nella forma value(sinthomps, value).  Sinthomps corrisponde al nome del problema, e value a un identificativo numerico che lo colloca in un intervallo da [1,4] in base alla gravità.  

• Preso atto che il modo più comune di identificare l’intensità del dolore è quella di usare una scala da 1 a 10 (scala NRS), abbiamo così attribuito 4 fasce di valori:  

    [0]->0
    [1,2,3]->1
    [4,5,6]->2
    [7,8,9,10]->3
 
   
La zona del corpo a cui il danno si riferisce è presentata nella forma body_part(name,value). Name si riferisce al nome della zona del corpo in cui si colloca il dolore e value indica un valore tra {1, 1.5, 2, 2.5} attribuitogli, rispettivamente, in base a {arti superiori, arti inferiori, busto, testa}. Supposto che la localizzazione del problema sia di fondamentale importanza al fine di stabilirne la gravità, value si tradurrà come un fattore moltiplicativo.
    
L’età del soggetto in esame si configura come una particolare attenzione nei confronti di soggetti molto giovani o anziani le quali condizioni possono necessitare di attenzioni maggiori rispetto alle stesse condizioni di un adulto. Tale attenzione è implementata attraverso un bonus +2 per soggetti di età non compresa tra 17 e 59, che abbiamo identificato come età adulta.
    
Tali fattori sono poi sintetizzati da un'equazione che restituirà il colore della fascia che indica la priorità di accesso alle attenzioni dei medici.

    FASCIA=(SINTOMO+DOLORE)*PARTE DEL CORPO + ETA’      (1)
    
Le fasce sono strutturate secondo il Triage, sistema realmente utilizzato per definire la priorità di accesso dei pazienti al pronto soccorso. Il grado di urgenza di ogni paziente è rappresentato da un colore assegnato all'arrivo, dopo una prima valutazione del problema da parte di uno specialista, che è proprio l’entità che cercheremo di simulare.


Le fasce sono state definite nella KB come cathegory(color, min, max), dunque attraverso 4 colori e i relativi range di valori:

cathegory(white,0,6)

cathegory(green,7,12)

cathegory(yellow,13,18)

cathegory(red,19,199)

che identificano, rispettivamente, un livello di urgenza bassa, media, alta e assoluta.


Implementazione

Piuttosto che l’ordinaria query Prolog, che avrebbe dovuto avere tale forma:

    what_fascia(sinthomps, pain, body_part, age)

il programma comincia con start il quale astrae il meccanismo di interfaccia con l’utente chiedendo elemento per elemento e, al tempo stesso, consente una gestione di eventuali errori di battitura e/o grammaticali, in modo tale che si possa evitare di incombere nella situazione “tipo” nella quale, sbagliando l’inserimento di uno dei dati, si debbano re-inserire tutti dall’inizio.

Start richiama loop: loop è una regola ricorsiva che, tramite tastiera, prende in input i dati inseriti dall’utente. Ogni inserimento è controllato tramite un repeat che viene eseguito fin quando non  si trova un corrispondente della knowledge base. Presi in input tutti i dati, questi si elaborano secondo la regola (1).
L’utente inserirà, in ordine: un sintomo, il livello del dolore, la zona del corpo interessata e l’età.

Il programma chiamerà la funzione bonus_age(age, bonus) per stabilire se l’età inserita rispetta o meno le condizioni per attribuire un bonus al totale.
Segue poi il calcolo effettivo Result is ((S+P)*L)+A che sarà passato alla funzione what_category(Result) la quale darà in output il colore della fascia.
L’ultima fase del loop è quella di chiedere all’utente se vuole o meno aggiungere ulteriori pazienti add a new patient (y/n)?, esso terminerà qualora si decida di inserire il token “n”.

è possibile visualizzare un test del programma all’indirizzo: https://www.youtube.com/watch?v=qFVepg-4Xjk
