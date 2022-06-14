% Pro-Wordle! project

main:-
	write('Welcome to Pro-Wordle!'),nl,
	write('----------------------'),nl,nl,
	build_kb,
	play.

build_kb:-
	write('Please enter a word and its category on separate lines:'),nl,
	read(X),
	(	(X==done);
		read(Y),
		assert(word(X,Y)),
		build_kb
		).

play:-
	write('The available categories are: '),categories(X),write(X),nl,
	checkCategory,
	checkLength,
	write('Game started. You have '),guess(Guess),write(Guess),write(' guesses.'),nl,
	nl,
	wordGuess.




checkCategory:-
	categories(X),
	write('Choose a category:'),nl,
	read(Category),
	(
		(member(Category,X),assert(chosenCategory(Category)));
		write('This category does not exist.'),nl,
		checkCategory
		).

checkLength:-
	write('Choose a length:'),nl,
	read(Length),
	(
		(available_length(Length),assert(chosenlength(Length)),Guesses is Length+1,assert(guess(Guesses));
		write('There are no words of this length.'),nl,
		checkLength
		)).

wordGuess:-
	chosenlength(Length),
	Guess is Length+1,
	wordGuess1(Guess).



wordGuess1(Guess):-
	chosenCategory(Category),
	chosenlength(Length),
	write('Enter a word composed of '),write(Length),
	write(' letters:'),nl,
	X1 is Guess-1 ,
	read(Word),atom_chars(Word,X),pick_word(W,Length,Category),
	(	
		( 
		

		X1==0,Word\=W,
		write('You lose!'));

(
		(	

		(\+length(X,Length),write('Word is not composed of '),write(Length),write(' letters. Try again.'),
		 nl,
		 write('Remaining Guesses are '),write(Guess),nl,
		 wordGuess1(Guess))
		;
			(

			atom_chars(W,Y),
			correct_letters(X,Y,CL),
			correct_positions(X,Y,CP),
			X\=Y,
			write('Correct letters are: '),write(CL),nl,
			write('Correct letters in correct positions are: '),write(CP),nl,
			write('Remaining Guesses are '),write(X1),nl,
			wordGuess1(X1));

			(	
				Word=W,
				write('You Win!')
			)
		))).





	



is_category(C):-word(_,C).

categories(X):-

	findall(C,is_category(C),L),
	list_to_set(L,X).

available_length(L):-
	word(C,_),
	atom_chars(C,X),
	length(X,L).

pick_word(W,L,C):-
	word(W,C),
	atom_chars(W,X),
	length(X,L).



correct_letters(L1,L2,C):-
	intersection(L2,L1,CL),list_to_set(CL,C),!.

getpos(X,[X|_],0).
getpos(X,[H|T],N):-
	member(X,[H|T]),
	X\=H,
	getpos(X,T,N1),
	N is N1+1.




correct_positions([],[],[]).
correct_positions([],_,[]).
correct_positions(_,[],[]).
correct_positions([X|A],[X|B],[X|C]):-
	correct_positions(A,B,C).
correct_positions([X|A],[Y|B],C):-
	X\=Y,
	correct_positions(A,B,C),!.























	


