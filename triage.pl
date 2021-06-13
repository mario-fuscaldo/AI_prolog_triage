%light symptoms
value(inflammation, 1).
value(abscess, 1).
value(irritation, 1).
value(shiver,1).
value(sting,1).
value(dizziness,1).
value(swelling,1).
value(tumefaction,1).
value(retching,1).
value(bruise,1).
value(fever,1).
value(cramp,1).
value(dysentery,1).
value(pain,1).
value(pharyngitis,1).
value(tingling,1).
value(cough,1).
value(mucus,1).
value(hypertension,1).
value(hypotension,1).
value(nausea,1).
value(pallor,1).
value(itch,1).
value(cyst,1).
value(vomit,1).

%moderate symptoms
value(rash,2).
value(wound,2).
value(possible_fracture,2).
value(visual_impediments,2).
value(ankylosis,2).
value(tachycardia ,2).
value(kidney_stones,2).
value(burn,2).
value(convulsions,2).
value(fibrillation,2).
value(hyperventilation,2).
value(stain,2).
value(infection,2).

%severe symptoms
value(exposed_fracture,4).
value(hemorrhage,4).
value(deformity,4).
value(atrophy,4).
value(catalepsy,4).
value(congestion,4).
value(sore,4).

%requires immediate treatment
value(permanent_damage,20).
value(epileptic_seizure,20).
value(asphyxia,20).
value(catatonia,20).


%multiplication value for body parts
body_part(arm,1).
body_part(shoulder,1).
body_part(forearm,1).
body_part(elbow,1).
body_part(wrist,1).
body_part(hand,1).
body_part(finger,1).
body_part(general,1.5).
body_part(leg,1.5).
body_part(knee,1.5).
body_part(foot,1.5).
body_part(thigh,1.5). 
body_part(calf,1.5).
body_part(heel,1.5).
body_part(nose,1.5).
body_part(shin,1.5).
body_part(ear,1.5).
body_part(chin,1.5).
body_part(cheek,1.5).
body_part(mouth,1.5).
body_part(back,2).
body_part(chest,2).
body_part(stomach,2).
body_part(hip,2).
body_part(head,2.5).
body_part(forehead,2.5).
body_part(face,2.5).
body_part(temple,2.5).


%pain intensity

%no pain
pain(0,0).

%slightly  painful
pain(1,1). 
pain(2,1).
pain(3,1).

%mildly painful
pain(4,2). 
pain(5,2).
pain(6,2).
pain(7,3). 

%extremely painful 
pain(8,3).
pain(9,3).
pain(10,3).

%priorities
category(white,0,6).
category(green,7,12).
category(yellow,13,18).
category(red,19,999).

%end of KB

%rule responsible to assign age bonus
bonus_age(Age,Bonus):-
    17 =< Age, 59 >= Age
    ->    Bonus = 0
    ;   Bonus = 2.

 % rule responsible for determining the category
what_category(Val):-
    category(X,Min,Max),
    Min =< Val, Max >= Val ->  
    format('you are in ~w category', [X]), nl.


%execution start
start:- loop(start).

%if loop has “n” as input do this:
loop(n) :- write('end of execution').

%for every other value of input do this:
loop(X) :-
    X\=n,
    
    %symptom verification and search of value
    write('symptom'),
    repeat,
    read(Symptom),   
    (   value(Symptom,S)
    ;   format('The symptom ~w isn\'t in the KB', [Symptom]), nl,
        write('please re-enter the symptom'),
        false),
    !,
    
    %pain verification and search of value
    write('perceived pain 1-10'),
    repeat,
    read(Pain),
    (    pain(Pain,P)
    ;   format('The value ~w isn\'t avaiable', [Location]), nl,
        write('please re-enter the value'),
        write('values accepted, 1 through 10'),
        false),
    !,
   
    %location verification and search of value
    write('location'),
    repeat,
    read(Location),
    (   body_part(Location,L)
    ;   format('The location ~w isn\'t in the KB', [Location]), nl,
        write('please re-enter the location'),
        false),
    !,
   
    %Age
    write('age'),
    read(Age),
    bonus_age(Age,A),
  
    %result calculation
    Result is ((S+P)*L)+A,

 
    
    what_category(Result),

	%check on loop condition
    write(' addd a new patient (y/n)?'),
    read(Answ),
    %recursive use of loop
loop(Answ).    

