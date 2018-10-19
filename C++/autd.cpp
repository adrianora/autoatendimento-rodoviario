#include <stdlib.h>
#include <stdio.h>
#include <conio.h>
#include <string.h>
#include <ctype.h>

#define MAXVIAGENS 50

struct cviagens

 {

    char viagem[30];
    char npassageiro[30];//nome do passageiro
    int codigodp; //codigo da passagem

 };

main (void) {


 struct cviagens menuViagens[MAXVIAGENS];

    int i, achou, quantos = 0;
    int codigodp;
    char opcao;
    char nomeviagem[30];

 do

 {

   system("cls");
   fflush(stdin);


   printf("\n1. Incluir novo cadastro de viagem\n");
   printf("\n2. Consultar destino de viagem pelo codigo da passagem\n");
   printf("\n3. Excluir um destino de viagem\n");
   printf("\n\n=======================================================\n");
   printf("\nDigite a opcao desejada:\n ");
   scanf("%c", &opcao);
   printf("\n\n=======================================================\n\n");

   switch(toupper(opcao))

   {

   case '1': // incluir novo cadastro

     {

       printf("\nIncluir novo cadastro de viagem\n");

       if(quantos < MAXVIAGENS)

       {

         printf("\nDigite o codigo da passagem: ");
         scanf("%d",&menuViagens[quantos].codigodp);
         fflush(stdin);

         printf("\nDigite o nome do passageiro: ");
         gets(menuViagens[quantos].npassageiro);
         fflush(stdin);

         printf("\nDigite o destino de viagem: ");
         gets(menuViagens[quantos].viagem);
         fflush(stdin);

         quantos++;
       }


    else {

         printf("\nErro na inclusao. O cadastro esta cheio\n");

       }

       break;

     }

   case '2'://consultar o destino pelo codigo da passagem
   {

       achou = 0;
       fflush(stdin);
       printf("\nConsultar viagem pelo nome.\n");
       printf("\nDigite o nome do destino: ");
       gets(nomeviagem);

       for(i = 0; i < quantos; i++)

       {

         if(strcmp(menuViagens[i].viagem, nomeviagem) == 0)

         {

          achou = 1;

          printf("\nNome do destino.: %s", menuViagens[i].viagem);
          printf("\nNome do Passageiro.: %s", menuViagens[i].npassageiro);
          printf("\nCodigo.......: %d", menuViagens[i].codigodp);

         }

       }

       if (!achou)

       {

         printf("\nA viagem %s nao foi encontrada no cadastro\n", nomeviagem);

       }

       break;

     }

   case '3':

     {

       printf("\nExcluir um destino de viagem\n");

       break;

     }


   }

   system("pause");
   return(0);
 }

 while(toupper(opcao) != '3');

}
