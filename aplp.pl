:- dynamic
	usuario(_,_),
	terminal(_,_).
:-[mensagens].
:- initialization(main).	


terminal(1, "CAMPINA GRANDE",1.2).
terminal(2, "CAJAZEIRAS",2.3).
terminal(3, "SOUSA",1.4).
terminal(4, "JOAO PESSOA",1.5).


empresas("Nacional turismo",1).
empresas("Tomaz turismo",1).
empresas("guanabara",1).
empresas("tiozinho turismo",1).
empresas("avianca",1).
empresas("pabllo vitar tuor",2).
empresas("argetina tuor",2).
empresas("banks confusoes",1).
empresas("companhia nacional",3).
empresas("Nacional turismo",4).
empresas("Tomaz turismo",4).
empresas("guanabara",2).
empresas("tiozinho turismo",2).
empresas("avianca",4).
empresas("pabllo vitar tuor",3).
empresas("argetina tuor",4).
empresas("banks confusoes",3).
empresas("companhia nacional",3).



destinos("CAMPINA GRANDE", "JOAO PESSOA","1:40",1).
destinos("CAMPINA GRANDE", "CAJAZEIRAS","2:20",1).
destinos("CAMPINA GRANDE", "SOUSA","3:00",1).
destinos("JOAO PESSOA", "CAMPINA GRANDE","1:40",2).
destinos("JOAO PESSOA", "SOUSA","1:40",2).
destinos("JOAO PESSOA",  "CAJAZEIRAS","1:40",2).
destinos("SOUSA", "CAMPINA GRANDE","1:40",3).
destinos("SOUSA", "JOAO PESSOA","1:40",3).
destinos("SOUSA",  "CAJAZEIRAS","1:40",3).



%---------------Menu principal.

executaMenu():-
	exibeMenuPrincipal(),
	read(OPCAO),nl,
	sw(OPCAO).
	


	
%--------------Opcões Menu principal.------------

sw(2):-
	write("Digite os seguintes dados para realizar o cadastro :"),nl,
	write("Usuario: "),nl,
	read(NOME),
	write("Senha:  "),nl,
	read(SENHA),
    adicionaUsuario(NOME,SENHA).
sw(1):-
	write("Digite suas credenciais:"),nl,
    write( "Usuario: "),nl,
    read(NOME),
    write( "Senha: "),nl,
    read(SENHA),
    logar(NOME, SENHA).

sw(3):- write("Terminal encerrado"),nl,nl.
    
sw(_):-

	executaMenu().
logar(NOME, SENHA):-
	call(usuario(NOME,SENHA)), !,
    write('Usuario validado com sucesso'),nl,nl,menuUsuario();
	write('Usuario inexistente ou dados incorretos'),nl,nl,executaMenu().

adicionaUsuario(NOME,SENHA):-
	call(usuario(NOME,_)), !,
    write("usuario adicionado com sucesso! (✿ ◠ ‿ ◠ )"),nl, nl,menuUsuario();
	assertz(usuario(NOME,SENHA)),executaMenu().

exibeMenuPrincipal():-
	write("======================"),nl, 
	write("----- Bem vindo! -----" ),nl,
	write( "======================" ),nl,
	write( "Escolha uma opcao abaixo disponiveis:" ),nl,
	write("1. Login" ),nl,
    write( "2. Cadastro" ),nl,
	write("3. Sair do terminal" ),nl.
	
	
menuUsuario():-
		write("Bem-vindo"),nl, 
		write("Lista de terminais disponiveis"),nl,
		write("1. CAMPINA GRANDE"),nl,
		write("2. CAJAZEIRAS"),nl,
		write("3. SOUSA"),nl,
		write("4. JOAO PESSOA"),nl,nl,
		write("Qualquer outra opcao pra encerrar a sessão"),nl,
		write("Digite a opcao do terminal desejado"),nl,
		read(OP),
		swUser(OP).
		
swUser(1):-
	write("Bem-vindo ao terminal de "),
	terminal(1,NOME,TAXA),
	write(NOME), nl,
	write("Para este terminal temos as seguintes empresas cadastradas:"),nl,nl,
	
	
	forall(empresas(X,1), format('Empresa: ~w~n', [X,1])),nl,nl,
	write("Temos os seguintes destinos para este terminal:"),nl,nl,
	forall(destinos(X,Y,Z,1), format('De: ~w~nPara:~w~nTempo: ~w~n~n', [X,Y,Z,1])),nl,
	write("Taxa de embarque:"),write(TAXA),nl,nl,
	write("1. Guichê de Autoatendimento"),nl,
	write("2. Sair"),nl,
	read(OPCAO),
	swAutoAtendimento(OPCAO,1).

swUser(2):-
	write("Bem-vindo ao terminal de "),
	terminal(2,NOME,TAXA),
	write(NOME), nl,
	write("Para este terminal temos as seguintes empresas cadastradas:"),nl,nl,
	
	
	forall(empresas(X,2), format('Empresa: ~w~n', [X,1])),nl,nl,
	write("Temos os seguintes destinos para este terminal:"),nl,nl,
	forall(destinos(X,Y,Z,2), format('De: ~w~nPara:~w~nTempo: ~w~n~n', [X,Y,Z,2])),nl,
	write("Taxa de embarque:"),write(TAXA),nl,nl,
	write("1. Guichê de Autoatendimento"),nl,
	write("2. Sair"),nl,
	read(OPCAO),
	swAutoAtendimento(OPCAO,2).
swUser(3):-
	write("Bem-vindo ao terminal de "),
	terminal(3,NOME,TAXA),
	write(NOME), nl,
	write("Para este terminal temos as seguintes empresas cadastradas:"),nl,nl,
	
	forall(empresas(X,3), format('Empresa: ~w~n', [X,4])),nl,nl,
	write("Temos os seguintes destinos para este terminal:"),nl,nl,
	forall(destinos(X,Y,Z,4), format('De: ~w~nPara:~w~nTempo: ~w~n~n', [X,Y,Z,4])),nl,
	write("Taxa de embarque:"),write(TAXA),nl,nl,
	write("1. Guichê de Autoatendimento"),nl,
	write("2. Sair"),nl,
	read(OPCAO),
	swAutoAtendimento(OPCAO,3).	
swUser(4):-
	write("Bem-vindo ao terminal de "),
	terminal(4,NOME,TAXA),
	write(NOME), nl,
	write("Para este terminal temos as seguintes empresas cadastradas:"),nl,nl,
	
	
	forall(empresas(X,4), format('Empresa: ~w~n', [X,4])),nl,nl,
	write("Temos os seguintes destinos para este terminal:"),nl,nl,
	forall(destinos(X,Y,Z,4), format('De: ~w~nPara:~w~nTempo: ~w~n~n', [X,Y,Z,4])),nl,
	write("Taxa de embarque:"),write(TAXA),nl,nl,
	write("1. Guichê de Autoatendimento"),nl,
	write("2. Sair"),nl,
	read(OPCAO),
	swAutoAtendimento(OPCAO,4).				
swUser(_):-
	write("Opcao invalida"),nl,nl,
	menuUsuario().
		
swAutoAtendimento(1,1):-
	write("Opcoes disponiveis:"),nl,
	write("1. Gerar Ticket"),nl,
	write("2. Consulta Tickets"),nl,
	write("3. Cancela Ticket"),nl.
			
auto(1):-
	write("digite o destino da viagem"),nl,
	read(DESTINO),nl,nl,
	write(DESTINO),nl,
	write('Ticket cadastrado com sucesso').
auto(2):-
	write("Aqui pode ser escrito a função de pesquisar"),nl,nl.
auto(_):- main().
		
main:-
executaMenu(),
halt(0).
