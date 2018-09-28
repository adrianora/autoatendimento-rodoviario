#include <iostream>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <locale.h>

using namespace std;

int id_user = 0;
string user[30], pass[30];

int user_logged = -1;
int option = -1;

int main() {
	void login();
	void subscribe();

	cout << "======================" << endl;
	cout << "----- Bem vindo! -----" << endl;
	cout << "======================" << endl;
	cout << "Terminais disponiveis:" << endl;
	cout << "1. Login" << endl;
    cout << "2. Cadastro" << endl;
	cout << "3. Sair do terminal" << endl;
	do {
	    cout << "\nOpcao: ";
		cin >> option;
		switch(option) {
			case 1:
				login();
				break;
			case 2:
				subscribe();
				break;
			case 3:
				cout << "Volte sempre!\n";
				break;
			default:
			    cout << "Opcao invalida!" << endl;
			    break;
		}
	} while (option != 3);
}
 
/* LOGIN */

void login() {
    string usuario, senha;
    
    cout << "Digite suas credenciais:" << endl;
    cout << "Usuario: ";
    cin >> usuario;
    cout << "Senha: ";
    cin >> senha;

	for (int i = 0; i <= id_user; i++) {
        if (usuario.compare(user[i]) == 0 && senha.compare(user[i])) {
			user_logged = i;
            cout << "Usuario validado com sucesso" << endl;
            main();
         }
    }

	void login();
	cout << "\nUsuario nao cadastrado!" << endl;
	cout << "1. Tentar novamente" << endl;
	cout << "2. Voltar" << endl;
	
	do {
	    cout << "\nOpcao: ";
	    cin >> option;
	    
	    switch(option) {
	        case 1:
	            login();
	            break;
	        case 2:
	            main();
	            break;
	        default:
	            cout << "Opcao invalida!" << endl;
	            break;
	    }
	} while (option != 2);
}

void subscribe()
{
	void login();

    cout << "Digite seus dados para efetuar o cadastro:\n" << endl;
    cout << "Usuario:";
    cin >> user[id_user];
    cout << "Senha:";
    cin >> pass[id_user];

    id_user += 1;

    cout << "Cadastro efetuado com sucesso: \n" << endl;

    login();
}
