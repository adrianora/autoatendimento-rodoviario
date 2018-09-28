#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <locale.h>



void cadastro();
void logar();


struct Cliente {

    char nome[30];
    char login[20];
    char senha[20];
    int contar;
};

struct Cliente cliente[30];

int main()
{
    setlocale(LC_ALL, "Portuguese");

    int opcao;

    printf("Digite (1) para fazer login: \n");
    printf("Digite (2) para fazer cadastro: \n");
    scanf("%d", &opcao);

    while(opcao < 1 || opcao > 2)
    {
        printf("\nOpcão inválida, digite novamente:");
        scanf("%d", &opcao);
    }

    if(opcao == 1)
    {
        logar();
    }
    else if(opcao == 2)
    {
        cadastro();
    }


    return 0;
}
void cadastro()
{
    int cont = 0;
    int maisClientes;
    int clientes;

    do
    {
        maisClientes = 0;

        printf("\nDigite seus dados para efetuar o cadastro:\n\n");

        printf("Nome completo: ");
        fflush(stdin);
        fgets(cliente[cont].nome,30,stdin);

        printf("Login: ");
        fflush(stdin);
        scanf("%s", &cliente[cont].login);

        printf("Senha: ");
        fflush(stdin);
        scanf("%s", &cliente[cont].senha);
        printf("\n");

        fflush(stdin);



        printf("Deseja cadastrar mais clientes? \n(1)SIM \n(2)NÃO: ");
        scanf("%d", &clientes);
        printf("\n");

        if(clientes == 1) {
            cliente[0].contar++;
            maisClientes++;
            cont++;
            system("cls");

        }else {

            system("cls");
            printf("Login!!\n\n");
            logar();
        }

    } while(maisClientes == 1);
}

void logar() {

    char login[20], senha[20];
    int contador;

    printf("\nNome de usuario: ");
    fflush(stdin);
    scanf("%s", &login);
    fflush(stdin);
    printf("Senha: ");
    fflush(stdin);
    scanf("%s", &senha);
    system("cls");

    if(strcmp(login,"adm") == 0 && strcmp(senha,"adm") == 0)
    {
        printf("\nBem vindo administrador\n\n");

    }

    for(contador = 0; contador <= cliente[0].contar; contador++)
    {
        if(strcmp(login, cliente[contador].login) == 0 && strcmp(senha, cliente[contador].senha) == 0 )
        {
            printf("Bem vindo cliente");
            printf("%s", cliente[contador].login);
        }

        else if(strcmp(login, cliente[contador].login) != 0 || strcmp(senha, cliente[contador].senha) != 0)
        {
            printf("Usuario invalido");
            logar();
        }
    }
}
