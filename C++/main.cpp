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
        if (usuario.compare(user[i]) == 0 && senha.compare(user[i]) == 0) {
			user_logged = i;
            cout << "Usuario validado com sucesso" << endl;
            main();
         }
    }

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
    string new_user, new_pass;
    
    cout << "Digite seus dados para efetuar o cadastro:\n" << endl;
    cout << "Usuario:";
    cin >> new_user;
    cout << "Senha:";
    cin >> new_pass;
    
    for (int i = 0; i <= id_user; i++) {
        if (new_user.compare(user[i]) == 0) {
            cout << "\nUsuario ja existe no sistema!" << endl;
            cout << "1. Tentar novamente" << endl;
            cout << "2. Voltar" << endl;
            cout << "\nOpcao: " << endl;
            cin >> option;
            
            do {
                switch(option) {
                    case 1:
                        subscribe();
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
    
    user[id_user] = new_user;
    pass[id_user] = new_pass;
    id_user ++;
    cout << "\nCadastro efetuado com sucesso!" << endl;
        
    main();
    
    
}
}


